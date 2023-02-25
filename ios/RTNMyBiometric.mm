//
//  RTNMyBiometric.m
//  rnappbiometric
//
//  Created by TransformHub on 25/02/23.
//

#import <Foundation/Foundation.h>
#import "rnappbiometric-Swift.h"
#import "RTNMyBiometric.h"

@implementation RTNMyBiometric

RCT_EXPORT_MODULE()

MyBiometric *myBiometric = [[MyBiometric alloc] init];

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
(const facebook::react::ObjCTurboModule::InitParams &)params
{
  return std::make_shared<facebook::react::NativeMyBiometricSpecJSI>(params);
}

- (void)authenticate:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  LAContext *context = [[LAContext alloc] init];
  NSError *error = nil;
  if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
            localizedReason:@"Are you the device owner?"
                      reply:^(BOOL success, NSError *error) {
      dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {
          reject(@"Fail",@"There was a problem verifying your identity.",nil);
        }
        
        if (success) {
          resolve(@"true");
        } else {
          reject(@"Fail",@"You are not the device owner.",nil);
        }
      });
    }];
    
  } else {
    reject(@"Fail",@"Your device cannot authenticate",nil);
  }
  
}

- (void)getAvailableBiometric:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  NSString *value = [myBiometric getAvailableBiometric];
  if ([value isEqual: @"FINGERPRINT"] || [value isEqual: @"FACE"]){
    //    NSDictionary *dictRes = @{
    //      @"success": value,
    //    };
    resolve(value);
  }  else {
    reject(@"Fail",value,nil);
  }
}

@end
