//
//  YYShakeController.m
//  WeChat_Demo
//
//  Created by YYSky on 16/7/29.
//  Copyright © 2016年 YYSky. All rights reserved.
//

#import "YYShakeController.h"
#import "YYButton.h"

#define kImageViewHeight 320

@interface YYShakeController ()

@property (weak, nonatomic) YYButton *upSelectedBtn;

@property (weak, nonatomic) UIImageView *upImageView;
@property (weak, nonatomic) UIImageView *downImageView;
@property (weak, nonatomic) UIImageView *upLine;
@property (weak, nonatomic) UIImageView *downLine;
@property (weak, nonatomic) UIView      *searchView;

@end

@implementation YYShakeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.16 green:0.18 blue:0.18 alpha:1.00];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(clickAction)];

    [self setViewBG];
    
    [self loadBottomBtn];
    
    
    
    //加载摇一摇图片
    [self loadShakeImage];
    
    //动画效果
}
//实现摇一摇功能
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{

    self.upLine.hidden = NO;
    self.downLine.hidden = NO;
    [UIView animateWithDuration:0.6 animations:^{
       
        self.upImageView.y -= 60;
        self.upLine.y -= 60;
        
        self.downImageView.y += 60;
        self.downLine.y += 60;
        
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.6 animations:^{
            
            self.upImageView.y += 60;
            self.upLine.y += 60;
            
            self.downImageView.y -= 60;
            self.downLine.y -= 60;
            
        } completion:^(BOOL finished) {
            
            self.upLine.hidden = YES;
            self.downLine.hidden = YES;
            
            //弹出搜索框
            [self showSearchView];
            [self.searchView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:2.4];
        }];
    
    }];
}
//摇一摇结束后
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
}

- (void)showSearchView{

    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.downImageView.frame) - 16, kScreenWidth, 50)];
    
    UIActivityIndicatorView *actView = [[UIActivityIndicatorView alloc]init];
    [actView startAnimating];
    
    UILabel *txtLbl = [[UILabel alloc]init];
    NSString *str = @"正在搜索同一时间一起摇晃手机的人";
    txtLbl.text = str;
    txtLbl.textColor = [UIColor whiteColor];
    txtLbl.numberOfLines = 0;
    txtLbl.font = [UIFont systemFontOfSize:15];
   
    CGFloat actW = 20;
    CGFloat actH = actW;
    CGFloat margin = 10;
    
    CGSize txtSize = [str boundingRectWithSize:CGSizeMake(100, CGFLOAT_MAX)
                      options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:@{
                                   NSFontAttributeName:[UIFont systemFontOfSize:15]
                                   }
                      context:nil].size;
    CGFloat actX = (kScreenWidth - actW - txtSize.width - margin) * 0.5;
    CGFloat actY = (searchView.bounds.size.height - actH) * 0.5;
    
    actView.frame = CGRectMake(actX, actY, actW, actH);
    
    CGFloat txtX = CGRectGetMaxX(actView.frame) + margin;
    CGFloat txtY = (searchView.bounds.size.height - txtSize.height) * 0.5;
 
    txtLbl.frame = CGRectMake(txtX, txtY, txtSize.width, txtSize.height);
    
    [searchView addSubview:actView];
    [searchView addSubview:txtLbl];
    
    [self.view addSubview:searchView];
    self.searchView = searchView;
    
}

- (void)loadShakeImage{

    UIImage *upImage = [UIImage imageNamed:@"Shake_Logo_Up"];
    UIImageView *upImageView = [[UIImageView alloc]initWithImage:upImage];
    
    upImageView.frame = CGRectMake((kScreenWidth - upImage.size.width) * 0.5, kScreenHeight * 0.5 - 64 - upImage.size.height, upImage.size.width, upImage.size.height);
    
    UIImage *downImage = [UIImage imageNamed:@"Shake_Logo_Down"];
    UIImageView *downImageView = [[UIImageView alloc]initWithImage:downImage];
    
    downImageView.frame = CGRectMake((kScreenWidth - downImage.size.width) * 0.5, CGRectGetMaxY(upImageView.frame), downImage.size.width, downImage.size.height);
    
    UIImageView *upLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Shake_Line_Up"]];
    upLine.frame = CGRectMake(0, CGRectGetMaxY(upImageView.frame), kScreenWidth, 5);
    
    UIImageView *downLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Shake_Line_Down"]];
    downLine.frame = CGRectMake(0, downImageView.frame.origin.y - 5, kScreenWidth, 5);
    
    upLine.hidden = YES;
    downLine.hidden = YES;
    
    [self.view addSubview:upImageView];
    [self.view addSubview:downImageView];
    
    [self.view addSubview:upLine];
    [self.view addSubview:downLine];
    
    self.upImageView = upImageView;
    self.downImageView = downImageView;
    self.upLine = upLine;
    self.downLine = downLine;
    
}

- (void)loadBottomBtn{
    
    NSArray *titleArray = @[@"人",@"歌曲",@"电视"];
    NSArray *norImageArr = @[@"Shake_icon_people",@"Shake_icon_music",@"Shake_icon_tv"];
    NSArray *HLImageArr = @[@"Shake_icon_peopleHL",@"Shake_icon_musicHL",@"Shake_icon_tvHL"];
    
    CGFloat btnW = 80;
    CGFloat btnH = 60;
    CGFloat btnY = kScreenHeight - btnH - 100;
    
    CGFloat margin = (kScreenWidth - 3 * btnW) / 4;
    
    for (int i = 0; i < 3; i++) {
        
        YYButton *btn = [[YYButton alloc]init];
        
        [btn setImage:[UIImage imageNamed:norImageArr[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:HLImageArr[i]] forState:UIControlStateSelected];
        
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn  setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
        
        btn.frame = CGRectMake(margin + i * (btnW + margin), btnY, btnW, btnH);
        
        if (i == 0) {
            
            btn.selected = YES;
            self.upSelectedBtn = btn;
        }
        
        [self.view addSubview:btn];
    }

}

- (void)clickBtn:(YYButton *)sender{
    
    self.upSelectedBtn.selected = NO;
    sender.selected = YES;
    self.upSelectedBtn = sender;

}

- (void)setViewBG{
    
    UIImage *img = [UIImage imageNamed:@"ShakeHideImg_women"];

    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];

    imgView.userInteractionEnabled = YES;
    
    imgView.frame = CGRectMake((kScreenWidth - kImageViewHeight) * 0.5, kScreenHeight * 0.5 - kImageViewHeight * 0.5 - 50, kImageViewHeight, kImageViewHeight);

    [self.view addSubview:imgView];
}

- (void)clickAction{

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
