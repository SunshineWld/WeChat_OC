

#import "YYFriendHeaderView.h"

@implementation YYFriendHeaderView

+ (instancetype)friendHeaderView{

    return [[[NSBundle mainBundle]loadNibNamed:@"YYFriendHeaderView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{


}


@end
