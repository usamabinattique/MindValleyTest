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
    
    func getEpisodesData() -> Promise<[Episodes]> {
        
        return Promise<[Episodes]>.init(on: .defaultBackgroundQueue) { fulfil, reject in
            
            let endPoint = API.episodes
             APIClient.shared.request(endPoint: endPoint, decode: EpisodeData.self, error: DefaultError.self)
                 .then { (episodeRoot)  in
                     self.episodes = episodeRoot.media
                     NotificationCenter.default.post(name: .dataResponse, object: endPoint)

                    self.getChannels()
                        .then { (channels) in
                            // here we have the channels data set, we can mainpulate it as per our requirements.
                            
                    }
                    
                    // this is a callback, updates the caller with the promise value of episodes

                    // this will be executed when all service calls have been made because if either of them fails because of some reason, then it will go to the reject block of the respective function, where we can update UI or do operations as per the requirement.
                    fulfil(episodeRoot.media)
                    
             }.catch { (error) in
                 //handle error, show alerts or display any sort of activity based on error
                    reject(error)
            }
        }
    }
    
    func getChannels() -> Promise<[Channel]> {
        
        return Promise<[Channel]>(on: .defaultBackgroundQueue) { fulfil, reject in
            
            let endPoint = API.channels
            APIClient.shared.request(endPoint: endPoint, decode: ChannelsData.self, error: DefaultError.self)
                .then { (channelsRoot)  in
                    self.channels = channelsRoot.channels
                    NotificationCenter.default.post(name: .dataResponse, object: endPoint)
                    self.getCategories()
                        .then { (categories) in
                        // at this point we can update our main view controller that all data has been fetched, to provide a finer UI experience i am updating the main view controller as soon as i get the result from one service but if they are interlocked and one of them depends on the previous for some reason then this pipelining is really helpful.
                    }
                    
                    // this is a callback, updates the caller with the promise value of channels
                    fulfil(channelsRoot.channels)
                    
            }.catch { (error) in
                //handle error, show alerts or display any sort of activity based on error
                reject(error)
            }
        }
    }
    
    func getCategories()  -> Promise<[Category]> {
        
        return Promise<[Category]>(on: .defaultBackgroundQueue) { fulfil, reject in
            let endPoint = API.categories
            APIClient.shared.request(endPoint: endPoint, decode: CategoriesData.self, error: DefaultError.self)
                .then { (categoriesRoot)  in
                    self.categories = categoriesRoot.categories
                    NotificationCenter.default.post(name: .dataResponse, object: endPoint)
                    // this is a callback, updates the caller with the promise value of categories
                    fulfil(self.categories)
                    
            }.catch { (error) in
                //handle error, show alerts or display any sort of activity based on error
                reject(error)
            }
        }
    }
}

// MARK: Retrieving Local Data

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
//                updateChannelContents()
                
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

private extension ChannelViewModel {
    
    func convertChannelCourseContentToRepresentable(latestMedia: LatestMedia) -> ChannelRepresentable {
        ChannelRepresentable(title: latestMedia.title, imageUrl: latestMedia.coverAsset.url)
    }
    
    func convertChannelSeriesContentToRepresentable(series: Series) -> ChannelRepresentable {
        ChannelRepresentable(title: series.title, imageUrl: series.coverAsset.url)
    }

}

// MARK: UI TableView Data Source

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
                
                cell.channel = channels[indexPath.row]
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


