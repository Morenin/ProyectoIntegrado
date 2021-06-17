//
//  CodableDetail.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 12/5/21.
//

import Foundation

struct Detail: Codable {
    let error: ErrorDetail
    let respuesta: RespuestaDetail
}


struct ErrorDetail: Codable {
    let codError, descripcion: String
}


struct RespuestaDetail: Codable {
    let date: String?
    let title: String
    let subtitle: String?
    let image: String
    let tags: [String]?
    let id: Int
    let body: [Body]
}


struct Body: Codable {
    let type: TypeDetail
    let text: String
    let image: String?
}
