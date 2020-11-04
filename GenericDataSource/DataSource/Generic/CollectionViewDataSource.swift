//
//  CollectionViewDataSource.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 02/11/20.
//

import DifferenceKit
import UIKit

public class CollectionViewDataSource<Section, Item>: NSObject, UICollectionViewDataSource where Section: SectionDecorator, Section.Item == Item {
    
    public typealias CellProvider = (UICollectionView, IndexPath, Item) -> UICollectionViewCell?
    public typealias SupplementaryViewProvider = (UICollectionView, String, IndexPath) -> UICollectionReusableView?
    
    var sections: [Section]
    weak var collectionView: UICollectionView?
    var cellProvider: CollectionViewDataSource<Section, Item>.CellProvider
    var supplementaryViewProvider: CollectionViewDataSource<Section, Item>.SupplementaryViewProvider?
    
    init(
        sections: [Section] = [],
        collectionView: UICollectionView,
        cellProvider: @escaping CollectionViewDataSource<Section, Item>.CellProvider
    ) {
        self.sections = sections
        self.collectionView = collectionView
        self.cellProvider = cellProvider
        super.init()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.isEmpty ? 0 : sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard !sections.isEmpty else {
            return 0
        }
        return sections[section].numberOfItems()
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cellProvider(collectionView, indexPath, itemAtIndexPath(indexPath)) else {
            fatalError("Inavlid cell configured")
        }
        return cell
    }

    func itemAtIndexPath(_ indexPath: IndexPath) -> Item {
        return sections[indexPath.section].itemAtIndexPath(indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = supplementaryViewProvider?(collectionView, kind, indexPath) else {
            return UICollectionReusableView()
        }
        return supplementaryView
    }
    
    public func reload(with data: [Section]) {
        sections += data
        collectionView?.dataSource = self
        collectionView?.reloadData()
    }
    
    public func insert(sections: [Section], animated: Bool, completion: ((Bool) -> Void)? = nil) {
        collectionView?.performBatchUpdates {
            self.sections = sections
            self.collectionView?.reloadData()
        } completion: { finish in
            completion?(finish)
        }
    }
}
