//
//  UITextView+PlaceHolder.m
//  IOS-Categories
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UITextView+PlaceHolder.h"
static const char *phTextView = "placeHolderTextView";
@implementation UITextView (PlaceHolder)
- (UITextView *)placeHolderTextView {
    return objc_getAssociatedObject(self, phTextView);
}
- (void)setPlaceHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, phTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)addPlaceHolder:(NSString *)placeHolder {
    if (![self placeHolderTextView]) {
        self.delegate = self;
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = [UIFont systemFontOfSize:14];
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = kRGBCOLOR(210, 210, 210);
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setPlaceHolderTextView:textView];
    }
}
# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length) {
        self.placeHolderTextView.hidden = YES;
    }
    else {
        self.placeHolderTextView.hidden = NO;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text && [textView.text isEqualToString:@""]) {
        self.placeHolderTextView.hidden = NO;
    }
}

@end
