//
//  NSDate+Extensions.swift
//  SwiftNSDateExtensions
//
//  Created by Freddy on 10/4/14.
//
//

import Foundation

let D_SECOND = 1
let D_MINUTE = 60
let D_HOUR = 3600
let D_DAY = 86400
let D_WEEK = 604800
let D_YEAR = 31556926

//var sharedCalendar:NSCalendar = nil;

let componentFlags : NSCalendarUnit = [.NSYearCalendarUnit, .NSMonthCalendarUnit, .NSDayCalendarUnit, .NSWeekCalendarUnit, .NSHourCalendarUnit, .NSMinuteCalendarUnit, .NSSecondCalendarUnit, .NSWeekdayCalendarUnit, .NSWeekdayOrdinalCalendarUnit];
extension NSDate{
    
    
    //(NSYearCalendarUnit, NSMonthCalendarUnit , NSDayCalendarUnit , NSWeekCalendarUnit ,  NSHourCalendarUnit , NSMinuteCalendarUnit , NSSecondCalendarUnit , NSWeekdayCalendarUnit , NSWeekdayOrdinalCalendarUnit);
    
    

    class func currentCalendar() -> NSCalendar
    {
//
//        if (sharedCalendar == nil){
//            sharedCalendar = NSCalendar.autoupdatingCurrentCalendar();
//        }
        return NSCalendar.autoupdatingCurrentCalendar();
    }
    
    // Relative dates from the current date
    class func dateTomorrow() -> NSDate
    {
        return NSDate().dateByAddingsDays(1);
    }
    
    class func dateYesterday() -> NSDate
    {
        return NSDate().dateBySubtractingDays(1)
    }
    
    class func dateWithDaysFromNow(days:NSInteger) -> NSDate
    {
        return NSDate().dateByAddingsDays(days);
    }
    
    class func dateWithDaysBeforeNow(days:NSInteger) -> NSDate
    {
        return NSDate().dateBySubtractingDays(days);
    }
    
