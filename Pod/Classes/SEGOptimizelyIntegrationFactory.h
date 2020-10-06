#import <Foundation/Foundation.h>
#if defined(__has_include) && __has_include(<Analytics/SEGAnalytics.h>)
#import <Analytics/SEGIntegrationFactory.h>
#else
#import <Segment/SEGIntegrationFactory.h>
#endif

@interface SEGOptimizelyIntegrationFactory : NSObject<SEGIntegrationFactory>

// Optimizely needs to be initialized early in order to work correctly. The factory accepts the
// optimizely token and initializes it for you.
+ (instancetype)instanceWithToken:(NSString *)token launchOptions:(NSDictionary *)launchOptions;

@end