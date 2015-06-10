#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>


@interface BFSiOSPurchViewController : UIViewController<UIAlertViewDelegate,SKPaymentTransactionObserver, SKProductsRequestDelegate>


@property(strong, nonatomic) UIViewController* parentMainViewController;

@property (strong, nonatomic) SKProduct *product;
@property (strong, nonatomic) NSString *productID;


//need to duplicate these properties from BFSPlugin class as Unity loses references to static variables
@property (strong, nonatomic) NSString *unityCallbkObjName;
@property (strong, nonatomic) NSString *unityCallbkMethodName;


@end
