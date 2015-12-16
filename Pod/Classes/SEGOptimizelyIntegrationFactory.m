#import "SEGOptimizelyIntegrationFactory.h"
#import "SEGOptimizelyIntegration.h"
#import <Optimizely/Optimizely.h>

@implementation SEGOptimizelyIntegrationFactory

+ (instancetype)instanceWithToken:(NSString *)token launchOptions:(NSDictionary *)launchOptions
{
    static dispatch_once_t once;
    static SEGOptimizelyIntegrationFactory *sharedInstance;
    dispatch_once(&once, ^{
        [Optimizely startOptimizelyWithAPIToken:token launchOptions:launchOptions];
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    return self;
}

- (id<SEGIntegration>)createWithSettings:(NSDictionary *)settings forAnalytics:(SEGAnalytics *)analytics
{
    return [[SEGOptimizelyIntegration alloc] initWithSettings:settings];
}

- (NSString *)key
{
    return @"Optimizely";
}

@end