    class func dateWithHoursFromNow(dHours:NSInteger) -> NSDate
    {
        let aTimeInterval : NSTimeInterval = NSDate().timeIntervalSinceReferenceDate + Double(D_HOUR) * Double(dHours);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    class func dateWithHoursBeforeNow(dHours:NSInteger) -> NSDate
    {
        let aTimeInterval : NSTimeInterval = NSDate().timeIntervalSinceReferenceDate - Double(D_HOUR) * Double(dHours);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    class func dateWithMinutesFromNow(dMinutes:NSInteger) -> NSDate
    {
        let aTimeInterval : NSTimeInterval = NSDate().timeIntervalSinceReferenceDate + Double(D_MINUTE) * Double(dMinutes);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    class func dateWithMinutesBeforeNow(dMinutes:NSInteger) -> NSDate
    {
        let aTimeInterval : NSTimeInterval = NSDate().timeIntervalSinceReferenceDate - Double(D_MINUTE) * Double(dMinutes);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    class func dateWithSecondsFromNow(dSeconds:NSInteger) -> NSDate
    {
        let aTimeInterval : NSTimeInterval = NSDate().timeIntervalSinceReferenceDate + Double(dSeconds);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    class func dateWithSecondsBeforeNow(dSeconds:NSInteger) -> NSDate
    {
        let aTimeInterval : NSTimeInterval = NSDate().timeIntervalSinceReferenceDate - Double(dSeconds);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    
    // Comparing dates
    func isEqualToDateIgnoringTime(aDate:NSDate) -> Bool
    {
        let components1 = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        let components2 = NSDate.currentCalendar().components(componentFlags, fromDate: aDate);
        
        return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
    }
    
    func isToday() -> Bool
    {
        return self.isEqualToDateIgnoringTime(NSDate());
    }
    
    func isTomorrow() -> Bool
    {
        return self.isEqualToDateIgnoringTime(NSDate.dateTomorrow());
    }
    
    func isYesterday() -> Bool
    {
        return self.isEqualToDateIgnoringTime(NSDate.dateYesterday());
    }
    
    func isSameWeekAsDate(aDate : NSDate) -> Bool
    {
        let components1 = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        let components2 = NSDate.currentCalendar().components(componentFlags, fromDate: aDate);
        
        if (components1.weekOfYear != components2.weekOfYear) {
            return false;
        }
        
        // Must have a time interval under 1 week. Thanks @aclark
        return (abs(NSInteger(self.timeIntervalSinceDate(aDate))) < D_WEEK);
    }
    
    func isThisWeek() -> Bool
    {
        return self.isSameWeekAsDate(NSDate());
    }
    
    func isNextWeek() -> Bool
    {
        let aTimeInterval = NSDate().timeIntervalSinceReferenceDate + Double(D_WEEK);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return self.isSameWeekAsDate(newDate);
    }
    
    func isLastWeek() -> Bool
    {
        let aTimeInterval = NSDate().timeIntervalSinceReferenceDate - Double(D_WEEK);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return self.isSameWeekAsDate(newDate);
    }
    
    func isSameMonthAsDate(aDate:NSDate) -> Bool
    {
        let components1 = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        let components2 = NSDate.currentCalendar().components(componentFlags, fromDate: aDate);
        
        return ((components1.month == components2.month) &&
            (components1.year == components2.year));
    }
    
    func isThisMonth() -> Bool
    {
        return self.isSameMonthAsDate(NSDate());
    }
    
    func isNextMonth() -> Bool
    {
        return self.isSameMonthAsDate(NSDate().dateByAddingsMonths(1));
    }
    
    func isLastMonth() -> Bool
    {
        return self.isSameMonthAsDate(NSDate().dateBySubtractingMonths(1));
    }
    
    func isSameYearAsDate(aDate:NSDate) -> Bool
    {
        let components1 = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        let components2 = NSDate.currentCalendar().components(componentFlags, fromDate: aDate);
        
        return (components1.year == components2.year);
    }
    
    func isThisYear() -> Bool
    {
        return self.isSameYearAsDate(NSDate());
    }
    
    func isNextYear() -> Bool
    {
        let components1 = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        let components2 = NSDate.currentCalendar().components(componentFlags, fromDate: NSDate());
        
        return (components1.year == (components2.year + 1));
    }
    
    func isLastYear() -> Bool
    {
        let components1 = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        let components2 = NSDate.currentCalendar().components(componentFlags, fromDate: NSDate());
        
        return (components1.year == (components2.year - 1));
    }
    
    func isEarlierThanDate(aDate:NSDate) -> Bool
    {
        return (self.compare(aDate) == NSComparisonResult.OrderedAscending);
    }
    
    func isLaterThanDate(aDate:NSDate) -> Bool
    {
        return (self.compare(aDate) == NSComparisonResult.OrderedDescending);
    }
    
    func isInFuture() -> Bool
    {
        return self.isLaterThanDate(NSDate());
    }
    
    func isInPast() -> Bool
    {
        return self.isEarlierThanDate(NSDate());
    }
    
    // Date roles
    func isTypicallyWorkday() -> Bool
    {
        let components = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        if (components.weekday == 1 || components.weekday == 7)
        {
            return true;
        }
        return false;
    }
    
    func isTypicallyWeekend() -> Bool
    {
        return !isTypicallyWeekend();
    }
    
    // Adjusting dates
    func dateByAddingsYears(dYears:NSInteger) -> NSDate{
        let dateComponents = NSDateComponents();
        dateComponents.year = dYears;
        
        let newDate = NSDate.currentCalendar().dateByAddingComponents(dateComponents, toDate: self, options:[]);
        
        return newDate!;
        
    }
    
    func dateBySubtractingYears(dYears:NSInteger) -> NSDate{
        
        return self.dateByAddingsYears(dYears * -1);
    }
    
    
    func dateByAddingsMonths(dYMonths:NSInteger) -> NSDate{
        let dateComponents = NSDateComponents();
        dateComponents.month = dYMonths;
        
        let newDate = NSDate.currentCalendar().dateByAddingComponents(dateComponents, toDate: self, options:[]);
        
        return newDate!;
        
    }
    
    func dateBySubtractingMonths(dYMonths:NSInteger) -> NSDate{
        
        return self.dateByAddingsYears(dYMonths * -1);
    }
    
    
    func dateByAddingsDays(dDays:NSInteger) -> NSDate{
        let dateComponents = NSDateComponents();
        dateComponents.day = dDays;
        
        let newDate = NSDate.currentCalendar().dateByAddingComponents(dateComponents, toDate: self, options:[]);
        
        return newDate!;
        
    }
    
    func dateBySubtractingDays(dDays:NSInteger) -> NSDate{
        
        return self.dateByAddingsDays(dDays * -1);
    }
    
    func dateByAddingHours(dHours:NSInteger) -> NSDate
    {
        let aTimeInterval = self.timeIntervalSinceReferenceDate + Double(D_HOUR) * Double(dHours);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    func dateBySubtractingHours(dHours:NSInteger) -> NSDate
    {
        return self.dateByAddingHours((dHours * -1));
    }
    
    func dateByAddingMinutes(dMinutes:NSInteger) -> NSDate
    {
        let aTimeInterval = self.timeIntervalSinceReferenceDate + Double(D_MINUTE) * Double(dMinutes);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        
        return newDate;
    }
    
    func dateBySubtractingMinutes(dMinutes:NSInteger) -> NSDate
    {
        return self.dateByAddingMinutes((dMinutes * -1));
    }
    
    
    // Date extremes
    
    func dateAtStartOfDay() -> NSDate
    {
        let components = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        components.hour = 0;
        components.minute = 0;
        components.second = 0;
        return NSDate.currentCalendar().dateFromComponents(components)!;
    }
    
    func dateAtEndOfDay() -> NSDate
    {
        let components = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        components.hour = 23;
        components.minute = 59;
        components.second = 59;
        return NSDate.currentCalendar().dateFromComponents(components)!;
    }
    
    // Retrieving intervals
    // TODO : - (NSInteger) minutesAfterDate: (NSDate *) aDate;
    // TODO : - (NSInteger) minutesBeforeDate: (NSDate *) aDate;
    // TODO : - (NSInteger) hoursAfterDate: (NSDate *) aDate;
    // TODO : - (NSInteger) hoursBeforeDate: (NSDate *) aDate;
    // TODO : - (NSInteger) daysAfterDate: (NSDate *) aDate;
    // TODO : - (NSInteger) daysBeforeDate: (NSDate *) aDate;
    // TODO : - (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;
    
    
    func stringWithDateStyle(dateStyle: NSDateFormatterStyle, timeStyle: NSDateFormatterStyle) -> String{
        let formatter = NSDateFormatter();
        formatter.dateStyle = dateStyle;
        formatter.timeStyle = timeStyle;
        return formatter.stringFromDate(self);
    }
    
    func stringWithFormat(format:String) -> String {
        let formatter = NSDateFormatter();
        formatter.dateFormat = format;
        return formatter.stringFromDate(self);
    }
    
    var shortString:String{
        return stringWithDateStyle(NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
    
    var shortDateString:String{
        return stringWithDateStyle(NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.NoStyle)
    }
    
    var shortTimeString:String{
        return stringWithDateStyle(NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
    
    var mediumString:String{
        return stringWithDateStyle(NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.MediumStyle)
    }
    
    var mediumDateString:String{
        return stringWithDateStyle(NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle)
    }
    
    var mediumTimeString:String{
        return stringWithDateStyle(NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.MediumStyle)
    }
    
    var longString:String{
        return stringWithDateStyle(NSDateFormatterStyle.LongStyle, timeStyle: NSDateFormatterStyle.LongStyle)
    }
    
    var longDateString:String{
        return stringWithDateStyle(NSDateFormatterStyle.LongStyle, timeStyle: NSDateFormatterStyle.NoStyle)
    }
    
    var longTimeString:String{
        return stringWithDateStyle(NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.LongStyle)
    }
    
    var nearestHour:NSInteger{
        let aTimeInterval = NSDate.timeIntervalSinceReferenceDate() + Double(D_MINUTE) * Double(30);
        
        let newDate = NSDate(timeIntervalSinceReferenceDate:aTimeInterval);
        let components = NSDate.currentCalendar().components(NSCalendarUnit.NSHourCalendarUnit, fromDate: newDate);
        return components.hour;
    }
    
    var hour:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        return components.hour;
    }
    
    var minute:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        return components.minute;
    }
    
    var seconds:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        return components.second;
    }
    
    var day:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        return components.day;
    }
    
    var month:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        return components.month;
    }
    
    var week:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        return components.weekOfYear;
    }
    
    var weekday:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        return components.weekday;
    }
    
    var nthWeekday:NSInteger{ // e.g. 2nd Tuesday of the month is 2
        let components = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        return components.weekdayOrdinal;
    }
    
    var year:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, fromDate: self);
        return components.year;
    }


}
