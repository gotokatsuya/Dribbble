//
//  TableViewController.m
//  Dribbble
//
//  Created by KatsuyaGoto on 2014/04/09.
//  Copyright (c) 2014年 KatsuyaGoto. All rights reserved.
//

#import "DebutsTableViewController.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import "TableViewCell.h"


@interface DebutsTableViewController(){
    NSMutableArray *urls;
    NSString* selectedImage;
    NSInteger page;
    AFHTTPRequestOperationManager* manager;
    BOOL loading;
}
@end


@implementation DebutsTableViewController


- (id)initWithCoder:(NSCoder*)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        //Here you are setting title
        self.tabBarItem.title = @"Debuts";
        // Modify the display title on the navigation bar
        self.navigationItem.title = @"Debuts";
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    urls = [NSMutableArray array];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.dataSource = self;
    
    manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    page = 1;
    
    [self requestUrls];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) didSelect:(TabBarViewController *)tabBarController {
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return urls.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    TableViewCell *cell =  (TableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self requestImages:cell atIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280;
}


- (void)requestImages:(TableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    NSString *url = [urls objectAtIndex:indexPath.row];
    
    cell.cellImage.image = nil;
    
    __weak TableViewCell *weakCell = cell;
    
    [cell.cellImage setImageWithURLRequest:
     [NSURLRequest requestWithURL:[NSURL URLWithString:url]]
                          placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       weakCell.cellImage.image = image;
                                       
                                   } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                       
                                       NSLog(@"Error: %@", error);
                                   }
     ];
}


- (void) requestUrls{
    
    loading = YES;
    
    NSString *request = @"/shots/debuts?page=";
    NSString *pageStr = [NSString stringWithFormat:@"%d", page];
    NSString *url = [request stringByAppendingString:pageStr];
    
    [manager GET:url
     
      parameters:nil
     
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             //NSLog(@"response: %@", responseObject);
             NSArray *shots = responseObject[@"shots"];
             for (NSDictionary *dict in shots) {
                 NSString *imageUrl= dict[@"image_url"];
                 if(imageUrl != nil){
                     [urls addObject:imageUrl];
                 }
             }
             
             [self.tableView reloadData];
             
             loading = NO;
         }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"Error: %@", error);
         }];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height))
    {
        
        if(loading == YES) {
			return;
		}
        NSLog(@"Page: %d", page);
        
        page++;
        [self requestUrls];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath{
    selectedImage = [urls objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"toViewController" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toViewController"]) {
        ViewController *vc = (ViewController*)[segue destinationViewController];
        vc.imageUrl = selectedImage;
        NSLog(@"Select: %@", selectedImage);
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}


@end
