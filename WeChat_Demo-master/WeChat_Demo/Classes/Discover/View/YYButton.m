

#import "YYButton.h"

@implementation YYButton

- (void)setHighlighted:(BOOL)highlighted{

}

- (void)layoutSubviews{

    [super layoutSubviews];
    
//    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 5;
//    self.titleLabel.x = self.imageView.w * 0.5;
    
    self.imageView.frame = CGRectMake((self.w - self.imageView.image.size.width) * 0.5, 0, self.imageView.image.size.width, self.imageView.image.size.height);
    
    
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), self.w, self.h - CGRectGetMaxY(self.imageView.frame));
    
}

@end
