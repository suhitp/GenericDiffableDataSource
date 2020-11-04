//
//  SectionnViewModel.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 02/11/20.
//

import UIKit
import DifferenceKit


//struct MultiSectionViewModel: SectionDecorator {
//
//    typealias Item = CellSection
//
//    public var items: [CellSection]
//
//    public init(items: [CellSection]) {
//        self.items = items
//    }
//
//    public func numberOfItems() -> Int {
//        var count = 0
//        items.forEach { (cell: CellSection) in
//            switch cell {
//            case .carousel(let elements):
//                count += elements.count
//            case .ads(let elements):
//                count += elements.count
//            case .playlist(let elements):
//                count += elements.count
//            }
//        }
//        return count
//    }
//
//    func itemAtIndexPath(_ indexPath: IndexPath) -> CellSection {
//        return items[indexPath.section]
//    }
//}
