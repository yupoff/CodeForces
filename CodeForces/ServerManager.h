//
//  ServerManager.h
//  CodeForces
//
//  Created by Тимур Аюпов on 04.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManager : NSObject
+(ServerManager *)sharedManager;

-(void)getInformationAllContest:(void(^)(NSArray *data)) success onFailure:(void(^)(NSError *error)) failure;

@end
