//
//  Post.h
//  Tumblr
//
//  Created by Bob Leano on 1/25/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject
@property (nonatomic, strong)  NSString *blogName;
@property (nonatomic, strong)  NSString *summary;
@property (nonatomic, strong)  NSURL *imageUrl;
- (instancetype) initWithDictionary: (NSDictionary *) jsonDictionary;
@end
