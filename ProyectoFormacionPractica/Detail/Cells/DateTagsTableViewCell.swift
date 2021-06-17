//
//  DateTagsTableViewCell.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 18/5/21.
//

import UIKit

class DateTagsTableViewCell: UITableViewCell {

    @IBOutlet weak var iconClock: UIImageView!
    @IBOutlet weak var textDate: UILabel!
    @IBOutlet weak var collectionTags: UICollectionView!
    static let identifier: String = "dateTagsDetailCustomCell"
    
    var tags: [String] = [] {
        didSet {
            collectionTags.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionView()
        style()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func registerCollectionView() {
        self.collectionTags.register(UINib(nibName: "CellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tagCell")
        self.collectionTags.delegate = self
        self.collectionTags.dataSource = self
        if let collectionViewLayout = collectionTags.collectionViewLayout as? UICollectionViewFlowLayout {
                collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                collectionViewLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    func style() {
        textDate.loadStyleLabelFontOpenSasSmall()
        textDate.tintColor = .black60
    }
    
    func loadData(date: Date?, tags: [String]?){
        iconClock.image = UIImage(named: "clock")
        if let date = date {
            textDate.text = date.stringMMDD().uppercased()
        }
        if let tag = tags {
            self.tags = tag
        }
    }
}

extension DateTagsTableViewCell:  UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionTags.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as? CellCollectionViewCell {
            cell.labelCollection.text = tags[indexPath.row].capitalizingFirstLetter()
            cell.labelCollection.textColor = .blueSdos
            cell.viewCollection.backgroundColor = .blueSdos8
            return cell
        }
        fatalError("No hay tag")
    }
}
