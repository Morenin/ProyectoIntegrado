//
//  HtmlTableViewCell.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 12/5/21.
//

import UIKit

class HtmlTableViewCell: UITableViewCell {
    
    @IBOutlet weak var htmlText: UITextView!
    static let identifier: String = "htmlDetailCustomCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func loadData(text: String){
        htmlText.attributedText = text.htmlAttributed(family: "OpenSans-Regular", size: 12, color: .black60)
    }

}

