//
//  TextTableViewCell.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 12/5/21.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var titleTextLabel: UILabel!
    static let identifier: String = "textDetailCustomCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadData(text: String){
        titleTextLabel.text = text
        
    }
    
    func style() {
        titleTextLabel.loadStyleLabelFontOpenSasNormalSmall()
        titleTextLabel.textColor = .black90
    }
    
}
