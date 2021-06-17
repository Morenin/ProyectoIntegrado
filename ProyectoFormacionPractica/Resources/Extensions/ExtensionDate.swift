//
//  ExtensionDate.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 18/5/21.
//

import Foundation

extension Date {
    func stringMMDD() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        return dateFormatter.string(from: self)
    }
}
