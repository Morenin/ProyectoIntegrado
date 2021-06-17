//
//  ChangeStringToDate.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 11/5/21.
//

import Foundation

func changeDateFormat(date: String, format: String) -> String {
    let locale = Locale(identifier: "es-ES")
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.locale = locale
    return dateFormatter.string(from: convertString(date: date))
}

func convertString(date: String) -> Date {
    let trimmedString = date.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
    let formatter = ISO8601DateFormatter()
    guard let date = formatter.date(from: trimmedString) else {
        return Date()
    }
    return date
}
