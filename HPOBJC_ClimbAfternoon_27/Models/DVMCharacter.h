//
//  DVMCharacter.h
//  HPOBJC_ClimbAfternoon_27
//
//  Created by Drew Seeholzer on 7/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMCharacter : NSObject

// Class Properties
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *wand;
@property (nonatomic, copy, readonly) NSString *house;
@property (nonatomic, copy, readonly) NSString *bloodStatus;
@property (nonatomic, readonly) BOOL deathEater;

// INIT
- (instancetype) initWithName: (NSString *) name
                         wand:(NSString *) wand
                        house:(NSString *) house
                  bloodStatus:(NSString *) bloodStatus
                   deathEater:(BOOL)deathEater;

@end

// Extension on character
@interface DVMCharacter (JSONConvertable)
// Convenience init that takes in a dictionary
-(instancetype) initWithDictionary: (NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
