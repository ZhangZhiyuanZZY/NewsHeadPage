//
//  ZYNewsHeadPageViewController.m
//  新闻首页
//
//  Created by 章芝源 on 15/11/22.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import "ZYNewsHeadPageViewController.h"
#import "ZYHeadlineNewsController.h"
#import "ZYHeadlineTileLabel.h"

@interface ZYNewsHeadPageViewController ()<UIScrollViewDelegate>
///标题视图
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrolView;
///内容视图
@property (weak, nonatomic) IBOutlet UIScrollView *contentViewScrollView;

@end

@implementation ZYNewsHeadPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"%@", self.titleScrolView);
//    NSLog(@"%@", self.view);
//    NSLog(@"%@", [UIScreen mainScreen]);
//    NSLog(@"%@", self.contentViewScrollView);
   }


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //在viewDidApper中设置这个属性, 无效, 因为view已经显示出来了
    ///设置scrollView不缩进
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSLog(@"%@", self.contentViewScrollView);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    NSLog(@"%@", self.titleScrolView);
//    NSLog(@"%@", self.view);
//    NSLog(@"%@", [UIScreen mainScreen]);
//    ZYHeadlineNewsController *zy = self.childViewControllers[0];
//    NSLog(@"%@", zy.view);
//    NSLog(@"%@", self.contentViewScrollView);
    
    //设置代理
    self.contentViewScrollView.delegate = self;
//    self.titleScrolView.delegate = self;
    
    ///显示新闻子控制器
    [self setupNewsController];
    
    ///创建标题视图上面的label
    [self addLabelTotitleScrolView];
    
    ///加载默认控制器
    ZYHeadlineNewsController *firstController = self.childViewControllers[0];
    firstController.view.frame = self.contentViewScrollView.bounds;
    [self.contentViewScrollView addSubview:firstController.view];

}


///显示新闻子控制器
- (void)setupNewsController
{
    ZYHeadlineNewsController *v01 = [[ZYHeadlineNewsController alloc]init];
    v01.title = @"头1";
    [self addChildViewController:v01];
    
    ZYHeadlineNewsController *v02 = [[ZYHeadlineNewsController alloc]init];
    v02.title = @"头2";
    [self addChildViewController:v02];
    
    ZYHeadlineNewsController *v03 = [[ZYHeadlineNewsController alloc]init];
    v03.title = @"头3";
    [self addChildViewController:v03];
    
    ZYHeadlineNewsController *v04 = [[ZYHeadlineNewsController alloc]init];
    v04.title = @"头4";
    [self addChildViewController:v04];
    
    ZYHeadlineNewsController *v05 = [[ZYHeadlineNewsController alloc]init];
    v05.title = @"头5";
    [self addChildViewController:v05];
    
    ZYHeadlineNewsController *v06 = [[ZYHeadlineNewsController alloc]init];
    v06.title = @"头6";
    [self addChildViewController:v06];
    
    ZYHeadlineNewsController *v07 = [[ZYHeadlineNewsController alloc]init];
    v07.title = @"头7";
    [self addChildViewController:v07];
    
    ///设置contentViewScrollView滚动范围
    CGFloat W = self.view.bounds.size.width * self.childViewControllers.count;
    self.contentViewScrollView.contentSize = CGSizeMake(W, 0);
    
    //设置分页效果
    self.contentViewScrollView.pagingEnabled = YES;
    ///取消滑动指示
    self.contentViewScrollView.showsHorizontalScrollIndicator = NO;
    
    CGFloat viewY = 0;
    CGFloat viewW = self.contentViewScrollView.bounds.size.width;
    CGFloat viewH = self.view.bounds.size.height - viewY;
    NSUInteger count = self.childViewControllers.count;
        //添加子控制器的view到控制器器的view上
    for (int i = 0; i < count ; i++ ) {
        ZYHeadlineNewsController *vc = self.childViewControllers[i];
        CGFloat viewX = i * self.view.bounds.size.width;
        vc.view.frame = CGRectMake(viewX, viewY, viewW, viewH);
//        NSLog(@"%@", vc.view);
        [self.contentViewScrollView addSubview:vc.view];
    }
}

///标题视图上面的label
- (void)addLabelTotitleScrolView
{
    //创建label
    NSUInteger count = self.childViewControllers.count;
    
    CGFloat labelY = 0;
    CGFloat labelW = 80;
    CGFloat labelH = 40;
    
    for (NSUInteger i = 0; i < count ; i++ ) {        
       
        //label的frame
        CGFloat labelX = labelW * i;
         ZYHeadlineTileLabel *label = [[ZYHeadlineTileLabel alloc]initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        
        //添加label到titleScrolView & 绑定tag
        label.tag = i;
        [self.titleScrolView addSubview:label];
        
        //label的文字
        // 设置文字
        UIViewController *vc = self.childViewControllers[i];
        label.text = vc.title;
        
        //设置label可交互
        label.userInteractionEnabled = YES;
        
        //给label添加点击事件
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLabel:)]];
         }
    ///设置titleScrolView的滚动范围
    CGFloat titleContentW =  count * labelW;
    self.titleScrolView.contentSize = CGSizeMake(titleContentW, 0);
    
   }


