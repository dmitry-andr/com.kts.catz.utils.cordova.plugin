#import <UIKit/UIKit.h>
#import "BFSiOSPurchViewController.h"


@interface BFSiOSUtilityPlugin : NSObject




@property (strong, nonatomic) SKProduct *product;
@property (strong, nonatomic) NSString *productId;
@property (strong, nonatomic) NSString *purchOperationStatus;


@property (strong, nonatomic) BFSiOSPurchViewController *purchaseController;

@property(strong, nonatomic) UIViewController* parentController;


@property (strong, nonatomic) NSString *unityCallbackObjectName;
@property (strong, nonatomic) NSString *unityCallbackMethodName;


//- (int)purchaseProduct:(NSString *)productId;
- (int)purchaseProduct:(NSString *)productId withUnityCallbackObjectName:(NSString *) unityCallbackObjectName andUnityCallbackMethodName:(NSString *) unityCallbackMethodName andCallbackDelegate:(id<BFSiOSPurchViewControllerControllerDelegate>)delegate;
- (NSString *)getTestMessage;
- (NSString *)getPurchOperationStatus;
-(void) initializeUnityCallBackParams:(NSString *) callbackObjName andMethodName:(NSString *) callbackMethodName;
//-(void) launchPurchaseController:(UIViewController *) parentController;



@end
