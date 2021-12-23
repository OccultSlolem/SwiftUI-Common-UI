//
//  ListRow.swift
//  Politifi
//
//  Created by Ethan Hanlon on 3/27/21.
//  Row for a SwiftUI list.

import SwiftUI

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
