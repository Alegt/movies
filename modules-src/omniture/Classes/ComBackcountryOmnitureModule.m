#import "ComBackcountryOmnitureModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import <objc/runtime.h>

@implementation ComBackcountryOmnitureModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"366a1cfe-1bb1-432e-b4c9-d81feba33269";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.backcountry.omniture";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	NSLog(@"[INFO] %@ loaded version, %@", self, [ADBMobile version]);
}

+(void)load
{
	NSLog(@"[OMNITURE] load");
    NSLog(@"[OMNITURE] collectLifecycleData");
    [ADBMobile collectLifecycleData];
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

#pragma mark - ADBMobile

MAKE_SYSTEM_PROP(PRIVACY_STATUS_OPT_IN, ADBMobilePrivacyStatusOptIn);
MAKE_SYSTEM_PROP(PRIVACY_STATUS_OPT_OUT, ADBMobilePrivacyStatusOptOut);
MAKE_SYSTEM_PROP(PRIVACY_STATUS_OPT_UNKNOWN, ADBMobilePrivacyStatusUnknown);

#pragma mark - Configuration

- (NSString *) version {
    NSLog(@"[OMNITURE] version");
    return [ADBMobile version];
}

- (ADBMobilePrivacyStatus) getPrivacyStatus {
    NSLog(@"[OMNITURE] getPrivacyStatus");
    return [ADBMobile privacyStatus];
}

- (void) setPrivacyStatus:(id)args {
    ENSURE_SINGLE_ARG(args, NSNumber);
    NSLog(@"[OMNITURE] setPrivacyStatus %@", args);
    ADBMobilePrivacyStatus status = [TiUtils intValue:args];
    [ADBMobile setPrivacyStatus:status];
}

- (NSDecimalNumber *) lifetimeValue {
    NSLog(@"[OMNITURE] lifetimeValue");
    return [ADBMobile lifetimeValue];
}

- (NSString *) getUserIdentifier {
    NSLog(@"[OMNITURE] getUserIdentifier");
    return [ADBMobile userIdentifier];
}

- (void) setUserIdentifier:(NSString *)identifier {
    NSLog(@"[OMNITURE] setUserIdentifier %@", identifier);
    [ADBMobile setUserIdentifier:identifier];
}

- (BOOL) getDebugLogging {
    NSLog(@"[OMNITURE] getDebugLogging");
    return [ADBMobile debugLogging];
}

- (void) setDebugLogging:(BOOL)debug {
    NSLog(@"[OMNITURE] setDebugLogging %i", debug);
    [ADBMobile setDebugLogging:debug];
}

- (void) keepLifecycleSessionAlive:(id)args {
    NSLog(@"[OMNITURE] keepLifecycleSessionAlive");
    [ADBMobile keepLifecycleSessionAlive];
}

- (void) collectLifecycleData:(id)args {
    NSLog(@"[OMNITURE] collectLifecycleData");
    [ADBMobile collectLifecycleData];
}

#pragma mark - Analytics

- (void) trackState:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] trackState %@", args);
    [ADBMobile trackState: [TiUtils stringValue:[args objectForKey:@"state"]]
                     data: [args objectForKey:@"data"]];
}

//- (void) trackAction:(NSString *)action data:(NSDictionary *)data;
- (void) trackAction:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] trackAction %@", args);
    [ADBMobile trackAction: [TiUtils stringValue:[args objectForKey:@"action"]]
                      data: [args objectForKey:@"data"]];
}

//- (void) trackActionFromBackground:(NSString *)action data:(NSDictionary *)data;
- (void) trackActionFromBackground:(id)args {
   ENSURE_SINGLE_ARG(args, NSDictionary);
   NSLog(@"[OMNITURE] trackActionFromBackground %@", args);
   [ADBMobile trackActionFromBackground: [TiUtils stringValue:[args objectForKey:@"action"]]
                                   data: [args objectForKey:@"data"]];
}

//- (void) trackLocation:(CLLocation *)location data:(NSDictionary *)data;
- (void) trackLocation:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] trackLocation %@", args);
    CLLocation *location = [[[CLLocation alloc] initWithLatitude:[TiUtils doubleValue:[args objectForKey:@"latitude"]] longitude:[TiUtils doubleValue:[args objectForKey:@"longitude"]]] autorelease];
    [ADBMobile trackLocation:location data:[args objectForKey:@"data"]];
}

