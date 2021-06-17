//
//  EnumNotification.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 20/5/21.
//

import Foundation

enum notification {
    case header(String?, [cellNotification])
}

struct cellNotification {
    let title: String
    let stateSwitch: Bool
    
    init(title: String, stateSwitch: Bool) {
        self.title = title
        self.stateSwitch = stateSwitch
    }
}
//User esta estructura y enumeracion 
//struct notification2 {
//    let title: String
//    let cells: [CellNotification2]
//}
//
//enum CellNotification2 {
//    case section(String, Bool)
//
//}
