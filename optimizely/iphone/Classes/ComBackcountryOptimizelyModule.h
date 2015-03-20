/**
 * optimizely
 *
 * Created by Alejandro Gomez
 * Copyright (c) 2015 . All rights reserved.
 */

#import "TiModule.h"

@interface ComBackcountryOptimizelyModule : TiModule
{
}

+(ComBackcountryOptimizelyModule*) shared;
@property (retain) NSDictionary *config;

@end
