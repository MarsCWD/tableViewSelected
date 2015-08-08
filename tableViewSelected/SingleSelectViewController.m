//
//  SingleSelectViewController.m
//  
//
//  Created by Chen on 15/8/4.
//
//

#import "SingleSelectViewController.h"

@interface SingleSelectViewController ()
@property (nonatomic, strong) NSIndexPath *previousIndexPath;

@property (nonatomic, copy) NSMutableArray *selectArr;
@end

@implementation SingleSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Single Select";
    
    [self showRightBtn];
}

- (void)btnClick {
    NSLog(@"Single Select : %@",self.selectArr);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Single Select Cell";
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
    
    //与原先选择的不是同一个cell，则将原先选择的去掉勾选
    if (self.previousIndexPath != indexPath) {
        UITableViewCell *previousCell = [tableView cellForRowAtIndexPath:self.previousIndexPath];
        previousCell.accessoryType = UITableViewCellAccessoryNone;
        [self.selectArr removeObject:self.previousIndexPath];
        self.previousIndexPath = indexPath;
    }
    
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
