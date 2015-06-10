#import "BFSiOSPurchViewController.h"


@interface BFSiOSPurchViewController ()

@end

@implementation BFSiOSPurchViewController

//this flag is initialized with value from BFSiOSUtilityPlugin class in viewDidLoad method

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor grayColor]]; [self.view setAlpha:0.5];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 64.0, 300.0, 24.0)];
    label.textColor = [UIColor whiteColor];
    label.text = @" Connecting iTunes...";
    [self.view addSubview:label];
      
    
    
    [self getProductInfo];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (void)getProductInfo{
    NSLog(@"getProductInfo method for ID : %@", _productID);
    if([SKPaymentQueue canMakePayments])
    {
        SKProductsRequest *request = [[SKProductsRequest alloc]
                                      initWithProductIdentifiers:[NSSet setWithObject: _productID]];
        request.delegate = self;
        
        [request start];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"In App Purchase disabled"
                                                        message:@"Please enable In App Purchase in Settings"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"SKP didReceiveResponse");
    
    NSArray *products = response.products;
    
    if(products.count != 0)
    {
        _product = products[0];
        NSLog(@"Product found : %@", _product);
        
        //Start purchase transaction
        SKPayment *payment = [SKPayment paymentWithProduct:_product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        
        
    }else{
        NSLog(@"Product not found");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Product not found"
                                                        message:@"Product not found"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    products = response.invalidProductIdentifiers;
    for(SKProduct *product in products)
    {
        NSLog(@"Product not found : %@", product);
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Code for OK button
    if (buttonIndex == 0)
    {
        [self closePurchaseView: [self buildMessageForUnity:@"Product not found(cancelling purchase)" andStatus:@"PRODUCT_NOT_FOUND"]];
        
    }
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for(SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"Transaction completed");
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                
                //Product was purchased - update UI accordingly
                [self closePurchaseView: [self buildMessageForUnity:@"Purchased product" andStatus:@"PRODUCT_PURCHASE_SUCCESS"]];
                
                break;
                
            case SKPaymentTransactionStateFailed:
                NSLog(@"Transaction failed");
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                
                [self closePurchaseView: [self buildMessageForUnity:@"Purchase cancelled" andStatus:@"PRODUCT_PURCHASE_CANCELLED"]];
                
                break;
            default:
                NSLog(@"Transaction status unknown");
                //[self closePurchaseView];
                
                break;
        }
    }
}

-(void)closePurchaseView:(NSString *) message
{
    NSLog(@"Closing purchase view with message: %@", message);
    
#if UNITY_MODE == 1
    //Unity code
    NSLog(@"Sending message to Unity %@->%@ with message: %@",_unityCallbkObjName, _unityCallbkMethodName, message);
    UnitySendMessage([_unityCallbkObjName UTF8String], [_unityCallbkMethodName UTF8String], [message UTF8String]);
#endif
    NSLog(@"Callback params for Unity %@->%@ with message: %@",_unityCallbkObjName, _unityCallbkMethodName, message);
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *) buildMessageForUnity:(NSString *) messageText andStatus:(NSString *) statusText
{
    NSString *rootTag = @"itunespurchaseresponse";
    NSString *productIdTag = @"productid";
    NSString *statusTag = @"status";
    NSString *messageTextTag = @"message";
    
    NSMutableString *msgForUnity = [NSMutableString stringWithString:@""];
    
    [msgForUnity appendString:@"<"];
    [msgForUnity appendString:rootTag];
    [msgForUnity appendString:@">"];
    
    [msgForUnity appendString:@"<"];
    [msgForUnity appendString:productIdTag];
    [msgForUnity appendString:@">"];
    [msgForUnity appendString:_productID];
    [msgForUnity appendString:@"</"];
    [msgForUnity appendString:productIdTag];
    [msgForUnity appendString:@">"];
    
    [msgForUnity appendString:@"<"];
    [msgForUnity appendString:statusTag];
    [msgForUnity appendString:@">"];
    [msgForUnity appendString:statusText];
    [msgForUnity appendString:@"</"];
    [msgForUnity appendString:statusTag];
    [msgForUnity appendString:@">"];
    
    [msgForUnity appendString:@"<"];
    [msgForUnity appendString:messageTextTag];
    [msgForUnity appendString:@">"];
    [msgForUnity appendString:messageText];
    [msgForUnity appendString:@"</"];
    [msgForUnity appendString:messageTextTag];
    [msgForUnity appendString:@">"];
    
    [msgForUnity appendString:@"</"];
    [msgForUnity appendString:rootTag];
    [msgForUnity appendString:@">"];
    
    return msgForUnity;
}



@end
