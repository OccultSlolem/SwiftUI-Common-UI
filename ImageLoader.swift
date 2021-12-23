//
//  ImageLoader.swift
//  Politifi
//
//  Created by Ethan Hanlon on 3/25/21.
//

import SwiftUI
import Foundation
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var url: URL
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    private(set) var isLoading = false
    private var cancellable: AnyCancellable?
    private var cache: ImageCache?
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        // Exit early if image loading is in progress
        guard !isLoading else { return }
        
        if let image = cache?[url] {
            self.image = image
            return
        }
        
        //
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: Self.imageProcessingQueue) // Add image to processing queue
            .map { UIImage(data: $0.data) } // Map remote image to UIImage
            .replaceError(with: nil)
            .handleEvents(
                receiveSubscription: { [weak self] _ in self?.onStart() },
                receiveOutput: { [weak self] in self?.cache($0) }, // Cache image
                receiveCompletion: { [weak self] _ in self?.onFinish() },
                receiveCancel: { [weak self] in self?.onFinish()}
            )
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func onStart() {
        isLoading = true
    }
    
    func onFinish() {
        isLoading = false
    }
    
    func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}

// MARK: - NSCache Abstraction
protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}

// MARK: - Add cache to environment
struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
