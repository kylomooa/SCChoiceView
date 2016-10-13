//
//  SCGreyView.h
//  SCChoiceTableView
//
//  Created by 毛强 on 16/10/13.
//  Copyright © 2016年 maoqiang. All rights reserved.
//

#import "SCGreyView.h"

@implementation SCGreyView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if (self.showOrHiddenTableViewBlock) {
        self.showOrHiddenTableViewBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
