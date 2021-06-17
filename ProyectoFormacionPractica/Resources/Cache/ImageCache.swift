//
//  ImageCache.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 11/5/21.
//

import Foundation

class ImageCache {
    static let shared: ImageCache = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
    }
    
    func getImageCache(urlString: String) -> UIImage?{
         return cache.object(forKey: urlString as NSString)  
    }
    
    func setImageCache(urlString: String, image: UIImage){
        cache.setObject(image, forKey: urlString as NSString)
    }
}
