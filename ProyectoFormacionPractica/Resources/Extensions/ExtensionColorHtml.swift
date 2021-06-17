//
//  ExtensionColorHtml.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 19/5/21.
//

import Foundation

extension UIColor {
    var hexString: String {
        let components = cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)),
                               lroundf(Float(b * 255)))

        return hexString
    }
}
