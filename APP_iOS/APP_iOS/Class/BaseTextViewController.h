//
//  BaseTextViewController.h
//  APP_iOS
//
//  Created by Li on 15/8/26.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "BaseViewController.h"

#define kDefaultNumber 20

@interface BaseTextViewController : BaseViewController

typedef void (^BaseTextViewControllerBlock)(BaseTextViewController *VC, NSString *text);

@property (copy) BaseTextViewControllerBlock block;

@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;

@property (nonatomic, assign) NSUInteger numberOfWords;          /**< 最大字数 */
@property (nonatomic, assign) NSString *defaultContent;         /**< 默认内容 */

@property (nonatomic) UIKeyboardType keyboardType;              /**< 键盘类型 */

@end
