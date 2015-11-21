//
//  BindBankViewCtr.m
//  APP_iOS
//
//  Created by 林小果 on 15/10/4.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "BindBankViewCtr.h"
#import "BingBankCell.h"
#import "UITableView+Separator.h"
#import "UIView+Toast.h"
#import "UIPopoverListView.h"

@implementation BindBankModel

@end

@interface BindBankViewCtr () <UIPopoverListViewDataSource, UIPopoverListViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong)IBOutlet UITableView *tableView;
@property (nonatomic, strong)IBOutlet UILabel *lblTopTips;
@property (nonatomic, strong)IBOutlet UIButton *btnConfirm;
@property (nonatomic, strong)IBOutlet UILabel *lblBottomTips;
@property (nonatomic, strong)BindBankModel *bindBankModel;
@property (nonatomic, strong)NSMutableArray *bankList;
@property (nonatomic, strong)UIPopoverListView *popListView;
@end

@implementation BindBankViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"绑定银行卡"];
        
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"注意：\r\n- 提现仅支持储蓄卡，不支持信用卡\r\n- 建议绑定62开头的银联卡，提现更及时\r\n- 目前仅支持绑定一张卡，要变更卡号，请删除绑定卡后，重新添加新卡\r\n- 企业用户，请绑定公司账户"];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    _lblBottomTips.attributedText = string;

    _lblBottomTips.numberOfLines = 0;
    _lblTopTips.numberOfLines = 0;
    _btnConfirm.layer.cornerRadius = 5.0;
    _bindBankModel = [[BindBankModel alloc] init];
    
    [_tableView setFullWidthSeparator];
    [self getBankList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier=@"BingBankCell";
    BingBankCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [CustomView viewWithNibName:@"BingBankCell"];
    }
    NSArray *titles = @[@"真实姓名", @"身份证号", @"开户银行", @"银行卡号"];
    NSArray *placeHolds = @[@"姓名", @"请正确填写身份证号码", @"开户银行", @"请输入银行卡号"];
    cell.lblTitle.text = [titles objectAtIndex:indexPath.row];
    cell.tfContent.placeholder = [placeHolds objectAtIndex:indexPath.row];
    cell.tfContent.tag = indexPath.row + 100;
    [cell.tfContent addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    cell.tfContent.delegate = self;
    
    switch (indexPath.row) {
        case 0: {
            cell.tfContent.text = _bindBankModel.name;
        }
            break;
        case 1: {
            cell.tfContent.text = _bindBankModel.identify;
        }
            break;
        case 2: {
            cell.tfContent.text = _bindBankModel.bankName;
        }
            break;
        case 3: {
            cell.tfContent.text = _bindBankModel.bandNo;
        }
            break;
        default:
            break;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    if (indexPath.section == 1) {
        BindBankViewCtr *vc = [[BindBankViewCtr alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - UITextField ValueChanged
- (void)valueChanged:(UITextField *)textField {
    NSInteger row = textField.tag - 100;
    switch (row) {
        case 0: {
            _bindBankModel.name = [NSString stringWithString:textField.text];
        }
            break;
        case 1: {
            _bindBankModel.identify = [NSString stringWithString:textField.text];
        }
            break;
        case 2: {
            
        }
            break;
        case 3: {
            _bindBankModel.bandNo = [NSString stringWithString:textField.text];
        }
            break;
        default:
            break;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    NSLog(@"进入托管");
    NSInteger row = textField.tag - 100;
    if (row == 2) {
        
        CGFloat xWidth = self.view.bounds.size.width - 20.0f;
        
        CGRect rect = self.view.frame;
        CGFloat yHeight = rect.size.height - 100;
        CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
        UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
        poplistview.delegate = self;
        poplistview.datasource = self;
        poplistview.listView.scrollEnabled = YES;
        [poplistview setTitle:@"选择银行"];
        [poplistview show];

        return NO;
    }
    return YES;
}

#pragma mark - 按钮事件
- (IBAction)saveAction:(id)sender {
    if (_bindBankModel.name.length == 0) {
        [self.view makeToast:@"请输入真实姓名"];
         return;
    }
    if (_bindBankModel.identify.length == 0) {
        [self.view makeToast:@"请输入身份证"];
        return;
    }
    if (_bindBankModel.bandNo.length == 0) {
        [self.view makeToast:@"请输入银行卡号"];
        return;
    }
    if (_bindBankModel.bankName.length == 0) {
        [self.view makeToast:@"请选择银行"];
        return;
    }
    
    NSInteger shopId = [ShareValue instance].shopModel.shopid.intValue;
    [[Http instance] bindBank:shopId name:_bindBankModel.name idcard:_bindBankModel.identify bank:_bindBankModel.bankName card:_bindBankModel.bandNo completion:^(NSError *error) {
        [self.view makeToast:@"绑定成功！"];
        
        ShopModel *shop = [ShareValue instance].shopModel;
        shop.isbingingcard = YES;
        [ShareValue instance].shopModel = shop;
    }];
}

#pragma mark - 获取银行列表
- (void)getBankList {
    kWEAKSELF;
    [[Http instance] bankList:^(NSError *error, NSArray *dataArray) {
        if (error.code == 0) {
            weakSelf.bankList = [NSMutableArray arrayWithArray:dataArray];
        }
    }];
}

#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:identifier];
    
    NSInteger row = indexPath.row;
    BankModel *bank = [_bankList objectAtIndex:row];
    cell.textLabel.text = bank.name;
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section {
    return _bankList.count;
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    BankModel *bank = [_bankList objectAtIndex:row];
    _bindBankModel.bankName = bank.name;
    _bindBankModel.bandNo = [NSString stringWithFormat:@"%ld", (long)bank.id];
    [_tableView reloadData];
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}
@end
