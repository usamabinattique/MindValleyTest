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

    
}

// MARK: Network Calls

extension ChannelViewModel {
    func getData() {
        
        let endPoint = API.episodes
        APIClient.shared.request(endPoint: endPoint, decode: EpisodeData.self, error: DefaultError.self)
            .then { (episodeRoot)  in
                self.episodes = episodeRoot.media
                NotificationCenter.default.post(name: .dataResponse, object: endPoint)
                self.getChannels()

        }.catch { (error) in
            //handle error, show alerts or display any sort of activity based on error
            
            print((error as? DefaultError)!.description)
        }
    }
    
    private func getChannels() {
        let endPoint = API.channels
          APIClient.shared.request(endPoint: endPoint, decode: ChannelsData.self, error: DefaultError.self)
              .then { (channelsRoot)  in
                self.channels = channelsRoot.channels
                  NotificationCenter.default.post(name: .dataResponse, object: endPoint)
                  
          }.catch { (_) in
              //handle error, show alerts or display any sort of activity based on error
          }

    }
    
    private func getCategories() {
        let endPoint = API.categories
          APIClient.shared.request(endPoint: endPoint, decode: CategoriesData.self, error: DefaultError.self)
              .then { (categoriesRoot)  in
                self.categories = categoriesRoot.categories
                  NotificationCenter.default.post(name: .dataResponse, object: endPoint)
                  
          }.catch { (_) in
              //handle error, show alerts or display any sort of activity based on error
          }
    }
    

}

extension ChannelViewModel {

    func getDataFromLocalJsonFiles() {
        
        APIClient.shared.decodeLocalJsonFiles(localFileName: API.episodes.localFileName, model: EpisodeData.self) { (response, error) in
            if let episodes = response as? EpisodeData {
                self.episodes = episodes.media
                NotificationCenter.default.post(name: .dataResponse, object: API.episodes)
            }
        }
        
        APIClient.shared.decodeLocalJsonFiles(localFileName: API.channels.localFileName, model: ChannelsData.self) { (response, error) in
            if let channels = response as? ChannelsData {
                self.channels = channels.channels
                NotificationCenter.default.post(name: .dataResponse, object: API.channels)

            }
        }
        APIClient.shared.decodeLocalJsonFiles(localFileName: API.categories.localFileName, model: CategoriesData.self) { (response, error) in
            if let categories = response as? CategoriesData {
                self.categories = categories.categories
                NotificationCenter.default.post(name: .dataResponse, object: API.categories)
                
            }
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
                
                cell
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


