//
//  Categories.swift
//  MindValleyTask
//
//  Created by usama on 11/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct CategoriesRoot: Codable {
    let data: Categories
}

// MARK: - DataClass
struct Categories: Codable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable {
    let name: String
}
