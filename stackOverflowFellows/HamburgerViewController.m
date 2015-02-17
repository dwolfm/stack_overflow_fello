//
//  HamburgerViewController.m
//  stackOverflowFellows
//
//  Created by drwizzard on 2/16/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "HamburgerViewController.h"

@interface HamburgerViewController ()

@property (strong,nonatomic) UINavigationController *navController;
@property (strong,nonatomic) UIViewController *topViewController;

@property (strong, nonatomic) UIGestureRecognizer *tapToClose;
@property (strong, nonatomic) UIGestureRecognizer *slideRecognizer;

@property (strong,nonatomic) UIButton *burgerButton;
@property (strong,nonatomic) UITextField *searchField;


@end

@implementation HamburgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.navController];
//    self.navController.view.layer.shadowColor
    self.navController.view.layer.shadowRadius = 10;
    self.navController.view.layer.shadowOffset = CGSizeMake(0, 0);
    self.navController.view.layer.shadowRadius = 15;
    self.navController.view.layer.shadowOpacity = 0.7;
    self.navController.view.frame = self.view.frame;
    [self.view addSubview:self.navController.view];
    [self.navController didMoveToParentViewController:self];
    
    self.topViewController = self.navController;
    
    UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(10, 10, 25 , 25)];
    [button setBackgroundImage: [UIImage imageNamed:@"bad_hamburger"]  forState:UIControlStateNormal];
    [button addTarget:self action:@selector(burgerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.burgerButton = button;
    [self.navController.view addSubview:self.burgerButton];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50 , 10, self.view.frame.size.width - 70, 25)];
    UIView *searchPadding = [[ UIView alloc] initWithFrame:CGRectMake(45, 10, self.view.frame.size.width - 55, 25)];
    searchPadding.backgroundColor = [UIColor whiteColor];
    searchPadding.layer.cornerRadius = 5;
    searchPadding.layer.masksToBounds = true;

    textField.placeholder = @"Search:";
    textField.backgroundColor = [UIColor whiteColor];
    self.searchField = textField;
    [self.navController.view addSubview:searchPadding];
    [self.navController.view addSubview:self.searchField];
    
    self.tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeBurger)];
    self.slideRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action: @selector(slideBurger:)];
    [self.topViewController.view addGestureRecognizer:self.slideRecognizer];
}

-(BOOL)prefersStatusBarHidden {
    return true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma handle burger button

-(void) burgerButtonPressed {
    self.burgerButton.userInteractionEnabled = false;
    
    __weak HamburgerViewController *weakSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.topViewController.view.center = CGPointMake(weakSelf.topViewController.view.center.x + 150, weakSelf.topViewController.view.center.y);
    } completion:^(BOOL finished) {
        [weakSelf.topViewController.view addGestureRecognizer:self.tapToClose];
        [weakSelf.view addGestureRecognizer:weakSelf.slideRecognizer];
    }];
}

#pragma tapToClose UItapGR selector handler close burger func

-(void)closeBurger{
    [self.topViewController.view removeGestureRecognizer:self.tapToClose];
    
    __weak HamburgerViewController *weakSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.topViewController.view.center = weakSelf.view.center;
    }completion:^(BOOL finished) {
        weakSelf.burgerButton.userInteractionEnabled = true;
    }];
}

-(void)slideBurger:(id) sender {
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;

    CGPoint translatedPoint = [pan translationInView:self.view];
    CGPoint velocity = [pan velocityInView:self.view];
    
    if ( [pan state] == UIGestureRecognizerStateChanged){
        if ((velocity.x > 0 || self.topViewController.view.frame.origin.x > 0 ) && self.topViewController.view.frame.origin.x < 150){
            self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translatedPoint.x, self.topViewController.view.center.y);
            [pan setTranslation:CGPointZero inView:self.view];
        }
    }
    
    if ([pan state] == UIGestureRecognizerStateEnded) {
        __weak HamburgerViewController *weakSelf = self;

        
        if (self.topViewController.view.frame.origin.x > 30) {
            self.burgerButton.userInteractionEnabled = false;
            [UIView animateWithDuration:0.3 animations:^{
                self.topViewController.view.center = CGPointMake(weakSelf.view.frame.size.width /2 + 150, weakSelf.topViewController.view.center.y);
                
            }completion:^(BOOL finished) {
                [weakSelf.topViewController.view addGestureRecognizer:weakSelf.tapToClose];
            }];
        } else {
            self.burgerButton.userInteractionEnabled = false;
            __weak HamburgerViewController *weakSelf = self;
            
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.topViewController.view.center = weakSelf.view.center;
            }completion:^(BOOL finished) {
                weakSelf.burgerButton.userInteractionEnabled = true;
            }];
        }
    }
    
}


#pragma lazy load navController

-(UINavigationController *)navController {
    if (!_navController){
        NSLog(@"seting up navcontroller");
        _navController = [self.storyboard instantiateViewControllerWithIdentifier:@"NAV_CONTROLER"];
    }
    return _navController;
}




@end
