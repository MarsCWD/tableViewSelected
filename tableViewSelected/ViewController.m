//
//  ViewController.m
//  tableViewSelected
//
//  Created by Chen on 15/8/4.
//  Copyright (c) 2015年 chenweidong. All rights reserved.
//

#import "ViewController.h"
#import "BaseItem.h"
#import "BaseTableViewController.h"
#import "SingleSelectViewController.h"
#import "MultipleSelectViewController.h"
#import "MixedSelectViewController.h"

@interface ViewController ()
@property (nonatomic, copy) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"tableView Selected";
    
    
    BaseItem *singleSelectItem = [BaseItem itemWithTitle:@"Single Select"
                                          jumeController:[SingleSelectViewController class]];
    
    BaseItem *multipleSelectItem = [BaseItem itemWithTitle:@"Multiple Select"
                                            jumeController:[MultipleSelectViewController class]];
    
    BaseItem *mixedSelectItem = [BaseItem itemWithTitle:@"Mixed Select"
                                         jumeController:[MixedSelectViewController class]];
    
    self.dataArray = @[singleSelectItem, multipleSelectItem, mixedSelectItem];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"homeIndexCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    BaseItem *item = self.dataArray[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BaseItem *item = self.dataArray[indexPath.row];
    if (item.jumpController) {
        BaseTableViewController *vc = [[item.jumpController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
