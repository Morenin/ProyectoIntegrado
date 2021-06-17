//
//  NotificationsViewController.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 20/5/21.
//
//Falta la informacion de NSUserdefault

import UIKit

class NotificationsViewController: UIViewController {

    @IBOutlet weak var tableNotification: UITableView!
    
//    var array = [["", "Notification 1"],
//    ["Section name", "Notification 2", "Notification 3", "Notification 4"],
//    ["Section name", "Notification 5"]]
    var sections = [notification]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        sectionFill()
    }

    func registerCell(){
        tableNotification.register(UINib(nibName: "CellNotificationTableViewCell", bundle: nil), forCellReuseIdentifier: CellNotificationTableViewCell.identifier)
        tableNotification.delegate = self
        tableNotification.dataSource = self
    }
    
    func sectionFill() {
        sections.append(.header(nil, [cellNotification(title: "Notification 1", stateSwitch: true)]))
        sections.append(.header("Section name", [cellNotification(title: "Notification 2", stateSwitch: true), cellNotification(title: "Notification 3", stateSwitch: true), cellNotification(title: "Notification 4", stateSwitch: true)]))
        sections.append(.header("Section name", [cellNotification(title: "Notification 3", stateSwitch: true)]))
    }
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section]{
        case .header(_, let cellNotification):
            return cellNotification.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .header(_, let cellNotification):
            if let cell = tableNotification.dequeueReusableCell(withIdentifier: CellNotificationTableViewCell.identifier, for: indexPath) as? CellNotificationTableViewCell {
                cell.loadData(title: cellNotification[indexPath.row].title, state: cellNotification[indexPath.row].stateSwitch)
                return cell
            }
        }
        fatalError()
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section]{
        case .header(let title, _):
        if let title = title {
            return title
            }
            return ""
        }
    }
}

