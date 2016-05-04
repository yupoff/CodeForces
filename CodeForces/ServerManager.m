//
//  ServerManager.m
//  CodeForces
//
//  Created by Тимур Аюпов on 04.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"
#import "Contest.h"

@interface ServerManager ()

@property (nonatomic,strong) AFHTTPSessionManager *requestOperationManager;

@end

@implementation ServerManager

+(ServerManager *)sharedManager
{
    static ServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc]init];
    });
    return manager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *baseURL =  [NSURL URLWithString:@"https://codeforces.com/api/"];
        self.requestOperationManager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
    }
    return self;
}

-(void)getInformationAllContest:(void(^)(NSArray *data)) success onFailure:(void(^)(NSError *error)) failure
{
    [self.requestOperationManager GET:@"contest.list" parameters:nil progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        NSArray *dictsArray = [responseObject objectForKey:@"result"];
        NSMutableArray *objectsArray = [NSMutableArray array];
        for (NSDictionary *dict in dictsArray) {
            Contest *contest = [[Contest alloc]initWithResponseObject:dict];
            [objectsArray addObject:contest];
        }
        if (success) {
            success([objectsArray copy]); 
        }
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        failure(error);
    }];
    
}
@end
