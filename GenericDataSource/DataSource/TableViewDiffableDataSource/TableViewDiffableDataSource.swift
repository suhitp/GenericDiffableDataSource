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
    public typealias SectionHeaderFooterTitleProvider = (UITableView, UITableView.SectionHeaderFooterElementKind, Int) -> String?
    
    // MARK: Properties
    
    private var sections: [CellSection] = []
    private weak var tableView: UITableView?
    private var cellProvider: DiffableTableViewDataSource<Section, Item>.CellProvider
    public var sectionHeaderFooterTitleProvider: DiffableTableViewDataSource<Section, Item>.SectionHeaderFooterTitleProvider?
    
    // MARK: init
    
    public init(
        sections: [CellSection] = [],
        tableView: UITableView,
        cellProvider: @escaping DiffableTableViewDataSource<Section, Item>.CellProvider
    ) {
        self.sections = sections
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
            fatalError("Inavlid cell configured for section: \(indexPath.section) at indexPath: \(indexPath.row)")
        }
        return cell
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaderFooterTitleProvider?(tableView, .header, section)
    }

    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sectionHeaderFooterTitleProvider?(tableView, .footer, section)
    }

    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }

    open func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    open func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }

    open func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nil
    }

    open func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
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
