//
//  CustomStyledText.swift
//  Politifi
//
//  Created by Ethan Hanlon on 1/17/21.
//
//  Almost exactly like CustomStyledTextButton, but without an action or gradient attached. Useful for NavigationLinks

import SwiftUI

struct CustomStyledText: View {
    var title: String
    var backgroundColor: Color? = Colors.buttonBackgroundColor
    var textColor: Color? = Colors.textForegroundColor

    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .padding()
                .accentColor(.white)
                .font(.title2)
                .foregroundColor(textColor)
            Spacer()
        }
        .background(backgroundColor)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

struct CustomStyledText_Previews: PreviewProvider {
    static var previews: some View {
        CustomStyledText(title: "String")
    }
}
