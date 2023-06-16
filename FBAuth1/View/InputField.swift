//
//  InputField.swift
//  firebaseAuthentication
//
//  Created by Chris on 6/15/23.
//

import Foundation
import SwiftUI

struct InputField: View {
    @Binding var text: String
    var num: String
    
    @FocusState var isEnabled: Bool
    var contentType: UITextContentType = .telephoneNumber
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            TextField(num, text: $text)
                .keyboardType(.numberPad)
                .textContentType(contentType)
                .focused($isEnabled)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.black.opacity(0.2))
                Rectangle()
                    .fill(.black)
                    .frame(width: isEnabled ? nil : 0, alignment: .leading)
                    .animation(.easeInOut(duration: 0.6), value: isEnabled)
            }
            .frame(height: 2)
        }
    }
}

struct InputField_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
