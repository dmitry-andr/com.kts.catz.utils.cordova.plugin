#import <Cordova/CDV.h>
#import "BFSiOSUtilityPlugin.h"

@interface CatzUtilPlugin : CDVPlugin

- (void) checkPlugin:(CDVInvokedUrlCommand*)command;
- (void) billingPurchaseProduct:(CDVInvokedUrlCommand*)command;

@end