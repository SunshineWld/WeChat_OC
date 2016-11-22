

#import <UIKit/UIKit.h>

@class YYPictureModel,YYPictureCell;

@protocol YYPictureCellDelegate <NSObject>


@optional
- (void)pictureCell:(YYPictureCell *)cell withDidClickBtn:(UIButton *)btn;

@end

@interface YYPictureCell : UICollectionViewCell

+ (instancetype)pictureCell;

@property (weak, nonatomic) id<YYPictureCellDelegate> delegate;

@property (strong, nonatomic) YYPictureModel *model;

@end
