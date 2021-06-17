//
//  CellNotificationTableViewCell.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 20/5/21.
//

import UIKit

class CellNotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    static let identifier: String = "cellNotification"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func style() {
        
    }
    
    func loadData(title: String, state: Bool) {
        notificationTitle.text = title
    }
    
}
