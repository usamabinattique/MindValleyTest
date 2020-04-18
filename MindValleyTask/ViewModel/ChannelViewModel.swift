//
//  ChannelViewModel.swift
//  MindValleyTask
//
//  Created by usama on 11/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import Foundation
import Promises

class ChannelViewModel: NSObject {
    
    private(set) var channels: [Channel] = []
    private(set) var categories: [Category] = []
    private(set) var episodes: [Episodes] = []
    
    private let dataModels: [API: Decodable.Type] = [.episodes: EpisodesRoot.self,
                                                     .channels: ChannelsRoot.self,
                                                     .categories: Categories.self ]
    
    
    func getData() {
        
//        var cases = API.allCases.makeIterator()
//
//        while let current = cases.next() {
//
//            APIClient.shared.request(endPoint: current, decode: dsf as! T.Type, error: DefaultError.self)
//
//
//
//        }
        
        let endPoint = API.episodes
        APIClient.shared.request(endPoint: endPoint, decode: EpisodesRoot.self, error: DefaultError.self)
            .then { (episodeRoot)  in
                self.episodes = episodeRoot.data.media
                NotificationCenter.default.post(name: .serviceResponse, object: endPoint)
                
        }.catch { (error) in
            //handle error, show alerts or display any sort of activity based on error
            
            print((error as? DefaultError)?.description)
        }
        
        getCategories()
    }
    
    
    private func getCategories() {
        let endPoint = API.categories
          APIClient.shared.request(endPoint: endPoint, decode: CategoriesRoot.self, error: DefaultError.self)
              .then { (categoriesRoot)  in
                self.categories = categoriesRoot.data.categories
                  NotificationCenter.default.post(name: .serviceResponse, object: endPoint)
                  
          }.catch { (_) in
              //handle error, show alerts or display any sort of activity based on error
          }
    }
}

extension ChannelViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return episodes.count > 0 ? 1 : 0
        case 1:
            return channels.count > 0 ? channels.count : 0
        case 2:
            return categories.count > 0 ? 1 : 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EpisodesTableViewCell.id, for: indexPath) as? EpisodesTableViewCell {
                cell.episodes = episodes
                return cell
            }
        case 1:
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: ChannelsTableViewCell.id, for: indexPath) as? ChannelsTableViewCell {
                
                
                return cell
            }
            
            
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.id, for: indexPath) as? CategoriesTableViewCell {
                cell.categories = categories
                return cell
            }
        }
        return UITableViewCell()
    }
}