///点击label事件
- (void)clickLabel:(UITapGestureRecognizer *)gesture
{
    //获得点击的label
    ZYHeadlineTileLabel *lb = (ZYHeadlineTileLabel *)gesture.view;
    
    //计算x轴上的偏移量
    CGFloat offetX = lb.tag * [UIScreen mainScreen].bounds.size.width;
    
    //进行偏移
    [self.contentViewScrollView setContentOffset:CGPointMake(offetX, 0) animated:YES];
    
}


#pragma mark -  scrollView的代理方法
//这种写法在网易新闻,第一次翻页的时候, 会把后面的self.contentViewScrollView显示出来.
/*
//当调用[self.contentViewScrollView setContentOffset:CGPointMake(offetX, 0) animated:YES];
//会触发下面的函数, 用户用手滚动不会触发
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    //获得当前显示的子控制器
//    NSUInteger index = scrollView.contentOffset.x/ scrollView.bounds.size.width;
//    ZYHeadlineNewsController *vc = self.childViewControllers[index];
//    
//    //判断当前控制器的view是否已经被添加到contentScrollView上
//    if (vc.view.superview != nil)return;
//    
//    //把被选中控制器的view添加到contentScrollView上
//    CGFloat X = scrollView.contentOffset.x;
//    CGFloat Y = 0;
//    CGFloat W = scrollView.bounds.size.width;
//    CGFloat H = scrollView.bounds.size.height;
//    vc.view.frame = CGRectMake(X, Y, W, H);
//    
//    [self.contentViewScrollView addSubview:vc.view];
//}
//
////用户用手滚动的时候触发
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    [self scrollViewDidEndScrollingAnimation:scrollView];
//}
*/

///滚动contentView 让label进行滚动.
/*
 这个方法是滚动结束的时候调用的, 所以超出范围的滚动, 因为滚不过去, 这个方法并不会被调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat Width = self.titleScrolView.bounds.size.width;
    //拿到label
    NSInteger index = scrollView.contentOffset.x / Width;
    ZYHeadlineTileLabel *label = self.titleScrolView.subviews[index];
    //我们需要label的中心点, 在titleScrollView的中心
    //拿到label的偏移量
    CGFloat labelOffset = label.center.x - Width * 0.5;
    
    //设置让titleScrollview 左右两边label1, label2, label6, label7不滚动, 左右不留空白
    CGFloat maxLabelOffset = self.titleScrolView.contentSize.width - Width;
    if (labelOffset<0) {
        labelOffset=0;
    }else if(labelOffset > maxLabelOffset){
        labelOffset = maxLabelOffset;
    }
    //进行偏移
    [self.titleScrolView setContentOffset:CGPointMake(labelOffset, 0) animated:YES];
}


//实时监听scrollView的滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    //计算contentViewScrollView中左右tabelView的显示比例
//    CGFloat value = ABS(scrollView.contentOffset.x/ self.view.bounds.size.width);
//   
//    
//    //把比例传到label中设置label属性
//    NSInteger indexLeft = (NSInteger)(scrollView.contentOffset.x / self.view.bounds.size.width);
//    NSInteger indexRight = indexLeft + 1;
//    
//    CGFloat scaleLeft = value - indexLeft;
//    CGFloat scaleRight = 1 - scaleLeft;
//    ZYHeadlineTileLabel *labelLeft = self.titleScrolView.subviews[indexLeft];
//        labelLeft.scale = scaleLeft;
//    
//    ///防止越界
//    if (indexRight < self.titleScrolView.subviews.count) {
//        ZYHeadlineTileLabel *labelRight = self.titleScrolView.subviews[indexRight];
//        labelRight.scale = scaleRight;
//    }
    // 1. 需要进行控制的文字 (2个标题)
    // 2. 两个标题各自的比例值
#warning 这里最好取绝对值 (保证计算出来的比例是个非负数)
    // 偏移量 / 宽度
    CGFloat value = ABS(self.contentViewScrollView.contentOffset.x / self.contentViewScrollView.frame.size.width);
    
    // 左边文字的索引
    NSUInteger leftIndex = (NSUInteger)(self.contentViewScrollView.contentOffset.x / self.contentViewScrollView.frame.size.width);
    // 右边文字的索引
    NSUInteger rightIndex = leftIndex + 1;
    
    // 右边文字的比例    1 - 减去左边的才是右边的
    CGFloat rightScale = value - leftIndex;
    NSLog(@"%f", rightScale);
    // 左边文字的比例
    CGFloat leftScale = 1 - rightScale;
    
    // 取出label设置大小和颜色
    ZYHeadlineTileLabel *leftLabel = self.titleScrolView.subviews[leftIndex];
    leftLabel.scale = leftScale;
    if (rightIndex < self.titleScrolView.subviews.count) {
        ZYHeadlineTileLabel *rightLabel = self.titleScrolView.subviews[rightIndex];
        rightLabel.scale = rightScale;
    }

    
    
    
}



@end
