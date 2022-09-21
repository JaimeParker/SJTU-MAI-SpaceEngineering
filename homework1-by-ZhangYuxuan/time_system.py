'''
author：Zhang Yuxuan
localtime->BDStime->GPStime for any time
'''

class timetrans (object) :

    def __init__(self, local_time):
        self.local_time = local_time
        self.year = int(self.local_time[0])
        self.month = int(self.local_time[1])
        self.day = int(self.local_time[2])
        self.hour = int(self.local_time[3])
        self.min = int(self.local_time[4])
        self.sec = int(self.local_time[5])
        assert (0 <= self.hour < 60) & (0 <= self.min < 60) & (0 <= self.sec < 60) & (0 <= self.day < 31) & (0 < self.month < 13)

    def local_time2UTC(self):
        UTC_hour = (self.hour-8)
        if UTC_hour >= 0:
            self.hour = UTC_hour
        else:
            self.day = self.day - 1
            if self.day < 0:
                self.month -= 1
                if self.month < 0:
                    self.year -= 1
            self.hour = UTC_hour + 24

        if self.hour < 10:
            self.hour = str(0)+str(self.hour)
        if self.min < 10:
            self.min = str(0)+str(self.min)
        if self.sec < 10:
            self.sec = str(0)+str(self.sec)
        print("UTC : %d年%d月%d日%s时%s分%s秒" % (self.year, self.month, self.day, self.hour, self.min, self.sec))


    def UTC2BDS(self):
        leap_list, un_leap_list = self.leap(2006)
        e = len(leap_list) + len(un_leap_list) - 1
        day = e * 365 + 1 * len(leap_list)
        monthdays = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
        if (self.year in leap_list) | (self.month < 3):
            day += (monthdays[self.month-1] + self.day)
        if self.year in un_leap_list:
            day += ((monthdays[self.month-1] - 1) + self.day)
        time = day*24*60*60 + int(self.hour) * 60 * 60 + int(self.sec)
        week = int(time/604800)
        sec = time - week * 604800 + 33
        if sec >= 604800:
            week = week + 1
            sec = sec - 604800
        print("BDS--周：", week, " 周内秒：", sec)


    def BDS2GPS(self):
        leap_list, un_leap_list = self.leap(1980)
        e = len(leap_list) + len(un_leap_list) - 1
        day = e * 365 + 1 * len(leap_list)
        monthdays = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
        if (self.year in leap_list) | (self.month < 3):
            day += (monthdays[self.month - 1] + self.day)
        if self.year in un_leap_list:
            day += ((monthdays[self.month - 1] - 1) + self.day)
        time = (day-5) * 24 * 60 * 60 + int(self.hour) * 60 * 60 + int(self.sec)
        week = int(time / 604800)
        sec = time - week * 604800 + 19
        if sec >= 604800:
            sec = sec - 604800
            week = week + 1
        print("GPS--周：", week, " 周内秒：", sec)


    '''leap year or not'''
    def leap(self, start_year):
        leap_list = []
        un_leap_list = []
        for year in range(start_year, self.year+1):
            if year % 4 == 0:
                if year % 100 == 0:
                    if year % 400 == 0:
                        leap_list.append(year)
                    else:
                        un_leap_list.append(year)
                else:
                    leap_list.append(year)
            else:
                un_leap_list.append(year)
        return leap_list, un_leap_list


if __name__ == '__main__':
    local_time = ['2022', '9', '19', '10', '00', '00']  # Must input int
    transformer = timetrans(local_time)
    transformer.local_time2UTC()
    transformer.UTC2BDS()
    transformer.BDS2GPS()


