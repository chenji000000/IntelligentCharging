//
//  EVTWelcomeViewController.m
//  IntelligentCharging
//
//  Created by 陈吉 on 16/3/7.
//  Copyright © 2016年 YF-IOS. All rights reserved.
//

#import "EVTWelcomeViewController.h"

/**屏幕的宽度*/
#define K_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/**屏幕的高度*/
#define K_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface EVTWelcomeViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation EVTWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置滚动视图
    [self setUpScrollView];
    
    //配置分页控件
    [self setUpPageControl];
}

/*配置分页控件*/
-(void)setUpPageControl
{
    //创建pageControl的实例
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    self.pageControl = pageControl;
    
    
    
    //配置pageControl
    pageControl.numberOfPages = 4;
    
    //关闭圆点与用户的交互功能
    pageControl.userInteractionEnabled = NO;
    
    
}


/*配置滚动视图*/
-(void)setUpScrollView
{
    //1创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
    
    //设置滚动视图的代理为当前控制器
    scrollView.delegate = self;
    
    //向滚动视图中添加多个图片子视图
    for(int i = 0; i < 4; i++)
    {
        //格式化出图片名称
        NSString *imageName = [NSString stringWithFormat:@"splash%d.png",i + 1];
        
        //创建一个图片视图对象
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        //设置图片视图的位置及大小
        //声明了一个结构体变量，其中x和y和width和height初始化为0
        CGRect iFrame = CGRectZero;
        iFrame.origin = CGPointMake(i * K_SCREEN_WIDTH, 0);
        iFrame.size = CGSizeMake(K_SCREEN_WIDTH, K_SCREEN_HEIGHT);
        
        imageView.frame = iFrame;
        
        //将图片视图添加到滚动视图中
        [scrollView addSubview:imageView];
        
        if(i == 3){
            //向此时的最后一屏图片视图中添加按钮
            [self addEnterButton:imageView];
            
        }
    }
    
    //设置滚动视图的内容大小
    scrollView.contentSize = CGSizeMake(4 * K_SCREEN_WIDTH, K_SCREEN_HEIGHT);
    
    //配置滚动视图到达边缘时不弹跳
    scrollView.bounces = NO;
    
    //配置滚动视图整页滚动
    scrollView.pagingEnabled = YES;
    
    //配置滚动视图不显示水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    
    
    //将滚动视图添加到控制器的view中
    [self.view addSubview:scrollView];
}


/*向图片视图中添加按钮*/
-(void)addEnterButton:(UIImageView*)imageView
{
    //开启图片视图的用户交互功能，否则里面的子视图按钮是不能接收用户的交互的
    imageView.userInteractionEnabled = YES;
    
    
    //创建按钮按钮
    UIButton *button = [[UIButton alloc] init];
    //设置按钮的frame
    button.frame = CGRectMake((K_SCREEN_WIDTH-150)/2, K_SCREEN_HEIGHT*0.6, 150, 40);
    
    //按钮的其他配置
    [button setTitle:@"进入应用" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightGrayColor];
    
    //将按钮添加到图片视图中
    [imageView addSubview:button];
    
    //为按钮添加事件响应
    [button addTarget:self action:@selector(enterApp:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*点击进入应用按钮后，执行该方法*/
-(void)enterApp:(UIButton*)button
{
    //实例化登录界面
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
    
    //获取应用的主window对象，先获取应用程序对象
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //更换window的根视图控制器为viewController
    
    window.rootViewController = navigationController;
    
    
    
    
    
    
}

#pragma mark - UIScrollViewDelegate 协议
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    //round函数的功能是四舍五入
    int index = round(scrollView.contentOffset.x/self.view.bounds.size.width);
    self.pageControl.currentPage = index;
    
    //    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
}



@end
