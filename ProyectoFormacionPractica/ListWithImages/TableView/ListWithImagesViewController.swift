//
//  ListWithImagesViewController.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 4/5/21.
//

import UIKit

class ListWithImagesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var news: [News] = []
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPi()
        registerTableView()
        style()
    }
    
    func registerTableView(){
        tableView.register(UINib(nibName: "CellListTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func callAPi(){
        WireMockApi.apiRest(url: Url.new , success: {
            (json: List) in self.news = json.respuesta.news
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            //print(json)
        }, failture: {_ in self.alertError()})
    }

    func alertError() {
        let alert = UIAlertController.alertBasic(title: "Error", message: "No se ha podido conectar con el servidor")
        let action = UIAlertAction.actionCancel()
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func style() {
        self.navigationController?.navigationBar.loadStyleNavigationBarForgotPassword()
        self.navigationItem.title = "Lista con imágenes"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.loadstyleIconSearchRight()
    }
    
    func comment() {
        let alert = UIAlertController(title: "Añadir comentario", message: nil, preferredStyle: .alert)
        alert.addTextField{ (textField: UITextField) in textField.placeholder = "Escribe tu comentario"
        }
        let send = UIAlertAction(title: "Enviar", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        alert.addAction(send)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ListWithImagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CellListTableViewCell {
            let new = news[indexPath.section]
            cell.setDate(new: new)
            id = news[indexPath.section].id
            return cell
        }
       fatalError("No hay celdas")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.whiteThree
        return header
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        id = news[indexPath.section].id
        let detailTable = DetailViewController(id: id)
        navigationController?.pushViewController(detailTable, animated: true)
    }

//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let icon = UIImage(named: "fav")
//        let favorite = UIContextualAction(style: .destructive, title: "Añadir a favorito", handler: {_,_,_ in
//                                            icon?.withTintColor(.yellow)})
//        favorite.image = icon?.withTintColor(.yellow)
//        favorite.backgroundColor = .blueSdos8
//        let configuration = UISwipeActionsConfiguration(actions: [favorite])
//        return configuration
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let comment = UIContextualAction(style: .destructive, title: "Añadir comentario", handler: {_,_,_ in
                                            self.comment()})
        comment.image = UIImage(named: "com")
        comment.backgroundColor = .blueSdos8
        let configuration = UISwipeActionsConfiguration(actions: [comment])
        return configuration
    }
    
    
}



