//
//  UITableView+Separator.h
//  APP_iOS
//
//  Created by 林小果 on 15/8/28.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITableView (Separator)
- (void)setNoFooterSeparator;

- (void)setFullWidthSeparator;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
@end
