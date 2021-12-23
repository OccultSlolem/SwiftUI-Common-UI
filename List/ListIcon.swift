//
//  ListIcon.swift
//  Politifi
//
//  Created by Ethan Hanlon on 3/27/21.
//  Icon for a SwiftUI list. Takes an SF Symbol and background color as inputs

import SwiftUI

struct ListIcon: View {
    @State var sfSymbol: String
    @State var bgColor: Color
    
    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 6.0)
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor(bgColor)
            )
    }
}

struct ListIcon_Previews: PreviewProvider {
    static var previews: some View {
        ListIcon(sfSymbol: "gear", bgColor: Color(.sRGB, red: 0.8, green: 0.2, blue: 0.1, opacity: 1.0))
            .previewLayout(.fixed(width: 40, height: 40))
    }
}
