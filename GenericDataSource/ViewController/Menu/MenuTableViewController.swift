//
//  MenuTableViewController.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 04/11/20.
//

import UIKit
import DifferenceKit

enum MenuSection: Differentiable, CaseIterable  {
    case one
}

struct Component: Hashable, Differentiable {
    
    var title: String
    var subtitle: String
    var initViewController: () -> UIViewController
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    static func == (lhs: Component, rhs: Component) -> Bool {
        return lhs.title == rhs.title && lhs.subtitle == rhs.subtitle
    }
}

class MenuTableViewController: UITableViewController {

    typealias Section = ArraySection<MenuSection, Component>

    var dataSource: DiffableTableViewDataSource<Section, Component>!

    private lazy var data = [Section]()
    
    private var dataInput: [Section] {
        get { return data }
        set {
            dataSource.reload(with: newValue) {
                self.data = $0
            }
        }
    }
    
    private let components = [
        Component(
            title: "Shuffle Emojis",
            subtitle: "Shuffle sectioned Emojis in UICollectionView",
            initViewController: ShuffledEmojiViewController.init
        ),
        Component(
            title: "MultiSection DiffableDataSource",
            subtitle: "Multiple Sections in UICollectionView",
            initViewController: { MultiSectionCollectionViewController() }
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDataSource()
        setupDataInput()
    }

    private func setupViews() {
        title = "Home"
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        tableView.register(HomeCell.self)
    }
    
    private func setupDataSource() {
        dataSource = DiffableTableViewDataSource<Section, Component>(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, component) -> UITableViewCell? in
                let cell = tableView.dequeueReusableCell(for: indexPath) as HomeCell
                cell.accessoryType = .disclosureIndicator
                cell.render(with: component)
                return cell
            }
        )
    }
    
    private func setupDataInput() {
        let sections = MenuSection.allCases
        dataInput = sections.enumerated().map { (index, model) in
            return ArraySection(model: model, elements: components)
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let component = components[indexPath.row]
        navigationController?.pushViewController(component.initViewController(), animated: true)
    }
    
}
