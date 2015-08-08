//
//  MultipleSelectViewController.m
//  
//
//  Created by Chen on 15/8/4.
//
//

#import "MultipleSelectViewController.h"

@interface MultipleSelectViewController ()
@property (nonatomic, copy) NSMutableArray *selectArr;

@end

@implementation MultipleSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //允许tableView能够多选
    self.tableView.allowsMultipleSelection = YES;
    
    [self showRightBtn];
    self.title = @"Multiple Select";
}

- (void)btnClick {
    NSLog(@"Multiple Select : %@",self.selectArr);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Multiple Select Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd组，第%zd行",indexPath.section,indexPath.row];
    
    if ([self.selectArr containsObject:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
    if (![self.selectArr containsObject:indexPath]) {//选中
        currentCell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectArr addObject:indexPath];
    } else {//反选
        currentCell.accessoryType = UITableViewCellAccessoryNone;
        [self.selectArr removeObject:indexPath];
    }
}

- (NSMutableArray *)selectArr {
    if (_selectArr == nil) {
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
}

@end
