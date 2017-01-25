//
//  ViewController.m
//  Tumblr
//
//  Created by Bob Leano on 1/25/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "PhotosViewController.h"
#import "Post.h"
#import "PostTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
@interface PhotosViewController () <UITableViewDataSource>
@property (nonatomic,strong) NSArray<Post *> *posts;
@property (weak, nonatomic) IBOutlet UITableView *photosTableView;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photosTableView.dataSource = self;
    [self fetchFeed];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchFeed{
    NSString *apiKey = @"Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV";
    NSString *urlString =
    [@"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=" stringByAppendingString:apiKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSLog(@"Response: %@", responseDictionary);
                                                    NSDictionary *responses = responseDictionary[@"response"];
                                                    NSArray *responsePosts = responses[@"posts"];
                                                    NSMutableArray *feedPosts = [NSMutableArray array];
                                                    for (NSDictionary *responsePost in responsePosts) {
                                                        Post *singlePost = [[Post alloc] initWithDictionary:responsePost];
                                                        NSLog(@"singlePost: %@", singlePost.blogName);
                                                        [feedPosts addObject: singlePost];
                                                    }
                                                    self.posts = feedPosts;
                                                    [self.photosTableView reloadData];
                                                } else {
                                                    NSLog(@"An error occurred: %@", error.description);
                                                }
                                            }];
    [task resume];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    Post *post = [self.posts objectAtIndex:indexPath.row];
    PostTableViewCell *postTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"postTableViewCell" forIndexPath:indexPath];
    postTableViewCell.blogName.text = post.blogName;
    postTableViewCell.summary.text = post.summary;
    [postTableViewCell.originalPhoto setImageWithURL: post.imageUrl];
    //    NSLog(@"row number:@%ld", indexPath.row);
    return postTableViewCell;
    
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return self.posts.count;
}


@end
