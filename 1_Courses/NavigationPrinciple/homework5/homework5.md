# Homework 5

* Outline your approach to generate GNSS codes, e.g., GPS L1C/A, L2C(CM or CL), L5 (I or Q), B1I, B2a(data or pilot), B3I. Please refer to ICD for modulation specifications.
* Generate two PRN code samples and compute their cross-correlations and each of their own autocorrelation. Check with the table to see if the auto-correlation and cross-correlation values
  agree with the ones listed in the table. Why?

```python
#!/usr/bin/env python

import optparse

import numpy as np

import gnsstools.gps.l2cl as l2cl
import gnsstools.nco as nco
import gnsstools.io as io

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
