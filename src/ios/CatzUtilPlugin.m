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
    NSLog(@"Message from billing custom utility : %@", plugin.getTestMessage);
    
    //[plugin purchaseProduct:consItemId withUnityCallbackObjectName:nil andUnityCallbackMethodName:nil];
    
    
    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:plugin.getTestMessage];
    
    [self success:result callbackId:callbackId];
}


- (void)billingPurchaseProduct:(CDVInvokedUrlCommand*)command
{
    NSLog(@"Purchase dialog launched ... ");
    
    NSString* callbackId = [command callbackId];
    self.currentCallbackId = callbackId;
    
    NSString* itemID = [[command arguments] objectAtIndex:0];
    NSLog(@"Item ID for purchase : %@", itemID);
    
    
    BFSiOSUtilityPlugin* plugin = [BFSiOSUtilityPlugin new];
    
    [plugin initializeUnityCallBackParams:@"callBackObj" andMethodName:@"callbackMethod"];
    
    plugin.parentController = self.viewController;
    [plugin purchaseProduct:itemID withUnityCallbackObjectName:nil andUnityCallbackMethodName:nil andCallbackDelegate:self];
    /*
     CDVPluginResult* result = [CDVPluginResult
     resultWithStatus:CDVCommandStatus_OK
     messageAsString:self.purchaseResponseData];
     
     [self success:result callbackId:callbackId];
     */
}

-(void) dataFromPurchViewController:(NSString *)data{
    NSLog(@"Recieved data from purch view controller : %@", data);
    self.purchaseResponseData = data;
    [self completeCommandActionWithCallbackId:self.currentCallbackId];
    
}

- (void)completeCommandActionWithCallbackId:(NSString*) callbackId
{
    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:self.purchaseResponseData];
    
    [self success:result callbackId:callbackId];
    
}


@end