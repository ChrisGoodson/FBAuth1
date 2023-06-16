//
//  SignIn.swift
//  firebaseAuthentication
//
//  Created by Chris on 6/15/23.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignIn: View {
    @StateObject var signInViewModel: SignInViewModel = .init()
    var body: some View {
        if signInViewModel.isSignedIn {
            VStack {
                Spacer()
                Text("Sign in Successful!")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                Spacer()
            }
        } else {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    Spacer()
                    (Text("Hello World")
                        .foregroundColor(.black)
                    )
                    .font(.title)
                    .lineSpacing(5)
                    .padding(.top, 20)
                    .padding(.trailing, 30)
                    
                    InputField(text: $signInViewModel.cellPhoneNumber, num: "Enter a phone number(12282575217)")
                        .disabled(signInViewModel.displayConfirmation)
                        .padding(.top, 50)
                    InputField(text: $signInViewModel.confirmationCode, num: "Enter confirmation code(111111)")
                        .disabled(!signInViewModel.displayConfirmation)
                        .padding(.top, 15)
                    
                    Button(action: signInViewModel.displayConfirmation ? signInViewModel.verifyConfirmationCode : signInViewModel.sendConfirmationCode){
                        HStack(spacing: 15) {
                            Text(signInViewModel.displayConfirmation ? "Verify Code" : "Send Code")
                                .contentTransition(.identity)
                        }
                        .foregroundColor(.blue)
                        .padding(.vertical)
                    }
                    .padding(.top, 5)
                }
                .padding(.leading, 69)
                .padding(.vertical, 17)
            }
            .alert(signInViewModel.errorMsg, isPresented: $signInViewModel.displayError) {
            }
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
