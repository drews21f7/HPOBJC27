//
//  DVMCharacterController.h
//  HPOBJC_ClimbAfternoon_27
//
//  Created by Drew Seeholzer on 7/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVMCharacter.h"


@interface DVMCharacterController : NSObject

//Shared instance
+ (instancetype) sharedInstance;

// FEtch character function
- (void)fetchCharacters:(void(^)(NSArray<DVMCharacter *> *characters))completion;

@end


