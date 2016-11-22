//
//  YYEditPicTableController.h
//  WeChat_Demo
//
//  Created by YYSky on 16/7/24.
//  Copyright © 2016年 YYSky. All rights reserved.
//

#import "YYBaseTableController.h"

@class YYPictureModel;

@interface YYEditPicTableController : YYBaseTableController

@property (strong, nonatomic) NSArray<YYPictureModel *> *imageArray;

@end
