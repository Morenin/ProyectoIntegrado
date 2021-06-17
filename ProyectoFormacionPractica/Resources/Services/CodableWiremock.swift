//
//  CodableWiremock.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 11/5/21.
//

import Foundation


struct List: Codable {
    let error: ErrorJson
    let respuesta: Respuesta
}

struct ErrorJson: Codable {
    let codError, descripcion: String
}

struct Respuesta: Codable {
    let news: [News]
}

struct News: Codable {
    let date, title: String
    let image: String
    let tags: [String]
    let id: Int
    let subtitle: String?
}
