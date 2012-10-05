//
//  ElapsedTimeCalculator.h
//  HighRise
//
//  Created by Peerasak on 10/5/12.
//  Copyright (c) 2012 Peerasak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ElapsedTimeCalculator : NSObject

+ (NSString *)elapsedTimeFrom:(NSString *)time withFormat:(NSString *)format;

@end
