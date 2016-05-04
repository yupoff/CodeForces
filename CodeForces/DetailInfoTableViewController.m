//
//  DetailInfoTableViewController.m
//  CodeForces
//
//  Created by Тимур Аюпов on 04.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "DetailInfoTableViewController.h"
#import "Contest.h"

@interface DetailInfoTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelStartDate;
@property (weak, nonatomic) IBOutlet UILabel *labelDurationSeconds;
@property (weak, nonatomic) IBOutlet UITextView *textFieldNotes;

@end

@implementation DetailInfoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Сохранить" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    [self.navigationItem setRightBarButtonItem:saveButton];
    [self setData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setData
{
    self.labelName.text = self.contest.name;
    self.labelStartDate.text = [NSDateFormatter localizedStringFromDate:self.contest.startDate
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
    self.labelDurationSeconds.text = self.contest.durationTime;
    self.textFieldNotes.text = self.contest.textNote;
}

-(void)saveAction
{
    [self.contest saveTextNotes:self.textFieldNotes.text];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
