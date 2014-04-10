//
//  TabBarViewController.m
//  Dribbble
//
//  Created by KatsuyaGoto on 2014/04/10.
//  Copyright (c) 2014年 KatsuyaGoto. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController


- (id)initWithCoder:(NSCoder*)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.delegate = self;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if ([viewController conformsToProtocol:@protocol(TabBarViewControllerDelegate)]) {
        [(UIViewController<TabBarViewControllerDelegate>*)viewController didSelect:self];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
