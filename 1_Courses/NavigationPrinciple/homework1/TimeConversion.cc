//
// Created by hazyparker on 22-9-19.
//

#include "TimeConversion.h"
#include <iostream>
#include <tuple>
#include <iomanip>
#include <vector>
#include <utility>

using namespace std;

typedef pair<int, int> PairDay;

TimeConversion::TimeConversion(int mYear, int mMonth, int mDay,
                               int mHour, int mMin, double mSec) {
    // init local_time
    get<0>(local_time) = mYear;
    get<1>(local_time) = mMonth;
    get<2>(local_time) = mDay;
    get<3>(local_time) = mHour;
    get<4>(local_time) = mMin;
    get<5>(local_time) = mSec;

    ia_time = TimeAddSubtraction(local_time, 32.184, false);

    LT2GPS();
    LT2BDS();

    // insert leap second table
    leap_sec_vec = {
            {1972, 1, 1},
            {1973, 0, 1},
            {1974, 0, 1},
            {1975, 0, 1},
            {1976, 0, 1},
            {1977, 0, 1},
            {1978, 0, 1},
            {1979, 0, 1},
            {1980, 0, 0},
            {1981, 1, 0},
            {1982, 1, 0},
            {1983, 1, 0},
            {1984, 0, 0},
            {1985, 1, 0},
            {1986, 0, 0},
            {1987, 0, 1},
            {1988, 0, 0},
            {1989, 0, 1},
            {1990, 0, 1},
            {1991, 0, 0},
            {1992, 1, 0},
            {1993, 1, 0},
            {1994, 1, 0},
            {1995, 0, 1},
            {1996, 0, 0},
            {1997, 1, 0},
            {1998, 0, 1},
            {1999, 0, 0},
            {2000, 0, 0},
            {2001, 0, 0},
            {2002, 0, 0},
            {2003, 0, 0},
            {2004, 0, 0},
            {2005, 0, 1},
            {2006, 0, 0},
            {2007, 0, 0},
            {2008, 0, 1},
            {2009, 0, 0},
            {2010, 0, 0},
            {2011, 0, 0},
            {2012, 1, 0},
            {2013, 0, 0},
            {2014, 0, 0},
            {2015, 1, 0},
            {2016, 0, 1},
            {2017, 0, 0},
            {2018, 0, 0},
            {2019, 0, 0},
            {2020, 0, 0},
            {2021, 0, 0},
            {2022, 0, 0}
    };

    LT2UTC();
}

