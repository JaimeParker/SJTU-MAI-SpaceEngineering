# Homework 5

仅供参考，不作为正式答案（开摆）

* Outline your approach to generate GNSS codes, e.g., GPS L1C/A, L2C(CM or CL), L5 (I or Q), B1I, B2a(data or pilot), B3I. Please refer to ICD for modulation specifications.
* Generate two PRN code samples and compute their cross-correlations and each of their own autocorrelation. Check with the table to see if the auto-correlation and cross-correlation values
  agree with the ones listed in the table. Why?

第一题可以找到一个仓库，很完善：https://github.com/pmonta/GNSS-DSP-tools

对于提到的GPS l2cl（不知道什么东西），有如下代码：

```python
#!/usr/bin/env python

import optparse

import numpy as np

import gnsstools.gps.l2cl as l2cl
import gnsstools.nco as nco
import gnsstools.io as io

#
# Acquisition search
#

def search(x,prn,doppler,l2cm_code_phase,ms):
  blocks = ms//20
  n = int(fs*0.020)
  w = nco.nco(-doppler/fs,0,n)
  incr = l2cl.chip_rate/fs
  m_metric,m_k = 0,0
  for k in range(75):
    q = 0
    for block in range(blocks):
      c = l2cl.code(prn,(k+block)*10230+l2cm_code_phase,0,incr,n)
      p = x[n*block:n*(block+1)]*c*w
      q = q + np.absolute(np.sum(p))
    if q>m_metric:
      m_metric = q
      m_k = k
  return m_metric,m_k

#
# main program
#

parser = optparse.OptionParser(usage="""acquire-gps-l2cl.py [options] input_filename sample_rate carrier_offset prn doppler l2cm_code_phase
Acquire GPS L2CL code phase given L2CM acquisition results
Examples:
  Acquire an L2CL signal using standard input with sample rate 69.984 MHz, carrier offset -0.127126 MHz, PRN 30, Doppler 1618.0 Hz, and L2CM code phase 8317.2 chips:
    acquire-gps-l2cl.py /dev/stdin 69984000 -9334875 -127126 30 1618.0 8317.2
Arguments:
  input_filename    input data file, i/q interleaved, 8 bit signed
  sample_rate       sampling rate in Hz
  carrier_offset    offset to L2C carrier in Hz (positive or negative)
  prn               PRN
  doppler           Doppler (as obtained from e.g. L2CM acquisition)
  l2cm_code_phase   L2CM code phase""")

parser.disable_interspersed_args()

parser.add_option("--time", type="int", default=40, help="integration time in milliseconds (default %default)")

(options, args) = parser.parse_args()

filename = args[0]
fs = float(args[1])
coffset = float(args[2])
prn = int(args[3])
doppler = float(args[4])
l2cm_code_phase = float(args[5])
ms = options.time

# read first portion of file

ms_pad = ms + 5
n = int(fs*0.001*ms_pad)
fp = open(filename,"rb")
x = io.get_samples_complex(fp,n)

nco.mix(x,-coffset/fs,0)

metric,k = search(x,prn,doppler,l2cm_code_phase,ms)
print('%f %f'%(10230*k+l2cm_code_phase,metric))
```

还需要一些PRN之类的输入文件，在这里不做寻找；

另有一个MATLAB写的仓库：https://github.com/danipascual/GNSS-matlab
