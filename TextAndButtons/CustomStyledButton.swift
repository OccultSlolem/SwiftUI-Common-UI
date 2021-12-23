//
//  CustomStyledButton.swift
//  Politifi
//
//  Created by Ethan Hanlon on 12/29/20.
//

import SwiftUI

struct CustomStyledButton: View {
    var title: String
    var backgroundColor: Color? = Colors.buttonBackgroundColor
    var textColor: Color? = Colors.textForegroundColor
    var action: () -> Void
    
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(title)
                    .padding()
                    .accentColor(.white)
                    .font(.title2)
                    .foregroundColor(textColor)
                Spacer()
            }
        }
        .background(backgroundColor)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

struct CustomStyledButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CustomStyledButton(title: "String", backgroundColor: Color.black, action: { print(":)") })
                .previewLayout(.sizeThatFits)
            CustomStyledButton(title: "String", backgroundColor: Colors.buttonBackgroundColor, action: { print(":)") })
                .previewLayout(.sizeThatFits)
        }
    }
}
