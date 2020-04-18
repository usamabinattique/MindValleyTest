//
//  UITableView.swift
//  MindValleyTask
//
//  Created by usama on 11/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit


public protocol ReusableIdentifier { }

extension ReusableIdentifier {
    
    public static var id: String {
        return String(describing: self)
    }
}

public protocol Dequeueable: ReusableIdentifier {
    static func hasNib() -> Bool
}


public extension UITableView {

    func getCell<T: Dequeueable>(forType: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: T.id) as? T
    }

    func registerCell(withType cType: Dequeueable.Type) {
        registerCells(withTypes: [cType])
    }

    func registerCells(withTypes cType: [Dequeueable.Type]) {
        for ty in cType {
            if ty.hasNib() {
                register(UINib(nibName: ty.id, bundle: Bundle.main), forCellReuseIdentifier: ty.id)
            } else {
                if let t = ty as? AnyClass {
                    register(t, forCellReuseIdentifier: ty.id)
                }
            }
        }
    }
}
