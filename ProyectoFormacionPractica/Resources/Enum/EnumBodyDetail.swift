//
//  EnumBodyDetail.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 18/5/21.
//

import Foundation

enum BodyDetail {
    case text(String)
    case image(URL, String)
    case html(String)
    case titleImage(URL)
    case title(String)
    case dateTags(Date?, [String]?)
}
