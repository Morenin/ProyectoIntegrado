//
//  CellListCollectionViewCell.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 7/5/21.
//

import UIKit

class CellListCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageCollection: UIImageView!
    @IBOutlet weak var labelTitleCollection: UILabel!
    @IBOutlet weak var labelDateCollection: UILabel!
    @IBOutlet weak var tagsCollection: UICollectionView!
    
    private var task: URLSessionTask?
    
    var tags: [String] = [] {
        didSet {
            tagsCollection.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionView()
        style()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCollection.image = nil
        task?.cancel()
        task = nil
    }
    
    func registerCollectionView() {
        self.tagsCollection.register(UINib(nibName: "CellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tagCell")
        self.tagsCollection.delegate = self
        self.tagsCollection.dataSource = self
        if let collectionViewLayout = tagsCollection.collectionViewLayout as? UICollectionViewFlowLayout {
                collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                collectionViewLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
}
extension CellListCollectionViewCell:  UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = tagsCollection.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as? CellCollectionViewCell {
            cell.labelCollection.text = tags[indexPath.row].capitalizingFirstLetter()
            cell.labelCollection.textColor = .blueSdos
            cell.viewCollection.backgroundColor = .blueSdos8
            return cell
        }
        fatalError("No hay tag")
    }
    
    func style() {
        labelTitleCollection.loadStyleLabelFontOpenSasNormalSmall()
        labelDateCollection.loadStyleLabelFontOpenSasSmall()
    }
    
    func setDate(new: News){
        let date = new.date
        labelDateCollection.text = changeDateFormat(date: date, format: "MMMM d").uppercased()
        labelTitleCollection.text = new.title
        //cell.imageCollection.downloaded(from: news[indexPath.section].image)
        task = imageCollection.loadImageUsingCache(withUrl: new.image)
        imageCollection.contentMode = .scaleToFill
        imageCollection.layer.masksToBounds = true
        tags = new.tags
    }
}

