//
//  DiffableCollectionViewDataSource.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 04/11/20.
//

import Foundation
import UIKit
import DifferenceKit

// MARK: DiffableCollectionViewDataSource

open class DiffableCollectionViewDataSource<Section: SectionType, Item>: NSObject, UICollectionViewDataSource where Section.Element == Item {
    
    /// CellSetion
    public typealias CellSection = ArraySection<Section.Model, Section.Element>
   
    /// CellProvider
    public typealias CellProvider = (UICollectionView, IndexPath, Item) -> UICollectionViewCell?
    
    /// SupplimentoryViewProvider
    public typealias SupplementaryViewProvider = (UICollectionView, String, IndexPath) -> UICollectionReusableView?
    
    // MARK: Properties
    
    private var sections: [CellSection] = []
    private weak var collectionView: UICollectionView?
    private var cellProvider: (UICollectionView, IndexPath, Item) -> UICollectionViewCell?
    private var supplementaryViewProvider: DiffableCollectionViewDataSource<Section, Item>.SupplementaryViewProvider?
    
    // MARK: init
    
    init(
        collectionView: UICollectionView,
        cellProvider: @escaping (UICollectionView, IndexPath, Item) -> UICollectionViewCell?
    ) {
        self.collectionView = collectionView
        self.cellProvider = cellProvider
        super.init()
        
        collectionView.dataSource = self
    }

    // MARK: UICollectionviewDataSource
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard !sections.isEmpty, section < sections.count else {
            return 0
        }
        return sections[section].elements.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cellProvider(collectionView, indexPath, itemAtIndexPath(indexPath)) else {
            fatalError("Inavlid cell configured")
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = supplementaryViewProvider?(collectionView, kind, indexPath) else {
            fatalError("Invalid supplementaryView configured")
        }
        return supplementaryView
    }

    // MARK: Private function
    
    private func itemAtIndexPath(_ indexPath: IndexPath) -> Item {
        return sections[indexPath.section].elements[indexPath.row]
    }

    // MARK: Public function
    
    public func reload(with newSections: [CellSection], completion: (([CellSection]) -> Void)?) {
        let changeset = StagedChangeset(source: sections, target: newSections)
        collectionView?.reload(using: changeset) { (data: [CellSection]) in
            self.sections = data
            completion?(data)
        }
    }
}

