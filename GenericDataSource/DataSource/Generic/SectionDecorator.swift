//
//  SectionDecorator.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 02/11/20.
//

import Foundation

public protocol SectionDecorator {
    
    associatedtype Item
    
    var items: [Item] { get set }
    
    /// returns number of items in section
    func numberOfItems() -> Int
    
    /// returns the item for given indexPath
    func itemAtIndexPath(_ indexPath: IndexPath) -> Item
}

public extension SectionDecorator {

    func numberOfItems() -> Int {
        return items.count
    }

    func itemAtIndexPath(_ indexPath: IndexPath) -> Item {
        return items[indexPath.row]
    }
}
