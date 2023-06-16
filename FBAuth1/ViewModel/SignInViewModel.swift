//
//  SignInViewModel.swift
//  firebaseAuthentication
//
//  Created by Chris on 6/15/23.
//

import Foundation
import SwiftUI
import Firebase


class SignInViewModel: ObservableObject {
    @Published var cellPhoneNumber: String = ""
    @Published var confirmationCode: String = ""
    @Published var CLIENT_CODE: String = ""
    @Published var displayConfirmation: Bool = false
    @Published var displayError: Bool = false
    @Published var errorMsg: String = ""
    
    func sendConfirmationCode() {
        UIApplication.shared.shutKeys()
        Task {
            do {
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                let code = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(cellPhoneNumber)", uiDelegate: nil)
                await MainActor.run(body: {
                    CLIENT_CODE = code
                    withAnimation(.easeInOut) {
                        displayConfirmation = true
                    }
                })
            } catch {
               await errorThrow(error: error)
            }
        }
    }
    
    func verifyConfirmationCode() {
        UIApplication.shared.shutKeys()
        Task {
            do {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: CLIENT_CODE, verificationCode: confirmationCode)
                
                try await Auth.auth().signIn(with: credential)
                print("Signed In")
            } catch {
                await errorThrow(error: error)
            }
        }
    }
    
    func errorThrow(error: Error)async {
        await MainActor.run(body: {
            errorMsg = error.localizedDescription
            displayError.toggle()
        } )
    }
}

extension UIApplication {
    func shutKeys() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
