//
//  MyBiometric.swift
//  rnappbiometric
//
//  Created by  on 25/02/23.
//

import Foundation
import LocalAuthentication

@objcMembers class MyBiometric: NSObject {
  
//  func authenticate() -> NSString {
//    let context = LAContext()
//    var error: NSError?
//    guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
//        return (error?.localizedDescription  ?? "Can't evaluate policy") as NSString
//    }
//    Task {
//        do {
//            try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Log in to your account")
//            return "true" as NSString
//        } catch let error {
//            return error.localizedDescription as NSString
//        }
//    }
//    return "error" as NSString
//  }
  
  func getAvailableBiometric() -> String {
    return getBiometrics()
  }
  
  private func getBiometrics() -> String {
    let authContext = LAContext()
    _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    switch authContext.biometryType {
    case .none:
      return "NoBiometricFound"
    case .touchID:
      return "FINGERPRINT"
    case .faceID:
      return "FACE"
    @unknown default:
      return "UnKnown Error"
    }
  }
  
  typealias CompletionHandler = (_ success:Bool) -> NSString
  
//  private func useLocalAuthentication(completionHandler: CompletionHandler) -> NSString {
//    debugPrint("1")
//    let context = LAContext()
//    var error: NSError?
//    debugPrint("2")
//    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//      let reason = NSLocalizedString("IdentifyYourself", comment: "IdentifyYourself")
//      debugPrint("3")
//      context.evaluatePolicy(
//        .deviceOwnerAuthenticationWithBiometrics,
//        localizedReason: reason
//      ) { [weak self] success, _ in
//        DispatchQueue.main.async {
//          debugPrint("4")
//          if success {
//             completionHandler(true)
//
//          } else {
//            completionHandler(false)
//          }
//          debugPrint("5")
//        }
//        debugPrint("6")
//      }
//    } else {
//      debugPrint("7")
//      completionHandler(false)
//    }
//  }
  
  
}


















































