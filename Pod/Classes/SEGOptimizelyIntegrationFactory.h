#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegrationFactory.h>

@interface SEGOptimizelyIntegrationFactory : NSObject<SEGIntegrationFactory>

// Optimizely needs to be initialized early in order to work correctly. The factory accepts the
// optimizely token and initializes it for you.
+ (instancetype)instanceWithToken:(NSString *)token launchOptions:(NSDictionary *)launchOptions;

@end