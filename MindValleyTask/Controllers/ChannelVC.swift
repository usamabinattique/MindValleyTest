//
//  ChannelVC.swift
//  MindValleyTask
//
//  Created by usama on 11/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

class ChannelVC: UITableViewController {
    
    var channelViewModel: ChannelViewModel!
    private var notificationArray: [NSObjectProtocol] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        channelViewModel = ChannelViewModel()
        initUI()
        tableViewConfiguration()
        channelViewModel.getDataFromLocalJsonFiles()
    }
    
     override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        var notifIterator = notificationArray.makeIterator()
        while let current = notifIterator.next() {
            NotificationCenter.default.removeObserver(current)
        }
    }
    
    func initUI() {
        view.layer.backgroundColor = UIColor(red: 0.137, green: 0.153, blue: 0.184, alpha: 1).cgColor
        navigationController?.navigationBar.tintColor = UIColor(red: 0.137, green: 0.153, blue: 0.184, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.barTintColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        title = "Channels"
    }
    
    func tableViewConfiguration() {
        tableView.backgroundColor = UIColor(red: 0.137, green: 0.153, blue: 0.184, alpha: 1)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.dataSource = channelViewModel
        tableView.delegate = self
        tableView.registerCell(withType: EpisodesTableViewCell.self)
        tableView.registerCell(withType: ChannelsTableViewCell.self)
        tableView.registerCell(withType: CategoriesTableViewCell.self)
    }
}

extension ChannelVC {
    
    func observeUpdatesOfData() {
        
        let notif = NotificationCenter.default.addObserver(forName: .dataResponse, object: nil, queue: .main) { [weak self] notification in
            
            guard let self = self, let currentSection = notification.object as? API else { return }
            
            self.tableView.beginUpdates()
            self.tableView.reloadSections([currentSection.sequence], with: .automatic)
            self.tableView.endUpdates()
        }
        notificationArray.append(notif)
    }
}
