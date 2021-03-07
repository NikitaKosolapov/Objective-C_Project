//
//  DataManager.h
//  AviaTickets
//
//  Created by Nikita on 05.03.2021.
//

#import <Foundation/Foundation.h>
#import "City.h"
#import "Country.h"
#import "Airport.h"

#define kDataManagerLoadDataDidComplete @"DataManagerLoadDataDidComplete"

NS_ASSUME_NONNULL_BEGIN

typedef enum DataSourceType {
    DataSourceTypeCountry,
    DataSourceTypeCity,
    DataSourceTypeAirport
} DataSourceType;

@interface DataManager : NSObject

+(instancetype)sharedInstance;
-(void)loadData;

@property (nonatomic, strong, readonly) NSArray *countries;
@property (nonatomic, strong, readonly) NSArray *cities;
@property (nonatomic, strong, readonly) NSArray *airports;

@end

NS_ASSUME_NONNULL_END
