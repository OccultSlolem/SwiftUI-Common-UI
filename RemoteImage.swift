//
//  RemoteImage.swift
//  Politifi
//
//  Created by Ethan Hanlon on 1/18/21.
//  Shows an image from URL. Do not allow users to insert their own URLs, as this is a potential security risk.
//  Only use in rare cases where you don't want any caching. TODO: Elaborate

import SwiftUI

struct RemoteImage: View {
    let resizable: Bool
    
    var body: some View {
        if resizable {
            selectImage()
                .resizable()
        } else {
            selectImage()
        }
    }
    
    private enum loadState {
        case loading, success, failure
    }
    
    private class Loader: ObservableObject {
        var data = Data()
        var state = loadState.loading
        
        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                print("Failed to grab image at: \(url)")
                return
            }
            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }
                
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }
    
    @ObservedObject private var loader: Loader
    var loading: Image
    var failure: Image
    
    init(url: String, loading: Image = Image(systemName: "person.circle.fill"), resizable: Bool = true, failure: Image = Image(systemName: "multiply.circle")) {
        _loader = ObservedObject(wrappedValue: Loader(url: url))
        self.resizable = resizable
        self.loading = loading
        self.failure = failure
    }
    
    private func selectImage() -> Image {
        switch loader.state {
        case.loading:
            return loading
        case.failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            //Turn on live preview to see the image load
//            RemoteImage(url: "https://i.pinimg.com/originals/8e/06/5c/8e065c7a30d4724aeed6e5f9484b54ad.jpg")
//                .previewLayout(.sizeThatFits)
//            RemoteImage(url: "http://invalid")
//                .previewLayout(.sizeThatFits)
        }
    }
}
