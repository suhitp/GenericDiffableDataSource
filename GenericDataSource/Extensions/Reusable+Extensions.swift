//
//  Reusable+Extensions.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 02/11/20.
//

import UIKit

public extension UITableView {
    
    //MARK: UITableViewCell
    final func register<T: UITableViewCell>(_ cellType: T.Type) where T: Reusable {
        self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func register<T: UITableViewCell>(_ cellType: T.Type) where T: NibReusable {
        self.register(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(T.reuseIdentifier) matching type \(T.self).")
        }
        return cell
    }
    
    //MARK: UITableViewHeaderFooterView
    final func register<T: UITableViewHeaderFooterView>(_ headerFooterViewType: T.Type) where T: NibReusable {
        self.register(headerFooterViewType.nib, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }
    
    final func register<T: UITableViewHeaderFooterView>(_ headerFooterViewType: T.Type) where T: Reusable {
        self.register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }
    
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ cellType: T.Type = T.self) -> T where T: Reusable {
        guard let headerFooterView = self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Failed to dequeue a headerFooterView with identifier \(T.reuseIdentifier) matching type \(T.self).")
        }
        return headerFooterView
    }
}


public extension UICollectionView {
    
    //MARK: UICollectionViewCell
    final func register<T: UICollectionViewCell>(_ cellType: T.Type) where T: Reusable {
        self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func register<T: UICollectionViewCell>(_ cellType: T.Type) where T: NibReusable {
        self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(T.reuseIdentifier) matching type \(T.self).")
        }
        return cell
    }
    
    
    //MARK: UICollectionReusableView
    final func register<T: UICollectionReusableView>(_ supplementaryViewType: T.Type, ofKind elementKind: String)
        where T: NibReusable {
            self.register(
                supplementaryViewType.nib,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: supplementaryViewType.reuseIdentifier
            )
    }
    
    final func register<T: UICollectionReusableView>(_ supplementaryViewType: T.Type, ofKind elementKind: String)
        where T: Reusable {
            self.register(
                supplementaryViewType.self,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: supplementaryViewType.reuseIdentifier
            )
    }
    
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>
        (ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T
        where T: Reusable {
            let view = self.dequeueReusableSupplementaryView(
                ofKind: elementKind,
                withReuseIdentifier: viewType.reuseIdentifier,
                for: indexPath
            )
            guard let typedView = view as? T else {
                fatalError(
                    "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) "
                        + "matching type \(viewType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the supplementary view beforehand"
                )
            }
            return typedView
    }
}


