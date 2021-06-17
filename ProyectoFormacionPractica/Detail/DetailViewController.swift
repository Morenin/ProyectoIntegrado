//
//  DetailViewController.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 12/5/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var constraintView: NSLayoutConstraint!
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var buttonShare: UIButton!
    @IBOutlet weak var buttonBack: UIButton!
    
    private var response: RespuestaDetail?
    private var body: [BodyDetail] = []
    private var id: Int
    
    init( id: Int) {
        self.id = id
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no ha sido implementado")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callApi()
        registerCell()
        style()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let navigation = self.navigationController?.navigationBar.frame.size.height {
            constraintView.constant = navigation + self.view.safeAreaInsets.top
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func actionButtonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func registerCell(){
        detailTableView.register(UINib(nibName: "ImageTitleTableViewCell", bundle: nil), forCellReuseIdentifier: ImageTitleTableViewCell.identifier)
        detailTableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCell.identifier)
        detailTableView.register(UINib(nibName: "DateTagsTableViewCell", bundle: nil), forCellReuseIdentifier: DateTagsTableViewCell.identifier)
        detailTableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: ImageTableViewCell.identifier)
        detailTableView.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: TextTableViewCell.identifier)
        detailTableView.register(UINib(nibName: "HtmlTableViewCell", bundle: nil), forCellReuseIdentifier: HtmlTableViewCell.identifier)
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }

    func callApi(){
        WireMockApi.apiRest(url: Url.detail + "\(id)", success: {
            [weak self] (json: Detail) in guard let self = self else { return }
            DispatchQueue.main.async {
                self.successJson(notice: json.respuesta)
            }
        }, failture: {_ in self.alertError()})
    }
    
    func alertError() {
        let alert = UIAlertController.alertBasic(title: "Error", message: "No se ha podido conectar con el servidor")
        let action = UIAlertAction.actionCancel()
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func successJson(notice: RespuestaDetail){
        if let urlImage = URL(string: notice.image) {
            self.body.append(.titleImage(urlImage))
        }
        self.body.append(.title(notice.title))
        if let subtitle = notice.subtitle {
            self.body.append(.text(subtitle))
        }
        if let date = notice.date{
            if  notice.tags != nil {
                self.body.append(.dateTags(date.date , notice.tags))
            }
        }
        for cell in notice.body {
            switch cell.type {
            case .text:
                self.body.append(.text(cell.text))
            case .html:
                self.body.append(.html(cell.text))
            case .image:
                if let image = cell.image {
                    if let urlImageBody = URL(string: image) {
                        self.body.append(.image(urlImageBody, cell.text))
                    }
                }
            }
        }
        detailTableView.reloadData()
    }
    
    func style() {
        viewNavigation.backgroundColor = .black40
        self.detailTableView.separatorColor = .clear
        detailTableView.contentInsetAdjustmentBehavior = .never
        buttonShare.setTitle("COMPARTIR", for: .normal) 
        buttonShare.titleLabel?.loadStyleLabelFontOpenSasSmall()
        buttonShare.titleLabel?.tintColor = .white
        let back = UIImage(named: "back")
        back?.withTintColor(.white)
        buttonBack.setImage(back, for: .normal)
        buttonBack.tintColor = .white
        buttonBack.setTitle("", for: .normal)
    }
    
    @IBAction func buttonSharedAction(_ sender: Any) {
        let item = ["Compartir Noticia"]
        let ac = UIActivityViewController(activityItems: item, applicationActivities: nil)
        present(ac, animated: true)
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return body.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch body[indexPath.row] {
        case .titleImage(let image):
            let newCell: ImageTitleTableViewCell = getCell(identifier: ImageTitleTableViewCell.identifier, indexPath: indexPath)
            newCell.loadData(image: image)
            return newCell
        case .title(let title):
            let newCell : TitleTableViewCell = getCell(identifier: TitleTableViewCell.identifier, indexPath: indexPath)
            newCell.loadData(title: title)
            return newCell
        case .dateTags(let date, let tags):
            let newCell: DateTagsTableViewCell = getCell(identifier: DateTagsTableViewCell.identifier, indexPath: indexPath)
            newCell.loadData(date: date, tags: tags)
            return newCell
        case .image(let image, let text):
            let newCell: ImageTableViewCell = getCell(identifier: ImageTableViewCell.identifier , indexPath: indexPath)
            newCell.loadData(image: image, text: text)
            return newCell
        case .text(let text):
            let newCell: TextTableViewCell = getCell(identifier: TextTableViewCell.identifier, indexPath: indexPath)
            newCell.loadData(text: text)
            return newCell
        case .html(let html):
            let newCell: HtmlTableViewCell = getCell(identifier: HtmlTableViewCell.identifier, indexPath: indexPath)
            newCell.loadData(text: html)
            return newCell
        }
    }
    
    func getCell<T: UITableViewCell> (identifier: String, indexPath: IndexPath)  -> T {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: identifier, for : indexPath) as? T
        guard let newCell = cell else {return UITableViewCell() as! T}
        return newCell
    }
    
}


