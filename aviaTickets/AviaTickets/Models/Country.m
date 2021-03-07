//
//  Country.m
//  AviaTickets
//
//  Created by Nikita on 05.03.2021.
//

#import "Country.h"

@implementation Country

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _currency = [dictionary valueForKey: @"currency"];
        _name = [dictionary valueForKey: @"name"];
        _code = [dictionary valueForKey: @"code"];
        _translations = [dictionary valueForKey: @"translations"];
    }
    return self;
}

@end
