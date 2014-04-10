//
//  ViewController.m
//  Dribbble
//
//  Created by KatsuyaGoto on 2014/04/09.
//  Copyright (c) 2014年 KatsuyaGoto. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.imageView setImageWithURL:[NSURL URLWithString:self.imageUrl]];
}
- (IBAction)closeModal:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:YES                                                        completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
