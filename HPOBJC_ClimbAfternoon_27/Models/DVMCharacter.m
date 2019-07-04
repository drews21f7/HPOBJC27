//
//  DVMCharacter.m
//  HPOBJC_ClimbAfternoon_27
//
//  Created by Drew Seeholzer on 7/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import "DVMCharacter.h"

//Magic strings
static NSString * const nameKey = @"name";
static NSString * const wandKey = @"wand";
static NSString * const houseKey = @"house";
static NSString * const bloodStatusKey = @"bloodStatus";
static NSString * const deathEaterKey = @"deathEater";

@implementation DVMCharacter
//Init with name implementation
- (instancetype)initWithName:(NSString *)name wand:(NSString *)wand house:(NSString *)house bloodStatus:(NSString *)bloodStatus deathEater:(BOOL)deathEater
{
    self = [super init];
    if (self != nil)
    {
        _name = name;
        _wand = wand;
        _house = house;
        _bloodStatus = bloodStatus;
        _deathEater = deathEater;
        
    }
    return self;
}


@end

@implementation DVMCharacter (JSONConvertable)
// Init with dictionary implementation
-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    // Grabbing the values for the keys in the JSON
    NSString *name = dictionary[nameKey];
    NSString *wand = dictionary[wandKey];
    NSString *house = dictionary[houseKey];
    NSString *bloodStatus = dictionary[bloodStatusKey];
    BOOL deathEater = [dictionary[deathEaterKey] boolValue];
    
    // Pass the values into our class init to create a character object
    return [self initWithName:name wand:wand house:house bloodStatus:bloodStatus deathEater:deathEater];
}

@end
