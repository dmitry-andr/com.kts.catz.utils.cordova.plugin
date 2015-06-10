#import "CatzUtilPlugin.h"

@implementation CatzUtilPlugin

- (void)checkPlugin:(CDVInvokedUrlCommand*)command
{

    NSString* callbackId = [command callbackId];
    NSString* name = [[command arguments] objectAtIndex:0];
    NSString* msg = [NSString stringWithFormat: @"Response from iOS plugin - %@", name];
    
    
    BFSiOSUtilityPlugin* plugin = [BFSiOSUtilityPlugin new];
    
    [plugin initializeUnityCallBackParams:@"callBackObj" andMethodName:@"callbackMethod"];
    
    //plugin.parentController = self;
    
    NSLog(@"Reading callback params : %@ - > %@", plugin.unityCallbackObjectName, plugin.unityCallbackMethodName);
    
    //[plugin purchaseProduct:consItemId withUnityCallbackObjectName:nil andUnityCallbackMethodName:nil];
    

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self success:result callbackId:callbackId];
}

@end