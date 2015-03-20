/**
 * optimizely
 *
 * Created by Alejandro Gomez
 * Copyright (c) 2015 . All rights reserved.
 */

#import "ComBackcountryOptimizelyModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"
#import <Optimizely/Optimizely.h>

@implementation ComBackcountryOptimizelyModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"9737b70e-67c9-4dc4-b942-2bb199b3d21d";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.backcountry.optimizely";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
//    [self loadConfig];
	NSLog(@"[INFO] %@ loaded",self);
}

+(void)load
{
    [self performSelectorDuringRunLoopStart:@selector(start:)];
}

-(void)resumed:(id)sender
{
    NSDictionary *options = [[TiApp app] launchOptions];
    if (options != nil) {
        NSString *url = [options objectForKey:@"url"];
        if ([Optimizely handleOpenURL:[NSURL URLWithString:url]]) {
            return YES;
        }
    }
    return NO;
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

+(ComBackcountryOptimizelyModule*) shared
{
    static ComBackcountryOptimizelyModule *singleton = NULL;

    @synchronized(singleton) {
        if (!singleton) {
            singleton = [ComBackcountryOptimizelyModule new];
        }
    }
    return singleton;
}

-(void)loadConfig
{
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"optimizelyConfig" ofType:@"json"];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:configPath];
    [self setConfig: [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil]];
    NSLog(@"[INFO] Optimizely config loaded %@", [self config]);
}

+(NSDictionary*)loadCon
{
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"optimizelyConfig" ofType:@"json"];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:configPath];
    NSDictionary *config = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return config;
}

+(void)start:(TiBindingRunLoop)runLoop
{
//    ComBackcountryOptimizelyModule *instance = [self shared];
    [Optimizely sharedInstance].verboseLogging = YES;
    [Optimizely startOptimizelyWithAPIToken:[[self loadCon] objectForKey:@"key"] launchOptions:nil];
}

@end
