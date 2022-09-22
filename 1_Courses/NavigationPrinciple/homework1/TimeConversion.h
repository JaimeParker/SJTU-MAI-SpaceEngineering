//
// Created by hazyparker on 22-9-19.
//

#ifndef HOMEWORK1_TIMECONVERSION_H
#define HOMEWORK1_TIMECONVERSION_H

// this is a header for class TimeConversion
// to compose time converting from local time to different time

// include libs
#include <vector>
#include <iostream>
#include <tuple>

using namespace std;

typedef vector< vector<int> > Vec2int;
typedef tuple<int, int, int, int, int, double> Time;
typedef tuple<int, int, int> TimeDay;
typedef tuple<int, int, double> TimeSec;

class TimeConversion {
private:
    // define time parameters
    Time local_time;
    Time gps_time;
    Time bds_time;
    Time utc_time;
    Time ia_time;

    // define leap second table, table from
    // https://en.wikipedia.org/wiki/Leap_second
    Vec2int leap_sec_vec;

public:
    /**
     * construction function
     * @param mYear
     * @param mMonth
     * @param mDay
     * @param mHour
     * @param mMin
     * @param mSec
     */
    TimeConversion(int mYear, int mMonth, int mDay,
                   int mHour, int mMin, double mSec);

    /**
     * compose add ans subtraction operation to known time spot
     * @param time_origin; time spot for input
     * @param delta; bias of few seconds
     * @param sign; true means positive add, false means negative subtraction
     * @return the result time, in the data type of tuple(type defined before)
     */
    static Time TimeAddSubtraction(Time &time_origin, double sec, bool sign);

    static TimeDay thinking(TimeDay &timeDay, int days);

    /**
     * judge if this year is a leap year
     * @param year
     * @return true or false, is or not
     */
    static bool isLeapYear(int year);

    /**
     * local time to UTC time
     */
    void LT2UTC();

    /**
     * local time to GPS time
     */
    void LT2GPS();

    /**
     * local time to BDS time
     */
    void LT2BDS();

    static void Show(Time &time);

    /**
     * show all time
     */
    void ShowAllTime();

    static pair<int, int> getTimeWithinYear(pair<int, int> &time, int days, bool is_leap_year);

    static Time TimeAddSubtractionNoZone(Time &time_origin, double sec, bool sign);
};


#endif //HOMEWORK1_TIMECONVERSION_H
