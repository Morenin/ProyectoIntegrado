//
//  WebRequests.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 5/5/21.
//

import Foundation

class WireMockApi {
    
    static func apiRest<T: Codable>(url: String, success: @escaping (_ list: T) -> Void, failture: @escaping (_ error: Error? ) -> Void) {
        if let url = URL(string: url) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                guard let data = data, error == nil else {
                    print("Something went wrong")
                    failture(error)
                    return
                }
                var result: T?
                do{
                    result = try JSONDecoder().decode(T.self, from: data)
                } catch {
                    print("Failed to convert \(error.localizedDescription)")
                }
                guard let json = result else { return }
                success(json)
            })
            task.resume()
        }
    }
}



