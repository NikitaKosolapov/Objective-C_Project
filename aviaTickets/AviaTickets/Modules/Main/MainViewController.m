//
//  MainViewController.m
//  KosolapovNikita
//
//  Created by Nikita on 03.03.2021.
//

#import "MainViewController.h"
#import "PlaceViewController.h"
#import "DataManager.h"

typedef struct SearchRequest {
    __unsafe_unretained NSString *origin;
    __unsafe_unretained NSString *destination;
    __unsafe_unretained NSDate *departDate;
    __unsafe_unretained NSDate *returnDate;
} SearchRequest;


@interface MainViewController ()<PlaceViewControllerDelegate>

@property (nonatomic, strong) UIButton *departureButton;
@property (nonatomic, strong) UIButton *arrivalButton;
@property (nonatomic) SearchRequest searchRequest;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataManager sharedInstance] loadData];
    [self setupUI];
}

-(void)placeButtonDidTap:(UIButton *)sender
{
    PlaceViewController *placeViewController;
    if([sender isEqual:_departureButton]) {
        placeViewController = [[PlaceViewController alloc] initWithType: Departure];
    } else {
        placeViewController = [[PlaceViewController alloc] initWithType: Arrival];
    }
    placeViewController.delegate = self;
    [self.navigationController pushViewController:placeViewController animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataManagerLoadDataDidComplete object:nil];
}

-(void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.title = @"Searching";
    
    _departureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_departureButton setTitle:@"From" forState:UIControlStateNormal];
    _departureButton.tintColor = UIColor.blackColor;
    _departureButton.frame = CGRectMake(30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width - 60, 40);
    _departureButton.backgroundColor = [[UIColor systemBlueColor] colorWithAlphaComponent:0.6];
    [_departureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_departureButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    _departureButton.layer.cornerRadius = _departureButton.frame.size.height / 2;
    [_departureButton setClipsToBounds:YES];
    [self.view addSubview:_departureButton];
    
    _arrivalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_arrivalButton setTitle:@"To" forState:UIControlStateNormal];
    _arrivalButton.tintColor = UIColor.blackColor;
    _arrivalButton.frame = CGRectMake(30.0, CGRectGetMaxY(_departureButton.frame) + 20.0, [UIScreen mainScreen].bounds.size.width - 60.0, 40.0);
    _arrivalButton.backgroundColor = [[UIColor systemBlueColor] colorWithAlphaComponent:0.6];
    [_arrivalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_arrivalButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    _arrivalButton.layer.cornerRadius = _arrivalButton.frame.size.height / 2;
    [_arrivalButton setClipsToBounds:YES];
    [self.view addSubview:_arrivalButton];
}

-(void)goToNextController
{
    PlaceViewController *placeViewController = [[PlaceViewController alloc] init];
    [self.navigationController pushViewController:placeViewController animated:true];
}

#pragma mark - PlaceViewControllerDelegate

- (void)selectPlace:(nonnull id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType {
    [self setPlace:place withDataType:dataType andPlaceType:placeType forButton: (placeType == Departure) ? _departureButton : _arrivalButton ];
}

- (void)setPlace:(id)place withDataType:(DataSourceType)dataType andPlaceType:(PlaceType)placeType forButton:(UIButton *)button {
    NSString *title;
    NSString *iata;
    if (dataType == DataSourceTypeCity) {
        City *city = (City *)place;
        title = city.name;
        iata = city.code;
    }
    else if (dataType == DataSourceTypeAirport) {
        Airport *airport = (Airport *)place;
        title = airport.name;
        iata = airport.cityCode;
    }
    if (placeType == Departure) {
        _searchRequest.origin = iata;
    } else {
        _searchRequest.destination = iata;
    }
    [button setTitle: title forState: UIControlStateNormal];
}

@end
