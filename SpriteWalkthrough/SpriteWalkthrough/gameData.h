//
//  NSObject+gameData.h
//  SpriteWalkthrough
//
//  Created by Abhishek Shinde on 04/02/15.
//  Copyright (c) 2015 com.claricetechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gameData : NSObject
@property int *highscore;
+(id)data;
-(void)save;
-(void)load;
@end
