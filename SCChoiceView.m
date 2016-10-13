//
//  SCChoiceView.m
//  SCChoiceTableView
//
//  Created by 毛强 on 16/10/13.
//  Copyright © 2016年 maoqiang. All rights reserved.
//


//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "SCChoiceView.h"
#import "Masonry.h"


typedef enum : NSUInteger {
    directImagviewUp = 0,
    directImagviewDown,
} DirectImagviewStatus;


@interface SCChoiceView ()<UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>
//选择后的title
@property (nonatomic, strong) UILabel *titleLabel;
//图片
@property (nonatomic, strong) UIImageView *directionImageView;
//图片方向
@property (nonatomic, assign) DirectImagviewStatus directImagviewStatus;
//选择列表
@property (nonatomic, strong) UITableView *tableView;
//灰色背景
@property (nonatomic, strong) SCGreyView *greyView;
@end

@implementation SCChoiceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"listCell"];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.directionImageView];
    
    __weak typeof(self) weakSelf = self;
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.left);
        make.top.equalTo(weakSelf.top);
        make.bottom.equalTo(weakSelf.bottom);
        make.width.equalTo(SCREEN_WIDTH * 0.5 - 40);
    }];
    [self.directionImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel.right);
        make.top.equalTo(weakSelf.top);
        make.bottom.equalTo(weakSelf.bottom);
        make.right.equalTo(weakSelf.right);
    }];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.displayDataSources.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"listCell"];
    cell.backgroundColor = [UIColor whiteColor];
    if (nil == cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    }
    cell.textLabel.text = self.displayDataSources[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    return self.frame.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = RGBACOLOR(64, 180, 181, 1);
    //选择之后刷新titlabel
    self.titleLabel.text = self.displayDataSources[indexPath.row];
    [self showOrHiddenTableView];
}



#pragma mark - 点击显隐选择列表
-(void)showOrHiddenTableView{
    [self tableView];

    if (self.directImagviewStatus == directImagviewUp) {
        //添加灰色背景
        self.greyView.hidden = NO;
        //显示列表
        [UIView animateWithDuration:0.3 animations:^{
            
            self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.frame.size.height * 4);
        }];
        //修改imageview状态
        self.directImagviewStatus = directImagviewDown;
    }else{
        //移除灰色背景
        //隐藏列表
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 0);
        [UIView animateWithDuration:0.3 animations:^{
            self.greyView.hidden = YES;
        }];
      
        //修改imageview状态
        self.directImagviewStatus = directImagviewUp;
    }
    

}

#pragma mark - 子控件
-(UILabel *)titleLabel{
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.layer.borderWidth = 1;
        _titleLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _titleLabel.text = @"全部";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *titleLabelGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showOrHiddenTableView)];
        titleLabelGesture.delegate = self;
        [_titleLabel addGestureRecognizer:titleLabelGesture];
        self.directImagviewStatus = directImagviewUp;
    }
    return _titleLabel;
}

-(UIImageView *)directionImageView{
    if (nil == _directionImageView) {
        _directionImageView = [[UIImageView alloc]init];
        _directionImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *directionImageViewGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showOrHiddenTableView)];
        directionImageViewGesture.delegate = self;
        [_directionImageView addGestureRecognizer:directionImageViewGesture];
        self.directImagviewStatus = directImagviewUp;
    }
    return _directionImageView;
}

-(UITableView *)tableView{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.5, self.frame.size.height * 4) style:UITableViewStylePlain];
        CGRect relativeRect = [self convertRect:_tableView.frame toView:self.greyView];
        _tableView.frame = CGRectMake(relativeRect.origin.x, relativeRect.origin.y + self.frame.size.height, relativeRect.size.width, relativeRect.size.height);
        
        [self.greyView addSubview:_tableView];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(UIView *)greyView{
    if (nil == _greyView) {
        _greyView = [[SCGreyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _greyView.userInteractionEnabled = YES;
        _greyView.backgroundColor = RGBACOLOR(102, 102, 102, 0.5);
        
        //将灰色背景置于列表下面
        //必须在UIView已经添加到superView上时才能创建grayView;
        [self.superview addSubview:_greyView];
        [self.superview bringSubviewToFront:self];
        [self.superview insertSubview:_greyView belowSubview:self];
        __weak typeof(self) weakSelf = self;
        _greyView.showOrHiddenTableViewBlock = ^(void){
            [weakSelf showOrHiddenTableView];
        };
        _greyView.hidden = YES;
    }
    return _greyView;
}

-(NSArray *)displayDataSources{
    if (nil == _displayDataSources) {
        _displayDataSources = @[
                                @"病区一",
                                @"病区二",
                                @"病区三",
                                @"病区四",
                                @"病区五",
                                ];
    }
    return _displayDataSources;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
