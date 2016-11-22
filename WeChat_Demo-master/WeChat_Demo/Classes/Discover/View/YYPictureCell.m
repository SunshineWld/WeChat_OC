

#import "YYPictureCell.h"
#import "YYPictureModel.h"

@interface YYPictureCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;


@end

@implementation YYPictureCell

#pragma mark - 点击  选中按钮
- (IBAction)clickSureBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(pictureCell:withDidClickBtn:)]) {
        
        [self.delegate pictureCell:self withDidClickBtn:sender];
    }
    
}

+ (instancetype)pictureCell{

    return [[[NSBundle mainBundle]loadNibNamed:@"YYPictureCell" owner:nil options:nil] lastObject];
}

- (void)setModel:(YYPictureModel *)model{

    _model = model;
    
    if (model.isClickedBtn) {
        
        self.sureBtn.selected = YES;
    }else {
        
        self.sureBtn.selected = NO;
    }
    
    NSString *iconName = [NSString stringWithFormat:@"%@.jpg",model.icon];
    self.iconView.image = [UIImage imageNamed:iconName];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
}

@end
