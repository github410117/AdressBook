//
//  DialKeyboardViewController.m
//  我的通讯录
//
//  Created by xh on 16/5/20.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "DialKeyboardViewController.h"
#import "JCDialPad.h"
#import "JCPadButton.h"
#import "loadViewController.h"
#define ScreenX ([UIScreen mainScreen].bounds.origin.x)
#define ScreenY ([UIScreen mainScreen].bounds.origin.y)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)
#define ScreenW ([UIScreen mainScreen].bounds.size.width)

@interface DialKeyboardViewController ()<JCDialPadDelegate>

@end

@implementation DialKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    JCDialPad *pad = [[JCDialPad alloc] initWithFrame:CGRectMake(ScreenX, ScreenY, ScreenW, ScreenH) buttons:[[JCDialPad defaultButtons]arrayByAddingObjectsFromArray:@[self.twilioButton]]];
    pad.delegate = self;
    UIImageView *imagetest = [[UIImageView alloc] init];
    imagetest.image = [UIImage imageNamed:@"wallpaper"];
    pad.backgroundView = imagetest;
    [self.view addSubview:pad];
}
- (JCPadButton *)twilioButton
{
    UIImage *twilioIcon = [UIImage imageNamed:@"green"];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:twilioIcon];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    JCPadButton *twilioButton = [[JCPadButton alloc] initWithInput:@"T" iconView:iconView subLabel:@""];
    twilioButton.borderColor = [UIColor clearColor];
    return twilioButton;
}

- (BOOL)dialPad:(JCDialPad *)dialPad shouldInsertText:(NSString *)text forButtonPress:(JCPadButton *)button
{
    if ([text isEqualToString:@"T"]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Respond to button presses!"
//                                                        message:@"Check out the JCDialPadDelegate protocol to do this"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
        UIAlertController *call = [UIAlertController alertControllerWithTitle:@"提示" message:@"由于是模拟器，无法调用拨号界面!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [call addAction:ok];
//        button.transform = CGAffineTransformRotate(button.transform, 0.8);
        
        loadViewController *load = [[loadViewController alloc] init];
        
        load.Number = dialPad.rawText;
        
        [self presentViewController:load animated:YES completion:nil];
        return NO;
    } else if ([text isEqualToString:@"P"]) {
        NSURL *callURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", dialPad.rawText]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
        return NO;
    }
    return YES;
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

@end
