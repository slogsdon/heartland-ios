
#import <XCTest/XCTest.h>
#import "HpsC2xDevice.h"
#import "HpsC2xCreditSaleBuilder.h"
#import "HpsCreditCard.h"
#import "HpsAddress.h"

@interface Hps_C2X_Device_Test : XCTestCase<HpsC2xDeviceDelegate,HpsC2xTransactionDelegate>
{
    XCTestExpectation *deviceConnectionExpectation;
    XCTestExpectation *transactionExpectation;
}
@property HpsC2xDevice *device;
@end


@implementation Hps_C2X_Device_Test

-(void)deviceSetUp
{
     HpsConnectionConfig *config = [[HpsConnectionConfig alloc] init];
     config.VersionNumber = @"3409";
     config.DeveloperID = @"002914";
     config.Username = @"701389328";
     config.Password = @"$Test1234";
     config.SiteID = @"142914";
     config.DeviceID = @"6399854";
     config.LicenseID = @"142827";
     self.device = [[HpsC2xDevice alloc]initWithConfig:config];
}

- (HpsCreditCard*) getCC
{
    HpsCreditCard *card = [[HpsCreditCard alloc] init];
    card.cardNumber = @"4242424242424242";
    card.expMonth = 12;
    card.expYear = 2025;
    card.cvv = @"123";
    return card;
}


- (HpsAddress*) getAddress
{
    HpsAddress *address = [[HpsAddress alloc] init];
    address.address = @"1 Heartland Way";
    address.zip = @"95124";
    return address;
}


-(void)test_initialize
{    
     deviceConnectionExpectation = [self expectationWithDescription:@"test_C2X_Initialize"];
     [self deviceSetUp];
    [self.device initialize];
     self.device.deviceDelegate = self;
    [self waitForExpectationsWithTimeout:60.0 handler:^(NSError *error) {
               if(error) XCTFail(@"Request Timed out");
                  }];
    XCTAssert(YES, @"Device Connected");
}

-(void)test_Creditsale
{
    deviceConnectionExpectation = [self expectationWithDescription:@"test_C2X_DeviceConnected"];
    [self deviceSetUp];
    [self.device initialize];
    self.device.deviceDelegate = self;
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
               if(error) XCTFail(@"Request Timed out");
        transactionExpectation = [self expectationWithDescription:@"test_C2X_CreditSale"];
        HpsC2xCreditSaleBuilder *builder = [[HpsC2xCreditSaleBuilder alloc]initWithDevice:self.device];
        builder.amount = [[NSDecimalNumber alloc]initWithDouble:11.00];
        builder.creditCard = [self getCC];
        self.device.transactionDelegate = self;
        [builder execute];
        [self waitForExpectationsWithTimeout:20.0 handler:^(NSError *error) {
                      if(error) XCTFail(@"Request Timed out");
            }];
                  }];
    XCTAssert(YES, @"Device Connected");
    
}


#pragma mark - Device Delegate methods
- (void)onConnected:(HpsTerminalInfo *)terminalInfo
{
    NSLog(@"Device Connected");
    [deviceConnectionExpectation fulfill];
    
}
- (void)onDisconnected
{
    NSLog(@"Device Disconnected");
}
//- (void)onError:(NSString*)deviceError
//{
//    NSLog(@"%@",deviceError);
//}
- (void)onTerminalInfoReceived:(HpsTerminalInfo *)terminalInfo
{
    
}
- (void)onBluetoothDeviceList:(NSMutableArray *)peripherals
{
    for (int i =0; i<self.device.peripherals.count; i++) {
        CBPeripheral *peripheral = [self.device.peripherals objectAtIndex:i];
        if ([peripheral.name hasPrefix:@"CHB"]) {
            [self.device stopScan];
            [self.device connectDevice:peripheral];
        }
    }
}


#pragma mark - Transaction Delegate methods
- (void)onStatusUpdate:(HpsC2xTransactionStatus)transactionStatus
{
    
}
- (void)onCardholderInteractionRequested:(HpsCardholderInteractionRequest *)request
{
    
}
- (void)onTransactionComplete:(HpsTerminalResponse *)response
{
    NSLog(@"Transaction completed");
    XCTAssertNotNil(response,@"Terminal response is nil");
    [transactionExpectation fulfill];
    
}
- (void)onError:(NSError *)emvError
{
    NSLog(@"%@",emvError);
}

@end
