//
//  UIImageDowloadExtension.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 7/5/21.
//

import Foundation

extension UIImageView {
    func downloaded(from link: String, contenteMode mode: ContentMode = .scaleToFill){
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mineType = response?.mimeType, mineType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() {[weak self] in
                self?.image = image
            }
        }.resume()
    }
    

    func loadImageUsingCache(withUrl urlString : String) -> URLSessionDataTask? {
        let imageCache = ImageCache.shared
        let url = URL(string: urlString)
        if url == nil { return nil }
        self.image = nil
        if let image = imageCache.getImageCache(urlString: urlString){
            self.image = image
            return nil
        }
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        if let url = url {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if  let error = error {
                    print(error)
                    return
                }
                DispatchQueue.main.async {
                    if let data = data, let image = UIImage(data: data) {
                        imageCache.setImageCache(urlString: urlString, image: image)
                        self.image = image
                        activityIndicator.removeFromSuperview()
                    }
                }
            })
            task.resume()
            return task
        } else {
            return nil
        }
    }
}