//- (void) trackLifetimeValueIncrease:(NSDecimalNumber *)amount data:(NSDictionary *)data;
- (void) trackLifetimeValueIncrease:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] trackLifetimeValueIncrease %@", args);
    NSNumber* amount = [NSDecimalNumber numberWithFloat:[TiUtils floatValue:[args objectForKey:@"amount"]]];
    [ADBMobile trackLifetimeValueIncrease: amount
                                     data: [args objectForKey:@"data"]];
}


//- (void) trackTimedActionStart:(NSString *)action data:(NSDictionary *)data;
- (void) trackTimedActionStart:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] trackTimedActionStart %@", args);
    [ADBMobile trackTimedActionStart: [TiUtils stringValue:[args objectForKey:@"action"]]
                                data: [args objectForKey:@"data"]];
}

//- (void) trackTimedActionUpdate:(NSString *)action data:(NSDictionary *)data;
- (void) trackTimedActionUpdate:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] trackTimedActionUpdate %@", args);
    [ADBMobile trackTimedActionUpdate: [TiUtils stringValue:[args objectForKey:@"action"]]
                                data: [args objectForKey:@"data"]];
}

//- (void) trackTimedActionEnd:(NSString *)action logic:(BOOL (^)(NSTimeInterval inAppDuration, NSTimeInterval totalDuration, NSMutableDictionary *data))block;
- (void) trackTimedActionEnd:(NSString *)action {
    ENSURE_SINGLE_ARG(action, NSString);
    NSLog(@"[OMNITURE] trackTimedActionEnd %@", action);
    [ADBMobile trackTimedActionEnd:action logic:nil];
}

- (BOOL) trackingTimedActionExists:(NSString *)action {
    ENSURE_SINGLE_ARG(action, NSString);
    NSLog(@"[OMNITURE] trackingTimedActionExists %@", action);
    return [ADBMobile trackingTimedActionExists:action];
}

- (NSString *) trackingIdentifier {
    NSLog(@"[OMNITURE] trackingIdentifier");
    return [ADBMobile trackingIdentifier];
}

- (void) trackingClearQueue:(id)args {
    NSLog(@"[OMNITURE] trackingClearQueue");
    [ADBMobile trackingClearQueue];
}

- (NSNumber *) trackingGetQueueSize {
    NSLog(@"[OMNITURE] trackingGetQueueSize");
    NSInteger size = (NSInteger)[ADBMobile trackingGetQueueSize];
    return [NSNumber numberWithInteger:size];
}

#pragma mark - Target

MAKE_SYSTEM_PROP(TARGET_PARAMETER_ORDER_ID, ADBTargetParameterOrderId);
MAKE_SYSTEM_PROP(TARGET_PARAMETER_ORDER_TOTAL, ADBTargetParameterOrderTotal);
MAKE_SYSTEM_PROP(TARGET_PARAMETER_ORDER_PRODUCT_PURCHASED_ID, ADBTargetParameterProductPurchasedId);
MAKE_SYSTEM_PROP(TARGET_PARAMETER_CATEGORY_ID, ADBTargetParameterCategoryId);
MAKE_SYSTEM_PROP(TARGET_PARAMETER_MBOX_3RD_PARTY_ID, ADBTargetParameterMbox3rdPartyId);
MAKE_SYSTEM_PROP(TARGET_PARAMETER_MBOX_PAGE_VALUE, ADBTargetParameterMboxPageValue);
MAKE_SYSTEM_PROP(TARGET_PARAMETER_MBOX_PC, ADBTargetParameterMboxPc);
MAKE_SYSTEM_PROP(TARGET_PARAMETER_MBOX_SESSION_ID, ADBTargetParameterMboxSessionId);
MAKE_SYSTEM_PROP(TARGET_PARAMETER_MBOX_HOST, ADBTargetParameterMboxHost);

