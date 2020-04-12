//
//  Channels.swift
//  MindValleyTask
//
//  Created by usama on 11/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct ChannelsRoot: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let channels: [Channel]
}

// MARK: - Channel
struct Channel: Codable {
    let title: String?
    let series: [Series]?
    let mediaCount: Int
    let latestMedia: [LatestMedia]
    let id: String?
    let iconAsset: IconAsset?
    let coverAsset: CoverAsset
    let slug: String?
}


// MARK: - IconAsset
struct IconAsset: Codable {
    let thumbnailURL: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case thumbnailURL = "thumbnailUrl"
        case url
    }
}

// MARK: - LatestMedia
struct LatestMedia: Codable {
    let type: TypeEnum
    let title: String
    let coverAsset: CoverAsset
}

enum TypeEnum: String, Codable {
    case course = "course"
    case video = "video"
}

// MARK: - Series
struct Series: Codable {
    let title: String
    let coverAsset: CoverAsset
    let id: String?
}