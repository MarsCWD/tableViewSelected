//
//  BaseItem.m
//  
//
//  Created by Chen on 15/8/4.
//
//

#import "BaseItem.h"

@implementation BaseItem
+ (instancetype)itemWithTitle:(NSString *)title jumeController:(Class)jumpController {
    BaseItem *item = [[BaseItem alloc] init];
    item.title = title;
    item.jumpController = jumpController;
    return item;
}
@end