//- (void) targetLoadRequest:(ADBTargetLocationRequest *)request callback:(void (^)(NSString *content))callback;
- (void) targetLoadRequest:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] targetLoadRequest %@", args);
    ADBTargetLocationRequest *request = [ADBMobile targetCreateRequestWithName: [TiUtils stringValue:[args objectForKey:@"name"]]
                               defaultContent: [TiUtils stringValue:[args objectForKey:@"defaultContent"]]
                                   parameters: [args objectForKey:@"parameters"]];

    [ADBMobile targetLoadRequest:request callback:^(NSString *content) {
        KrollCallback* callback = [args objectForKey:@"callback"];
        if (callback) {
            NSArray* array = [NSArray arrayWithObjects: content, nil];
            [callback call:array thisObject:nil];
        }
    }];
}

- (void) targetLoadOrderConfirmRequest:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] targetLoadOrderConfirmRequest %@", args);
    ADBTargetLocationRequest *request = [ADBMobile targetCreateOrderConfirmRequestWithName: [TiUtils stringValue:[args objectForKey:@"name"]]
                                orderId: [TiUtils stringValue:[args objectForKey:@"orderId"]]
                             orderTotal: [TiUtils stringValue:[args objectForKey:@"orderTotal"]]
                     productPurchasedId: [TiUtils stringValue:[args objectForKey:@"productPurchasedId"]]
                             parameters: [args objectForKey:@"parameters"]];

    [ADBMobile targetLoadRequest:request callback:^(NSString *content) {
        KrollCallback* callback = [args objectForKey:@"callback"];
        if (callback) {
            NSArray* array = [NSArray arrayWithObjects: content, nil];
            [callback call:array thisObject:nil];
        }
    }];
}

- (void) targetClearCookies:(id)args {
    NSLog(@"[OMNITURE] targetClearCookies");
    [ADBMobile targetClearCookies];
}

#pragma mark - Audience Manager

- (NSDictionary *) audienceVisitorProfile {
    NSLog(@"[OMNITURE] audienceVisitorProfile");
    return [ADBMobile audienceVisitorProfile];
}

- (NSString *) audienceDpid {
    NSLog(@"[OMNITURE] audienceDpid");
    return [ADBMobile audienceDpid];
}

- (NSString *) audienceDpuuid {
    NSLog(@"[OMNITURE] audienceDpuuid");
    return [ADBMobile audienceDpuuid];
}

//- (void) audienceSetDpid:(NSString *)dpid dpuuid:(NSString *)dpuuid;
- (void) audienceSet:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] audienceSet %@", args);
    [ADBMobile audienceSetDpid: [TiUtils stringValue:[args objectForKey:@"dpid"]]
                        dpuuid: [TiUtils stringValue:[args objectForKey:@"dpuuid"]]];
}

//- (void) audienceSignalWithData:(NSDictionary *)data callback:(void (^)(NSDictionary *response))callback;
- (void) audienceSignalWithData:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] audienceSignalWithData %@", args);
    [ADBMobile audienceSignalWithData:args callback:^(NSDictionary *response) {
        KrollCallback* callback = [args objectForKey:@"callback"];
        if (callback) {
           NSArray* array = [NSArray arrayWithObjects: response, nil];
           [callback call:array thisObject:nil];
        }
    }];
}

#pragma mark - Media Analytics

//- (void) mediaOpenWithSettings:(ADBMediaSettings *)settings callback:(void (^)(ADBMediaState *mediaState))callback;
- (void) mediaOpenWithSettings:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] mediaOpenWithSettings %@", args);
    ADBMediaSettings *mediaSettings = [ADBMobile mediaCreateSettingsWithName: [TiUtils stringValue:[args objectForKey:@"name"]]
                                        length: [TiUtils doubleValue:[args objectForKey:@"length"]]
                                    playerName: [TiUtils stringValue:[args objectForKey:@"playerName"]]
                                      playerID: [TiUtils stringValue:[args objectForKey:@"playerID"]]];

    mediaSettings.segmentByMilestones = [TiUtils boolValue:[args objectForKey:@"segmentByMilestones"]];
    mediaSettings.segmentByOffsetMilestones = [TiUtils boolValue:[args objectForKey:@"segmentByOffsetMilestones"]];
    mediaSettings.channel = [TiUtils stringValue:[args objectForKey:@"channel"]];
    mediaSettings.milestones = [TiUtils stringValue:[args objectForKey:@"milestones"]];
    mediaSettings.offsetMilestones = [TiUtils stringValue:[args objectForKey:@"offsetMilestones"]];
    mediaSettings.trackSeconds = [TiUtils intValue:[args objectForKey:@"trackSeconds"]];
    mediaSettings.completeCloseOffsetThreshold = [TiUtils intValue:[args objectForKey:@"completeCloseOffsetThreshold"]];

    [ADBMobile mediaOpenWithSettings:mediaSettings callback:^void(ADBMediaState *mediaState) {
        KrollCallback* callback = [args objectForKey:@"callback"];
        if (callback) {
            NSDictionary* dict = [ComBackcountryOmnitureModule dictionaryWithPropertiesOfObject:mediaState];
            NSArray* array = [NSArray arrayWithObjects: dict, nil];
            [callback call:array thisObject:nil];
        }
    }];
}

