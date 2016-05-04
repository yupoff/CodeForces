//
//  Contest.m
//  CodeForces
//
//  Created by Тимур Аюпов on 04.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "Contest.h"

static NSString *const ContestNotesKey = @"contest_notes";

@implementation Contest
-(id)initWithResponseObject:(NSDictionary *)responseObject
{
    self = [super init];
    if (self) {
        self.contestId = [responseObject objectForKey:@"id"];
        
        self.name = [responseObject objectForKey:@"name"];
        
        self.durationTime = [self convertSecond:[[responseObject objectForKey:@"durationSeconds"] integerValue]];
        
        self.startDate = [self convertUnixDate:[[responseObject objectForKey:@"startTimeSeconds"] integerValue]];
        
        if ([self.startDate compare:[NSDate date]] == NSOrderedAscending) {
            self.finished = YES;
        }
       
        self.textNote = [self getTextNotes];
    }
    return self;
}

-(void)saveTextNotes:(NSString *)text
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:ContestNotesKey];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableDictionary *mutableDict = [dict mutableCopy];
    [mutableDict setObject:text forKey:[self.contestId stringValue]];
    dict = [mutableDict copy];
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [defaults setObject:dataSave forKey:ContestNotesKey];
    [defaults synchronize];
    self.textNote = [self getTextNotes];
}

#pragma mark - Privates Methods

-(NSString *)getTextNotes
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:ContestNotesKey];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return [dict objectForKey:[self.contestId stringValue]];
}


-(NSString *)convertSecond:(NSInteger)seconds
{
    NSUInteger minutes = (seconds / 60) % 60;
    NSUInteger hours = seconds / 3600;
    return [NSString stringWithFormat:@"%02d:%02d",hours,minutes];
}

-(NSDate *)convertUnixDate:(NSInteger)unixDate
{
    NSTimeInterval timeInterval = unixDate;
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}


@end
