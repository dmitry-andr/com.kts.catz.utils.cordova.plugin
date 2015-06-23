#import <Cordova/CDV.h>
#import "BFSiOSUtilityPlugin.h"
#import "BFSiOSPurchViewController.h"

@interface CatzUtilPlugin : CDVPlugin<BFSiOSPurchViewControllerControllerDelegate>

- (void) checkPlugin:(CDVInvokedUrlCommand*)command;
- (void) billingPurchaseProduct:(CDVInvokedUrlCommand*)command;

@property (nonatomic, retain) NSString *purchaseResponseData;
@property (nonatomic, retain) NSString *currentCallbackId;

@end