Time TimeConversion::TimeAddSubtraction(Time &time_origin, double sec, bool sign) {
    // send data to int and double variables for processing
    int year_origin = get<0>(time_origin);
    int month_origin = get<1>(time_origin);
    int day_origin = get<2>(time_origin);
    int hour_origin = get<3>(time_origin);
    int min_origin = get<4>(time_origin);
    double sec_origin = get<5>(time_origin);

    Time time_result;
    time_result = time_origin;
    int year_result = 0, month_result, day_result, hour_result, min_result;
    double sec_result;

    /**
     * there must be a better time add ans subtraction method
     */
    // add or subtract the delta time
    if (sign){
        // time_result = time_origin + delta

        /**
         * minus upgrade will make delta range up to 60 secs
         * now the sun_sec can't be more than 120s
         */
        // get sec
        double sum_sec = sec + sec_origin;
        if (sum_sec >= 60.0){
            sec_result = sum_sec - 60.0;
            min_result = min_origin + 1;
        }else{
            sec_result = sum_sec;
            min_result = min_origin;
        }

        // get min
        if (min_result >= 60){
            min_result -= 60;
            hour_result = hour_origin + 1;
        }else{
            hour_result = hour_origin;
        }

        // get hour
        if (hour_result >= 24){
            hour_result -= 24;
            day_result = day_origin + 1;
        }else{
            day_result = day_origin;
        }

        // get month
        month_result = month_origin;

        // get year and correct month
        if (day_result == 29 && !isLeapYear(year_origin) && month_origin == 2){
            day_result = 1;
            month_result += 1;
            year_result = year_origin;
        }else if (day_result == 29 && isLeapYear(year_origin) && month_origin == 2){
            //day_result = day_origin;
        }else if (day_result == 31 && (month_result == 2 || month_result == 4 ||
            month_result == 6 || month_result == 9 || month_result == 11)) {
            day_result = 1;
            month_result += 1;
            year_result = year_origin;
        }else if (day_result == 32 && (month_result == 1 || month_result == 3 ||
            month_result == 5 || month_result == 7 || month_result == 8 ||
            month_result == 10)) {
            day_result = 1;
            month_result += 1;
            year_result = year_origin;
        }else if (day_result == 32 && month_result == 12) {
            day_result = 1;
            month_result = 1;
            year_result = year_origin + 1;
        }
        else{
            year_result = year_origin;
        }

    }

    else{
        // time_result = time_origin - delta

        // get sec
        double sub_sec = sec_origin - sec;
        if (sub_sec < 0.0){
            sec_result = 60.0 + sub_sec;
            min_result = min_origin - 1;
        }else{
            sec_result = sub_sec;
            min_result = min_origin;
        }

        // get min
        if (min_result < 0){
            min_result += 60;
            hour_result = hour_origin - 1;
        }else{
            hour_result = hour_origin;
        }

        // het hour
        if (hour_result < 0){
            hour_result += 24;
            day_result = day_origin - 1;
        }else{
            day_result = day_origin;
        }

        // get month
        month_result = month_origin;

        // get day
        if (day_result == 0 && month_result == 3 && isLeapYear(year_origin)){
            day_result = 29;
            month_result = 2;
            year_result = year_origin;
        }else if (day_result == 0 && month_result == 3 && !isLeapYear(year_origin)){
            day_result = 28;
            month_result = 2;
            year_result = year_origin;
        }else if (day_result == 0 && (month_result == 11 || month_result == 2 ||
                month_result == 4 || month_result == 6 || month_result == 8 ||
                month_result == 9)) {
            // 2 4 6 8 9 11
            day_result = 31;
            month_origin -= 1;
            year_result = year_origin;
        }else if (day_result == 0 && (month_result == 3 || month_result == 5 ||
                month_result == 7 || month_result == 10 || month_result == 12)) {
            // 3 5 7 10 12
            day_result = 30;
            month_result -= 1;
            year_result = year_origin;
        }else if (day_result == 0 && month_result == 1){
            // year -1
            day_result = 31;
            month_result = 12;
            year_result = year_origin - 1;
        }else{
            year_result = year_origin;
        }

    }

    get<0>(time_result) = year_result;
    get<1>(time_result) = month_result;
    get<2>(time_result) = day_result;
    get<3>(time_result) = hour_result;
    get<4>(time_result) = min_result;
    get<5>(time_result) = sec_result;

    return time_result;
}

bool TimeConversion::isLeapYear(int year) {
    if((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) ){
        return true;
    }else return false;
}

void TimeConversion::LT2UTC() {
    int year, month, day;
    year = get<0>(ia_time);
    month = get<1>(ia_time);
    day = get<2>(ia_time);

    int bias = 0;

    int cor_x = 0, cor_y = 0;

    // get cor y
    if (month >= 1 && month <= 6){
        cor_y = 1;
    }else{
        cor_y = 2;
    }

    // get cor x
    cor_x = year - 1972;

    // get bias
    for (int i = 0; i < cor_x; i++ ){
        bias += leap_sec_vec[i][1] + leap_sec_vec[i][2];
    }
    bias += leap_sec_vec[cor_x][cor_y] + 10;

    utc_time = TimeAddSubtraction(ia_time, bias, false);
}

void TimeConversion::LT2GPS() {
    gps_time = TimeAddSubtraction(ia_time, 19, false);
}

void TimeConversion::LT2BDS() {
    bds_time = TimeAddSubtraction(ia_time, 33, false);
}

