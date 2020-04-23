//
//  UIImageView.swift
//  MindValleyTask
//
//  Created by usama on 16/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    typealias ImageHandler = (UIImage?, Error?) -> Void
    
     func getImage(urlString: String?, completion: @escaping ImageHandler ) {
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        let cache = ImageCache.default
        let resource = ImageResource(downloadURL: url)
        
        if cache.isCached(forKey: urlString) {
            cache.retrieveImage(forKey: "cacheKey") { result in
                switch result {
                case .success(let value):
                    switch value {
                    case .none:
                        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
                            switch result {
                            case .success(let value):
                                print("Image: \(value.image). Got from: \(value.cacheType)")
                                completion(value.image, nil)
                            case .failure(let error):
                                print("Error: \(error)")
                            }
                        }
                    case .disk:
                        DispatchQueue.main.async { completion(value.image, nil) }
                    case .memory:
                        DispatchQueue.main.async { completion(value.image, nil) }
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        } else {
            KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
                switch result {
                case .success(let value):
                    print("Image: \(value.image). Got from: \(value.cacheType)")
                    completion(value.image, nil)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}




