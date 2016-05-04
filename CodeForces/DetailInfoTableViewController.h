//
//  DetailInfoTableViewController.h
//  CodeForces
//
//  Created by Тимур Аюпов on 04.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Contest;

@interface DetailInfoTableViewController : UIViewController
@property (nonatomic, strong) Contest *contest;
@end
