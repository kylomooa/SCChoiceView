//
//  SCChoiceView.h
//  SCChoiceTableView
//
//  Created by 毛强 on 16/10/13.
//  Copyright © 2016年 maoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCGreyView.h"
//屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//色彩与透明度
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface SCChoiceView : UIView
@property (nonatomic, strong) NSArray *displayDataSources;

@end
