//
//  MainViewController.m
//  KosolapovNikita
//
//  Created by Nikita on 03.03.2021.
//

#import "MainViewController.h"
#import "SecondViewController.h"
#import "DataManager.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataManager sharedInstance] loadData];
    self.view.backgroundColor = [UIColor yellowColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataComplete) name:kDataManagerLoadDataDidComplete object:nil];
    self.setupUI;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataManagerLoadDataDidComplete object:nil];
}

- (void)loadDataComplete
{
    self.view.backgroundColor = [UIColor redColor];
}

-(void)setupUI
{
    CGRect buttonFrame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2, 200, 40);
    UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
    [button setTitle:@"Go to the next screen" forState:UIControlStateNormal];
    button.frame = buttonFrame;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(goToNextController) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview: button];
}

-(void)goToNextController
{
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondViewController animated:true];
}


@end
