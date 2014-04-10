//
//  TableViewController.h
//  Dribbble
//
//  Created by KatsuyaGoto on 2014/04/09.
//  Copyright (c) 2014年 KatsuyaGoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "TabBarViewController.h"

@interface EveryoneTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, TabBarViewControllerDelegate>{
    IBOutlet UITableView *tableView;
}
@end