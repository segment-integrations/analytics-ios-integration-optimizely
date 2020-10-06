#import "SEGOptimizelyIntegration.h"
#if defined(__has_include) && __has_include(<Analytics/Analytics.h>)
#import <Analytics/SEGAnalyticsUtils.h>
#import <Analytics/SEGAnalytics.h>
#else
#import <Segment/SEGAnalyticsUtils.h>
#import <Segment/SEGAnalytics.h>
#endif
#import <Optimizely/Optimizely.h>

@implementation SEGOptimizelyIntegration

- (id)initWithSettings:(NSDictionary *)settings
{
    if (self = [super init]) {
        self.settings = settings;
        
        if ([(NSNumber *)[self.settings objectForKey:@"listen"] boolValue]) {
            SEGLog(@"Enabling Optimizely root.");
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(experimentDidGetViewed:)
                                                         name:OptimizelyExperimentVisitedNotification
                                                       object:nil];
        }
    }
    return self;
}

- (void)track:(SEGTrackPayload *)payload
{
    [Optimizely trackEvent:payload.event];
    SEGLog(@"[Optimizely trackEvent:%@];", payload.event);
}

- (void)identify:(SEGIdentifyPayload *)payload
{
    if(payload.userId){
        [Optimizely sharedInstance].universalUserId = payload.userId;
        SEGLog(@"[Optimizely sharedInstance].universalUserId = %@;", payload.userId);
    };
    
}

- (void)experimentDidGetViewed:(NSNotification *)notification
{
    NSString *experimentName = notification.userInfo[@"experiment_description"];
    for (OptimizelyExperimentData *data in [Optimizely sharedInstance].visitedExperiments) {
        if ([data.experimentName isEqualToString:experimentName]) {
            [[SEGAnalytics sharedAnalytics] track:@"Experiment Viewed"
                                       properties:@{
                                                    @"experimentId" : data.experimentId,
                                                    @"experimentName" : data.experimentName,
                                                    @"variationId" : data.variationId,
                                                    @"variationName" : data.variationName
                                                    }];
            break;
        }
    }
}

@end
