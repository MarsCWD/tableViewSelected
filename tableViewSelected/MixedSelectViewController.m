//
//  MixedSelectViewController.m
//  
//
//  Created by Chen on 15/8/4.
//
//

#import "MixedSelectViewController.h"

@interface MixedSelectViewController ()
@property (nonatomic, copy) NSMutableArray *selectArr;
@property (nonatomic, strong) NSIndexPath *previousIndexPath;

@end

@implementation MixedSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Mixed Select";
    
    self.tableView.allowsMultipleSelection = YES;
    
    [self showRightBtn];
}

- (void)btnClick {
    NSLog(@"Mixed Select : %@",self.selectArr);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Mixed Select Cell";
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"单选";
    } else {
        return @"多选";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];

    if (indexPath.section == 0) {//单选
        //与原先选择的不是同一个cell，则将原先选择的去掉勾选
        if (self.previousIndexPath != indexPath) {
            if (self.previousIndexPath == nil && self.selectArr.count > 0) {
                //如果是从多选跳到单选的话，需要把数组的内容清空
                [self resetMultipleSelect:self.selectArr.copy];
                [self.selectArr removeAllObjects];
            }
            
            //单选将原先选中的cell取消选中
            UITableViewCell *previousCell = [tableView cellForRowAtIndexPath:self.previousIndexPath];
            previousCell.accessoryType = UITableViewCellAccessoryNone;
            [self.selectArr removeObject:self.previousIndexPath];
            self.previousIndexPath = indexPath;
        }
    } else {
        if (self.previousIndexPath) {
            //从单选跳到多选，则将单选去除
            UITableViewCell *singleCell = [tableView cellForRowAtIndexPath:self.previousIndexPath];
            singleCell.accessoryType = UITableViewCellAccessoryNone;
            [self.selectArr removeObject:self.previousIndexPath];
            
            //重要：多选时，该属性必须置为nil,否则当选了一个单选项A，然后再选择一个多选项B，再选择单选项A就会出问题
            self.previousIndexPath = nil;
        }
    }
    
    //公共部分：单选和多选的公共逻辑
    if (![self.selectArr containsObject:indexPath]) {//选中
        currentCell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectArr addObject:indexPath];
    } else {//反选
        currentCell.accessoryType = UITableViewCellAccessoryNone;
        [self.selectArr removeObject:indexPath];
    }
}

//将多选的cell置为不选中
- (void)resetMultipleSelect:(NSArray *)selectArray {
    for (NSIndexPath *multipleIndexPath in selectArray) {
        UITableViewCell *multipleCell = [self.tableView cellForRowAtIndexPath:multipleIndexPath];
        multipleCell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (NSMutableArray *)selectArr {
     if (_selectArr == nil) {
         _selectArr = [NSMutableArray array];
     }
     return _selectArr;
}

@end
