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

@implementation BindBankModel

@end

@interface BindBankViewCtr ()

@property (nonatomic, strong)IBOutlet UITableView *tableView;
@property (nonatomic, strong)IBOutlet UILabel *lblTopTips;
@property (nonatomic, strong)IBOutlet UIButton *btnConfirm;
@property (nonatomic, strong)IBOutlet UILabel *lblBottomTips;
@property (nonatomic, strong)BindBankModel *bindBankModel;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"进入托管");
    return YES;
}
@end
