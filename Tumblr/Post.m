//
//  Post.m
//  Tumblr
//
//  Created by Bob Leano on 1/25/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "Post.h"

@implementation Post

- (instancetype) initWithDictionary: (NSDictionary *) jsonDictionary{
    self = [super init];
    if(self){
        self.blogName = jsonDictionary[@"blog_name"];
        self.summary = jsonDictionary[@"summary"];
        NSArray *photos = jsonDictionary[@"photos"];
        NSDictionary *singlePhoto = photos[0];
        NSDictionary *originalSize = singlePhoto[@"original_size"];
        NSString *urlString = originalSize[@"url"];
        self.imageUrl = [NSURL URLWithString:urlString];
    }
    return self;
}


@end
