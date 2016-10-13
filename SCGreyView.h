//
//  SCGreyView.h
//  SCChoiceTableView
//
//  Created by 毛强 on 16/10/13.
//  Copyright © 2016年 maoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^showOrHiddenTableViewBlock)(void);

@interface SCGreyView : UIView
@property (nonatomic, copy) showOrHiddenTableViewBlock showOrHiddenTableViewBlock;
@end
