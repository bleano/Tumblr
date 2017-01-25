//
//  PostTableViewCell.h
//  Tumblr
//
//  Created by Bob Leano on 1/25/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *originalPhoto;
@property (weak, nonatomic) IBOutlet UILabel *blogName;
@property (weak, nonatomic) IBOutlet UILabel *summary;

@end