- (void) mediaAdOpenWithSettings:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] mediaOpenWithSettings %@", args);
    ADBMediaSettings *mediaSettings = [ADBMobile mediaCreateSettingsWithName: [TiUtils stringValue:[args objectForKey:@"name"]]
                                        length: [TiUtils doubleValue:[args objectForKey:@"length"]]
                                    playerName: [TiUtils stringValue:[args objectForKey:@"playerName"]]
                                    parentName: [TiUtils stringValue:[args objectForKey:@"parentName"]]
                                     parentPod: [TiUtils stringValue:[args objectForKey:@"parentPod"]]
                             parentPodPosition: [TiUtils doubleValue:[args objectForKey:@"parentPodPosition"]]
                                           CPM: [TiUtils stringValue:[args objectForKey:@"CPM"]]];

    [ADBMobile mediaOpenWithSettings:mediaSettings callback:^void(ADBMediaState *mediaState) {
        KrollCallback* callback = [args objectForKey:@"callback"];
        if (callback) {
            NSDictionary* dict = [ComBackcountryOmnitureModule dictionaryWithPropertiesOfObject:mediaState];
            NSArray* array = [NSArray arrayWithObjects: dict, nil];
            [callback call:array thisObject:nil];
        }
    }];
}

- (void) mediaClose:(NSString *)name {
    ENSURE_SINGLE_ARG(name, NSString);
    NSLog(@"[OMNITURE] mediaClose %@", name);
    [ADBMobile mediaClose:name];
}

//- (void) mediaPlay:(NSString *)name offset:(double)offset;
- (void) mediaPlay:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] mediaPlay %@", args);
    [ADBMobile mediaPlay: [TiUtils stringValue:[args objectForKey:@"name"]]
                  offset: [TiUtils doubleValue:[args objectForKey:@"offset"]]];
}

//- (void) mediaComplete:(NSString *)name offset:(double)offset;
- (void) mediaComplete:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] mediaComplete %@", args);
    [ADBMobile mediaComplete: [TiUtils stringValue:[args objectForKey:@"name"]]
                      offset: [TiUtils doubleValue:[args objectForKey:@"offset"]]];
}

//- (void) mediaStop:(NSString *)name offset:(double)offset;
- (void) mediaStop:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] mediaStop %@", args);
    [ADBMobile mediaStop: [TiUtils stringValue:[args objectForKey:@"name"]]
                  offset: [TiUtils doubleValue:[args objectForKey:@"offset"]]];
}

//- (void) mediaClick:(NSString *)name offset:(double)offset;
- (void) mediaClick:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] mediaClick %@", args);
    [ADBMobile mediaClick: [TiUtils stringValue:[args objectForKey:@"name"]]
                   offset: [TiUtils doubleValue:[args objectForKey:@"offset"]]];
}

//- (void) mediaTrack:(NSString *)name data:(NSDictionary *)data;
- (void) mediaTrack:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[OMNITURE] mediaTrack %@", args);
    [ADBMobile mediaTrack: [TiUtils stringValue:[args objectForKey:@"name"]]
                     data: [args objectForKey:@"data"]];
}

+(NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);

    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        [dict setObject:[obj valueForKey:key] forKey:key];
    }

    free(properties);

    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
