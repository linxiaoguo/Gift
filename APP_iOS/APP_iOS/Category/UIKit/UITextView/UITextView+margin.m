//
//  UITextView+margin.m
//  XMU1.0
//
//  Created by lihj on 14-3-31.
//  Copyright (c) 2014年 DongXM. All rights reserved.
//

#import "UITextView+margin.h"

@implementation UITextView (margin)


- (CGSize)getContentSize {
    CGSize newSize = self.contentSize; //UITextView的实际高度
    
    NSString *sysVersion = [UIDevice currentDevice].systemVersion;
    CGFloat version = [sysVersion floatValue];
    
    if (version >= 7.0) {
        CGSize constraint = CGSizeMake(self.contentSize.width, CGFLOAT_MAX);
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attributes = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        CGSize size = [self.text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;

        newSize.height = size.height + 15;
    }
    return newSize;
}


@end
