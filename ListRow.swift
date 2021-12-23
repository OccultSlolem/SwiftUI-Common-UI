//
//  ListRow.swift
//  Politifi
//
//  Created by Ethan Hanlon on 3/27/21.
//  Row for a SwiftUI list.

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


struct ListRow: View {
    @State var text: String
    @State var sfSymbol: String
    @State var bgColor: Color
    
    var body: some View {
        HStack {
            ListIcon(sfSymbol: sfSymbol, bgColor: bgColor)
                .padding(.trailing)
            
            Text(text)
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ListRow(text: "Account Settings", sfSymbol: "gear", bgColor: Color(.sRGB, red: 0.8, green: 0.2, blue: 0.1, opacity: 1.0))
            
            ListRow(text: "Sign out", sfSymbol: "arrowshape.turn.up.left.fill", bgColor: Color(.sRGB, white: 0.25, opacity: 1.0))
            
        }
    }
}
