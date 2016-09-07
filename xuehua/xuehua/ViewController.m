//
//  ViewController.m
//  xuehua
//
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) CADisplayLink* link;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"snowbg"].CGImage);
    
    UIImageView* bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"snowbg"]];
    bgImage.frame = self.view.bounds;
    [self.view addSubview:bgImage];
    
    CADisplayLink* link = [CADisplayLink displayLinkWithTarget:self selector:@selector(autoFall)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    self.link = link;
}
//点击开始 点击暂停
- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
    self.link.paused = !self.link.paused;
}

- (void)autoFall
{
    UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"雪花"]];
    
    //产生图片缩放 注意值是小数 接收时 使用float
    float ang = arc4random_uniform(50) / 100.0;
    image.transform = CGAffineTransformMakeScale(ang, ang);
    
    //宽度随机产生
    CGFloat imgX = arc4random_uniform(self.view.bounds.size.width);
    CGPoint imagePoint = CGPointMake(imgX, -10);
    image.center = imagePoint;
    [self.view addSubview:image];
    
    //动画改变frame  8秒执行y值的改变
    [UIView animateWithDuration:8.0f animations:^{
        //图片选中
        image.transform = CGAffineTransformRotate(image.transform, M_PI);
        
        image.center = CGPointMake(imgX, self.view.bounds.size.height + 10);
        image.alpha = 0.1;
    }
                     completion:^(BOOL finished) {
                         [image removeFromSuperview];
                     }];
    
    // NSLog(@"%@", NSStringFromCGRect(image.frame));
}


@end
