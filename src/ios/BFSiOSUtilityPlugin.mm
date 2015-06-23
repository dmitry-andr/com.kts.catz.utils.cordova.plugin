#import "BFSiOSUtilityPlugin.h"


@interface BFSiOSUtilityPlugin()
@end


@implementation BFSiOSUtilityPlugin



//This is to get Unity main view controller
UIViewController *UnityGetGLViewController();


- (NSString *)getPurchOperationStatus{
    return _purchOperationStatus;
}

    
- (NSString *) getTestMessage{
    return @"Plugin-Test msg from iOS plugin";
}

-(void) initializeUnityCallBackParams:(NSString *)callbackObjName andMethodName:(NSString *)callbackMethodName{
#if UNITY_MODE != 1
    //Unity code
    NSLog(@"!!!!!   UNITY_MODE preprocessor variable value is not 1   !!!!!");
    
#endif
    NSLog(@"Callback initialization, object : %@, method : %@", callbackObjName, callbackMethodName);
    _unityCallbackObjectName = callbackObjName;
    _unityCallbackMethodName = callbackMethodName;
}




/*
-(void) launchPurchaseController:(UIViewController *)parentController
{
    _purchaseController = [[BFSiOSPurchViewController alloc] init];
    _purchaseController.productID = _productId;
    _purchaseController.parentMainViewController = parentController;
    [[SKPaymentQueue defaultQueue] addTransactionObserver:_purchaseController];
    
    //_purchaseController.productID = @"level_2_access";
    
    [parentController presentViewController:_purchaseController animated:YES completion:nil];
    //[parentController presentModalViewController:_purchaseController animated:YES];
    
}
 */


/*
//this method to be used in for launching purchase process in standalone mode
- (int) purchaseProduct:(NSString *)productId
{
    _productId = productId;
    _purchaseController = [[BFSiOSPurchViewController alloc] init];
    _purchaseController.productID = _productId;
    _purchaseController.parentMainViewController = _parentController;
    [[SKPaymentQueue defaultQueue] addTransactionObserver:_purchaseController];
    
    [_parentController presentViewController:_purchaseController animated:YES completion:nil];
    
    return 1;
}
*/



//this method to be used in Unity for launching purchase process
- (int) purchaseProduct:(NSString *)productId withUnityCallbackObjectName:(NSString *)unityCallbackObjectName andUnityCallbackMethodName:(NSString *)unityCallbackMethodName andCallbackDelegate:(id<BFSiOSPurchViewControllerControllerDelegate>)delegate
{
    _productId = productId;
    _purchaseController = [[BFSiOSPurchViewController alloc] init];
    _purchaseController.productID = _productId;
    _purchaseController.parentMainViewController = _parentController;
    _purchaseController.delegate = delegate;
    _purchaseController.unityCallbkObjName = unityCallbackObjectName;
    _purchaseController.unityCallbkMethodName = unityCallbackMethodName;
    [[SKPaymentQueue defaultQueue] addTransactionObserver:_purchaseController];
    
    //Second option must me used when buildind for Unity, first - standalone iOS app
    
#if UNITY_MODE == 1
    //Unity code
    NSLog(@"Launching purchase screen using Unity View Controller");
    [UnityGetGLViewController() presentViewController:_purchaseController animated:YES completion:nil];
#else
    [_parentController presentViewController:_purchaseController animated:YES completion:nil];
#endif
    
    //[_parentController presentViewController:_purchaseController animated:YES completion:nil];
    //[UnityGetGLViewController() presentViewController:_purchaseController animated:YES completion:nil];
    
    return 1;
    
}




@end







BFSiOSUtilityPlugin* bfsPlugin = [BFSiOSUtilityPlugin alloc];

// Converts C style string to NSString
NSString* CreateNSStringUtil (const char* string)
{
    if (string)
        return [NSString stringWithUTF8String: string];
    else
        return [NSString stringWithUTF8String: ""];
}
// Helper method to create C string copy
char* MakeStringCopyUtil (const char* string)
{
    if (string == NULL)
        return NULL;
    
    char* res = (char*)malloc(strlen(string) + 1);
    strcpy(res, string);
    return res;
}

// When native code plugin is implemented in .mm / .cpp file, then functions
// should be surrounded with extern "C" block to conform C function naming rules
extern "C"{
    
    const char* _getTestMessage ()
    {
        // By default mono string marshaler creates .Net string for returned UTF-8 C string
        // and calls free for returned value, thus returned strings should be allocated on heap
        return MakeStringCopyUtil([[bfsPlugin getTestMessage] UTF8String]);
    }
    
    void _purchaseProduct(const char* productId, const char* unityCallbackObj, const char* unityCallbackMethod)
    {
        [bfsPlugin purchaseProduct: CreateNSStringUtil(productId) withUnityCallbackObjectName:CreateNSStringUtil(unityCallbackObj) andUnityCallbackMethodName:CreateNSStringUtil(unityCallbackMethod) andCallbackDelegate:NULL];
    }
    
    
    
    
}

