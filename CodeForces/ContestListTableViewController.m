//
//  ContestListTableViewController.m
//  CodeForces
//
//  Created by Тимур Аюпов on 04.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "ContestListTableViewController.h"
#import "ServerManager.h"
#import "Contest.h"
#import "DetailInfoTableViewController.h"

@interface ContestListTableViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ContestListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = [NSArray array];
    [self getDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getDataSource
{
    ServerManager *manager = [ServerManager sharedManager];;
    [manager getInformationAllContest:^(NSArray *data) {
        self.dataSource = data;
        [self.tableView reloadData];
    } onFailure:^(NSError *error) {
        [self showAlertViewWithTitle:@"Error" message:error.localizedDescription];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count] ?: 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contest *contest = self.dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = contest.name;
    cell.backgroundColor = contest.finished ? [UIColor lightGrayColor] : [UIColor whiteColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contest *contest = [self.dataSource objectAtIndex:indexPath.row];
    DetailInfoTableViewController *detailInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailInfo"];
    detailInfoVC.contest = contest;
    [self.navigationController pushViewController:detailInfoVC animated:YES];
}

-(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
