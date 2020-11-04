//
//  TableViewDiffableDataSource.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 04/11/20.
//

import Foundation
import DifferenceKit
import UIKit

// MARK: DiffableTableViewDataSource

open class DiffableTableViewDataSource<Section: SectionType, Item>: NSObject, UITableViewDataSource where Section.Element == Item {
    
    /// CellSetion
    public typealias CellSection = ArraySection<Section.Model, Section.Element>
   
    /// CellProvider
    public typealias CellProvider = (UITableView, IndexPath, Item) -> UITableViewCell?
    
    /// SupplimentoryViewProvider
    public typealias SupplementaryViewProvider = (UITableView, String, IndexPath) -> UIView?
    
    // MARK: Properties
    
    private var sections: [CellSection] = []
    private weak var tableView: UITableView?
    private var cellProvider: DiffableTableViewDataSource<Section, Item>.CellProvider
    var supplementaryViewProvider: DiffableTableViewDataSource<Section, Item>.SupplementaryViewProvider?
    
    // MARK: init
    
    init(
        tableView: UITableView,
        cellProvider: @escaping DiffableTableViewDataSource<Section, Item>.CellProvider
    ) {
        self.tableView = tableView
        self.cellProvider = cellProvider
        super.init()
        
        tableView.dataSource = self
    }

    // MARK: UITableViewDataSource
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !sections.isEmpty, section < sections.count else {
            return 0
        }
        return sections[section].elements.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cellProvider(tableView, indexPath, itemAtIndexPath(indexPath)) else {
            fatalError("Inavlid cell configured")
        }
        return cell
    }

    // MARK: Private function
    
    private func itemAtIndexPath(_ indexPath: IndexPath) -> Item {
        return sections[indexPath.section].elements[indexPath.row]
    }

    // MARK: Public function
    
    public func reload(with newSections: [CellSection], animated: Bool = true, completion: (([CellSection]) -> Void)?) {
        let changeset = StagedChangeset(source: sections, target: newSections)
        let animation: UITableView.RowAnimation = animated ? .automatic : .none
        tableView?.reload(using: changeset, with: animation) { (data: [CellSection]) in
            self.sections = data
            completion?(data)
        }
    }
}


