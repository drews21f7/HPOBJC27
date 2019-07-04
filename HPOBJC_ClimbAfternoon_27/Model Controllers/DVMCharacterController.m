//
//  DVMCharacterController.m
//  HPOBJC_ClimbAfternoon_27
//
//  Created by Drew Seeholzer on 7/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import "DVMCharacterController.h"
NS_ASSUME_NONNULL_BEGIN

// Magic Strings
static NSString * const baseURLString = @"https://www.potterapi.com/v1";
static NSString * const characterString = @"character";
static NSString * const apiKeyString = @"key";
static NSString * const apiKeyValue = @"$2a$10$uEUb0sbBGTrwN4dmVc58EuMdKYSc7LjRN1AOPH2J9fgX66iScioiy";

@implementation DVMCharacterController

// Shared instance implementation
+ (instancetype)sharedInstance
{
    //Make sure an instance of DVMCharacterController does not already exist
    static DVMCharacterController *sharedInstance = nil;
    // Dispatch the creation to a group, run it once, keep the token
    static dispatch_once_t onceToken;
    // Checks the token, if it exists, return out of the function
    dispatch_once(&onceToken, ^{
        //Init the shared instance
        sharedInstance = [DVMCharacterController new];
    });
    //Return the shared instance
    return sharedInstance;
}

//Fetch function implementation
-(void)fetchCharacters:(void (^)(NSArray<DVMCharacter *> *_Nullable))completion
{
    //Constructing URL
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *characterURL = [baseURL URLByAppendingPathComponent:characterString];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:characterURL resolvingAgainstBaseURL:true];
    
    //Add query items to url
    NSURLQueryItem *apiKey = [[NSURLQueryItem alloc] initWithName:apiKeyString value:apiKeyValue];
    
    urlComponents.queryItems = @[apiKey];
    
    //Final url
    NSURL *finalURL = urlComponents.URL;
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //Handle the error
        if (error)
        {
            NSLog(@"There was an issue with the URL : %@, %@", [error localizedDescription], error);
            completion(nil);
            return;
        }
        
        if (data)
        {
            // Serialize the json
            NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
            
            // Handle the error
            if (!topLevelDictionary)
            {
                NSLog(@"Error parsing the JSON : %@, %@", [error localizedDescription], error);
                completion(nil);
                return;
            }
            
            // Temporary array
            NSMutableArray *charactersArray = [NSMutableArray new];
            
            //Loop through the dictionaries found
            for (NSDictionary *characterDictionary in topLevelDictionary)
            {
                // Init the character from the dictionary found
                DVMCharacter *character = [[DVMCharacter alloc]initWithDictionary:characterDictionary];
                //Append the init character to the temp array
                [charactersArray addObject:character];
                //Complete with the temp array
                completion(charactersArray);
                
            }
        }
        
    }]resume ];
}

@end

NS_ASSUME_NONNULL_END
