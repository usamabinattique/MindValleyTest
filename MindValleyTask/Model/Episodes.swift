//
//  Episodes.swift
//  MindValleyTask
//
//  Created by usama on 11/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct EpisodesRoot: Codable {
    let data: Episodes
}

// MARK: - DataClass
struct Episodes: Codable {
    let media: [Media]
}

// MARK: - Media
struct Media: Codable {
    let type, title: String
    let coverAsset: CoverAsset
    let channel: EpisodeChannel
}

// MARK: - Channel
struct EpisodeChannel: Codable {
    let title: String
}

