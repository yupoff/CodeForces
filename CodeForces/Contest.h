//
//  Contest.h
//  CodeForces
//
//  Created by Тимур Аюпов on 04.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contest : NSObject

@property (nonatomic, strong) NSNumber *contestId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *durationTime;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, assign) BOOL finished;
@property (nonatomic, strong) NSString *textNote;

-(Contest *)initWithResponseObject:(NSDictionary *)responseObject;
-(void)saveTextNotes:(NSString *)text;
@end
