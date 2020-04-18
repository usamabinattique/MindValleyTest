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
        tableViewConfiguration()
        channelViewModel.getData()
    }
    
     override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        var notifIterator = notificationArray.makeIterator()
        while let current = notifIterator.next() {
            NotificationCenter.default.removeObserver(current)
        }
    }
    
    func tableViewConfiguration() {
        tableView.dataSource = channelViewModel
        tableView.registerCell(withType: EpisodesTableViewCell.self)
        tableView.registerCell(withType: ChannelsTableViewCell.self)
        tableView.registerCell(withType: CategoriesTableViewCell.self)
    }
}

extension ChannelVC {
    
    func observeUpdatesOfData() {
        
        let notif = NotificationCenter.default.addObserver(forName: .serviceResponse, object: nil, queue: .main) { [weak self] notification in
            
            guard let self = self, let currentSection = notification.object as? API else { return }
            
            self.tableView.beginUpdates()
            self.tableView.reloadSections([currentSection.sequence], with: .automatic)
            self.tableView.endUpdates()
        }
        notificationArray.append(notif)
    }
}
