//
//  TitleTableViewCell.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 18/5/21.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    static let identifier: String = "titleDetailCustomCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func style() {
        titleLabel.loadStyleLabelFontOpenSasBoldBig()
    }
    
    func loadData(title: String) {
        titleLabel.text = title
    }
    
}
