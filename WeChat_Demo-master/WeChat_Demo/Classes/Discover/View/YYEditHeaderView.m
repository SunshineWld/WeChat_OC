//
//  YYEditHeaderView.m
//  WeChat_Demo
//
//  Created by YYSky on 16/7/25.
//  Copyright © 2016年 YYSky. All rights reserved.
//

#import "YYEditHeaderView.h"
#import "YYPictureModel.h"

#define COL 4

@interface YYEditHeaderView ()<UITextViewDelegate>

@property (weak, nonatomic) UITextView *txtView;

@property (weak, nonatomic) UIButton *addBtn;

@property (strong, nonatomic) NSString *changeTxt;//记录用户的输入文字

@property (strong, nonatomic) NSMutableArray<UIButton *> *btnArray;


@end

@implementation YYEditHeaderView

- (NSMutableArray<UIButton *> *)btnArray{

    if (!_btnArray) {
        
        _btnArray = [NSMutableArray array];
    }
    
    return _btnArray;
}

- (instancetype)initWithModels:(NSArray<YYPictureModel *> *)models{
    
    if (self = [super init]) {
        
        NSInteger imageCount = models.count;
        
        NSInteger row = imageCount / COL + 1;
        
        
        CGFloat btnW = 65;
        CGFloat btnH  = btnW;
        CGFloat txtH = 120;
        CGFloat margin = 10;
        
        self.frame = CGRectMake(0, 0, kScreenWidth, btnH * row + txtH + 3 * margin + (row - 1)*margin);
        self.backgroundColor = [UIColor whiteColor];
        
        //    textContainer:[[NSTextContainer alloc]initWithSize:CGSizeMake(kScreenWidth - 20, txtH)]
        //    CGRectMake(0, margin, kScreenWidth, txtH)
        
        UITextView *txtView = [[UITextView alloc]init];
        txtView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        txtView.delegate = self;
        txtView.text = @"这一刻的想法...";
        txtView.textColor = [UIColor lightGrayColor];
        
        self.txtView = txtView;
        
        [self addSubview:txtView];
        
        if (imageCount < 9) {
            
            imageCount += 1;
            
            for (NSInteger i = 0; i < imageCount; i++) {
                
                UIButton *btn = [[UIButton alloc]init];
                
                if (i < imageCount - 1) {
                    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",models[i].icon];
                    
                    [btn setImage:[UIImage imageNamed: imageName] forState:UIControlStateNormal];
                }else if(i == imageCount - 1){
                
                    [btn setImage:[UIImage imageNamed:@"AlbumAddBtn"] forState:UIControlStateNormal];
                }
  
                [self addSubview:btn];
                
                [self.btnArray addObject:btn];
                
            }

        } else if (imageCount == 9){
            
            for (NSInteger i = 0; i < imageCount; i++) {
                
                UIButton *btn = [[UIButton alloc]init];
                
                
                NSString *imageName = [NSString stringWithFormat:@"%@.jpg",models[i].icon];
                
                [btn setImage:[UIImage imageNamed: imageName] forState:UIControlStateNormal];
                
                [self addSubview:btn];
                
                [self.btnArray addObject:btn];
                
            }
            
        }
    }
    return self;
    
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat btnW = 65;
    CGFloat btnH  = btnW;
    CGFloat txtH = 120;
    CGFloat margin = 10;
    
    self.txtView.frame = CGRectMake(0, margin, kScreenWidth, txtH);
    
    for (NSInteger i = 0; i < self.btnArray.count; i++) {
        
        UIButton *btn = self.btnArray[i];
        
        NSInteger col_index = i % COL;
        NSInteger row_index = i / COL;
        
        CGFloat btnX = margin + col_index * (btnW + margin);
        CGFloat btnY = margin + txtH + margin + row_index * (btnH + margin);
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
    }
   

}


#pragma mark - 代理方法
- (void)textViewDidBeginEditing:(UITextView *)textView{

    if (self.changeTxt.length == 0) {
        self.txtView.text = @"";
    }
    self.txtView.textColor = [UIColor blackColor];
}

- (void)textViewDidChange:(UITextView *)textView{

    self.changeTxt = textView.text;
}

- (void)textViewDidEndEditing:(UITextView *)textView{

    if (self.txtView.text.length == 0) {
        
        self.txtView.text = @"这一刻的想法...";
        self.txtView.textColor = [UIColor lightGrayColor];
    }
}


@end
