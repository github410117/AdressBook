//
//  loadViewController.m
//  我的通讯录
//
//  Created by etcxm on 16/5/24.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "loadViewController.h"
#import "JCDialPad.h"
#import "JCPadButton.h"
#define ScreenX ([UIScreen mainScreen].bounds.origin.x)
#define ScreenY ([UIScreen mainScreen].bounds.origin.y)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)
#define ScreenW ([UIScreen mainScreen].bounds.size.width)
@interface loadViewController ()<JCDialPadDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label1;


@end

@implementation loadViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    JCDialPad *pad = [[JCDialPad alloc] initWithFrame:CGRectMake(ScreenX, ScreenY, ScreenW, ScreenH)];
//                                              buttons:[[JCDialPad defaultButtons]arrayByAddingObjectsFromArray:@[self.twilioButton]]];
    pad.buttons = @[self.jingyin,self.bohaojianpan,self.mianti,self.jiahao,self.facetime,self.lianxiren,self.twilioButton];
    pad.delegate = self;
//    self.label1.text = _Number;
//    CGRect frame = self.label1.frame;
//    frame.size = CGSizeMake(375, 40);
//    self.label1.frame = frame;
//    CGPoint cen = self.label1.center;
//    cen.x = 375/2;
//    cen.y = self.view.frame.size.height / 6;
//    self.label1.center = cen;
//    self.label1.textColor = [UIColor whiteColor];
//    [pad addSubview:self.label1];
//    pad.backgroundColor = [UIColor lightGrayColor];
    pad.digitsTextField.text = _Number;
    UIImageView *imagetest = [[UIImageView alloc] init];
    imagetest.image = [UIImage imageNamed:@"maoboli"];
    pad.backgroundView = imagetest;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, 375, 40)];
    label2.textAlignment = NSTextAlignmentCenter;
//    frame.size = CGSizeMake(375, 40);
//    label2.frame = frame;
//    CGPoint cen = label2.center;
//    cen.x = 375/2;
//    cen.y = 90;
//    label2.center = cen;
    
    label2.text = @"正在呼叫...";
    label2.textColor = [UIColor whiteColor];
    [pad addSubview:label2];
    
    
    
    
    [self.view addSubview:pad];
    NSLog(@"%@",_Number);
}

- (JCPadButton *)twilioButton
{
    UIImage *twilioIcon = [UIImage imageNamed:@"callcall"];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:twilioIcon];
//    iconView.contentMode = UIViewContentModeScaleAspectFit;
    JCPadButton *twilioButton = [[JCPadButton alloc] initWithInput:@"T" iconView:iconView subLabel:@""];
    twilioButton.borderColor = [UIColor clearColor];
    return twilioButton;
}

- (JCPadButton *)lianxiren
{
    UIImage *twilioIcon = [UIImage imageNamed:@"lianxiren"];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:twilioIcon];
    //    iconView.contentMode = UIViewContentModeScaleAspectFit;
    JCPadButton *lianxiren = [[JCPadButton alloc] initWithInput:@"T" iconView:iconView subLabel:@""];
    //    twilioButton.borderColor = [UIColor clearColor];
    return lianxiren;
}

- (JCPadButton *)facetime
{
    UIImage *twilioIcon = [UIImage imageNamed:@"facetime1"];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:twilioIcon];
    //    iconView.contentMode = UIViewContentModeScaleAspectFit;
    JCPadButton *facetime = [[JCPadButton alloc] initWithInput:@"T" iconView:iconView subLabel:@""];
    //    twilioButton.borderColor = [UIColor clearColor];
    return facetime;
}

- (JCPadButton *)jiahao
{
    UIImage *twilioIcon = [UIImage imageNamed:@"jiahao"];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:twilioIcon];
    //    iconView.contentMode = UIViewContentModeScaleAspectFit;
    JCPadButton *jiahao = [[JCPadButton alloc] initWithInput:@"T" iconView:iconView subLabel:@""];
    //    twilioButton.borderColor = [UIColor clearColor];
    return jiahao;
}

- (JCPadButton *)mianti
{
    UIImage *twilioIcon = [UIImage imageNamed:@"mianti"];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:twilioIcon];
    //    iconView.contentMode = UIViewContentModeScaleAspectFit;
    JCPadButton *mianti = [[JCPadButton alloc] initWithInput:@"T" iconView:iconView subLabel:@""];
    //    twilioButton.borderColor = [UIColor clearColor];
    return mianti;
}


- (JCPadButton *)jingyin
{
    UIImage *twilioIcon = [UIImage imageNamed:@"jingyin"];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:twilioIcon];
    //    iconView.contentMode = UIViewContentModeScaleAspectFit;
    JCPadButton *jingyin = [[JCPadButton alloc] initWithInput:@"T" iconView:iconView subLabel:@""];
    //    twilioButton.borderColor = [UIColor clearColor];
    return jingyin;
}

- (JCPadButton *)bohaojianpan
{
    UIImage *twilioIcon = [UIImage imageNamed:@"bohaojianpan"];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:twilioIcon];
    //    iconView.contentMode = UIViewContentModeScaleAspectFit;
    JCPadButton *bohaojianpan = [[JCPadButton alloc] initWithInput:@"T" iconView:iconView subLabel:@""];
    //    twilioButton.borderColor = [UIColor clearColor];
    return bohaojianpan;
}

- (BOOL)dialPad:(JCDialPad *)dialPad shouldInsertText:(NSString *)text forButtonPress:(JCPadButton *)button
{
    if ([text isEqualToString:@"T"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
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