void TimeConversion::Show(Time &time) {
    int year = get<0>(time);
    int month = get<1>(time);
    int day = get<2>(time);
    int hour = get<3>(time);
    int min = get<4>(time);
    double sec = get<5>(time);

    cout << setw(4)  << year << "-"
        << setw(2) << month << "-"
        << setw(2) << day << ", "
        << setw(2) << hour << ":"
        << min << ":"
        << sec << endl;
}

void TimeConversion::ShowAllTime() {
    cout << setw(12) <<  "local time" << ", ";
    Show(local_time);
    cout << setw(12) << "IA time"<< ", ";
    Show(ia_time);
    cout << setw(12) << "GPS time"<< ", ";
    Show(gps_time);
    cout << setw(12) << "BDS time"<< ", ";
    Show(bds_time);
    cout << setw(12) << "UTC time"<< ", ";
    Show(utc_time);
}

TimeDay TimeConversion::thinking(TimeDay &timeDay, int days) {

    TimeDay result;
    vector<PairDay> day_match, day_match_leap;

    int curr_year = get<0>(timeDay);
    int curr_month = get<1>(timeDay);
    int curr_day = get<2>(timeDay);

    int add_year, add_month, add_day;

    day_match = {
            {1, 31},
            {2, 28},
            {3, 31},
            {4, 30},
            {5, 31},
            {6, 30},
            {7, 31},
            {8, 31},
            {9, 30},
            {10, 31},
            {11, 30},
            {12, 31}
    };

    day_match_leap = {
            {1, 31},
            {2, 29},
            {3, 31},
            {4, 30},
            {5, 31},
            {6, 30},
            {7, 31},
            {8, 31},
            {9, 30},
            {10, 31},
            {11, 30},
            {12, 31}
    };

    int sum_day = 0;
    // while current year is not a leap year
    if (!isLeapYear(curr_year)) {

        // get days in total
        int i = 0;
        while (i + 1 < curr_month) {
            sum_day += day_match[i].second;
            i += 1;
        }
        sum_day += curr_day;

        // get exactly month and day
        if (365 - sum_day - days > 0) {
            // which means within a year
            pair<int, int> time;
            time.first = curr_month;
            time.second = curr_day;
            time = getTimeWithinYear(time, days, false);
            get<0>(result) = curr_year;
            get<1>(result) = time.first;
            get<2>(result)  =time.second;
        }else{
            // which means more than a year, there will be adding in `year`
            // the next year being leap year or not need to be considered
            // still using the cut strategy
            int final_year = curr_year;
            int rest_days = days;
            while (365 - rest_days){}
        }

    }

    return result;
}

pair<int, int> TimeConversion::getTimeWithinYear(pair<int, int> &time, int days, bool is_leap_year) {
    vector<PairDay> day_match, day_match_leap;
    day_match = {
            {1, 31},
            {2, 28},
            {3, 31},
            {4, 30},
            {5, 31},
            {6, 30},
            {7, 31},
            {8, 31},
            {9, 30},
            {10, 31},
            {11, 30},
            {12, 31}
    };

    day_match_leap = {
            {1, 31},
            {2, 29},
            {3, 31},
            {4, 30},
            {5, 31},
            {6, 30},
            {7, 31},
            {8, 31},
            {9, 30},
            {10, 31},
            {11, 30},
            {12, 31}
    };

    pair<int, int> result;

    int month = time.first;
    int day = time.second;

    if (!is_leap_year){
        // for normal year
        if (day_match[month - 1].second - day > days){
            result.first = month;
            result.second = day + days;
        }else{
            days -= day_match[month - 1].second - day;
            int i = month + 1;
            while (days > day_match[i - 1].second){
                days -= day_match[i - 1].second;
                i += 1;
            }
            result.first = i;
            result.second = days;
        }
    }else{
        // for leap year
        if (day_match_leap[month - 1].second - day > days){
            result.first = month;
            result.second = day + days;
        }else{
            days -= day_match_leap[month - 1].second - day;
            int i = month + 1;
            while (days > day_match_leap[i - 1].second){
                days -= day_match_leap[i - 1].second;
                i += 1;
            }
            result.first = i;
            result.second = days;
        }
    }

    return result;
}
