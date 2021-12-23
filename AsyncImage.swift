//
//  AsyncImage.swift
//  Politifi
//
//  Created by Ethan Hanlon on 3/25/21.
//
//  Represents an image loaded from the internet. Arguments are as follows:
//  url: A URL. This should point to the location of the image.
//  placeholder: A view that is shown while the image is loading. Make sure to wrap it in an AnyView

import SwiftUI
import Combine
import Foundation

struct AsyncImage: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: AnyView
    private let image: (UIImage) -> Image
    
    init(
        url: URL,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:),
        placeholder: AnyView
         ) {
        self.placeholder = placeholder
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url,  cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                placeholder
            }
        }
    }
}

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage(url: URL(string: "https://i.imgur.com/WvXCMso.png")!, placeholder: AnyView(Text("Loading...")))
            .aspectRatio(contentMode: .fit)
    }
}
