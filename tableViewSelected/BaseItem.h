//
//  BaseItem.h
//  
//
//  Created by Chen on 15/8/4.
//
//

#import <Foundation/Foundation.h>

@interface BaseItem : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) Class jumpController;

+ (instancetype)itemWithTitle:(NSString *)title jumeController:(Class)jumpController;
@end
