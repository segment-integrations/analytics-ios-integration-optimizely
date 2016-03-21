#import "SEGOptimizelyIntegration.h"
#import <Analytics/SEGAnalyticsUtils.h>
#import <Optimizely/Optimizely.h>
#import <Analytics/SEGAnalytics.h>

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
    [[Optimizely sharedInstance] setUserId:payload.userId];
    SEGLog(@"[Optimizely sharedInstance].userId = %@;", payload.userId);
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
