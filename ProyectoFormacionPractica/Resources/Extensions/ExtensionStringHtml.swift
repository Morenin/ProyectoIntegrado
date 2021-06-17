//
//  ExtensionStringHtml.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 19/5/21.
//

import Foundation

extension String  {

    func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString? {
            do {
                let htmlCSSString = "<style>" +
                    "html *" +
                    "{" +
                    "font-size: \(size)pt !important;" +
                    "color: #\(color.hexString) !important;" +
                    "font-family: \(family ?? "OpenSans"), OpenSans !important;" +
                "}</style> \(self)"

                guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                    return nil
                }

                return try NSAttributedString(data: data,
                                              options: [.documentType: NSAttributedString.DocumentType.html,
                                                        .characterEncoding: String.Encoding.utf8.rawValue],
                                              documentAttributes: nil)
            } catch {
                print("error: ", error)
                return nil
            }
        }
}
