//
//  CustomStyledGradientButton.swift
//  Politifi
//
//  Created by Ethan Hanlon on 12/30/20.
//

import SwiftUI

struct CustomStyledGradientButton: View {
    var title: String
    var gradient: LinearGradient
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(title)
                    .font(.title2)
                    .padding()
                    .accentColor(.white)
                Spacer()
            }
        }
        .background(gradient)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

struct CustomStyledGradientButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomStyledGradientButton(
            title: "String",
            gradient: LinearGradient(gradient: Gradient(colors:[Color.pink, Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing),
            action: {
                print("Hello")
            }
        )
        .previewLayout(.sizeThatFits)
    }
}
