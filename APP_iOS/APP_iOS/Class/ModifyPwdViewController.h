//
//  ModifyPwdViewController.h
//  APP_iOS
//
//  Created by Li on 15/10/22.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "BaseViewController.h"

@interface ModifyPwdViewController : BaseViewController {
    
    __weak IBOutlet UITextField *_oldPwd;
    __weak IBOutlet UITextField *_newPwd0;
    __weak IBOutlet UITextField *_newPwd1;
}

@end
