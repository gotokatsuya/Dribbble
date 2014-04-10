//
//  TabBarViewController.h
//  Dribbble
//
//  Created by KatsuyaGoto on 2014/04/10.
//  Copyright (c) 2014年 KatsuyaGoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarViewController : UITabBarController<UITabBarControllerDelegate>

@end

@protocol TabBarViewControllerDelegate
- (void) didSelect:(TabBarViewController*) tabBarController;
@end
