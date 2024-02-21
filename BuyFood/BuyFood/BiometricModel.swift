//
//  BiometricModel.swift
//  Lab10_BiometricAuthen
//
//  Created by KA YING CHU on 5/12/2023.
//

import Foundation
import LocalAuthentication
class BiometricModel : ObservableObject {
    
    let context = LAContext()
    
    @Published var isError = false
    @Published var errorMessage = ""
    @Published var isAuthenicated = false
        
    func checkPolicy() {
        var error : NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,                                      error: &error) {
        self.isError = false
                } else {
        if let err = error {
        self.isError = true
        switch err.code {
        case LAError.Code.biometryNotEnrolled.rawValue:
        self.errorMessage = "not enrolled"
        case LAError.Code.passcodeNotSet.rawValue:
        self.errorMessage = "passcode not set"
        case LAError.Code.biometryNotAvailable.rawValue:
        self.errorMessage = "not available"
        default:
        self.errorMessage = "Unknown Error"
                        }
                    }
                }
    }
    func evaluatePolicy() {
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
        localizedReason: "Authentication is required", reply: {
            success, error in
            DispatchQueue.main.async {
        if let error = error {
            self.isError = true
            self.errorMessage = "Cannot login"
        } else {
            self.isError = false
            self.isAuthenicated = true
        }
    }
    })
    }
    

}
 
