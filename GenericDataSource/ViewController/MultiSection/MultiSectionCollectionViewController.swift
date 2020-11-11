//
//  MultiSectionCollectionViewController.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 02/11/20.
//

import UIKit
import Foundation
import DifferenceKit

// MARK: MultiSectionCollectionViewController

class MultiSectionCollectionViewController: UICollectionViewController {
    
    typealias Section = ArraySection<CellSection, AnyDifferentiable>
    
    static var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = .init(top: 0, left: 0, bottom: 10, right: 0)
        return layout
    }()
    

    var dataSource: DiffableCollectionViewDataSource<Section, AnyDifferentiable>!

    private lazy var data = [Section]()
    
    private var dataInput: [Section] {
        get { return data }
        set {
            dataSource.reload(with: newValue) {
                self.data = $0
            }
        }
    }

    override init(collectionViewLayout layout: UICollectionViewLayout = flowLayout) {
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupBarButtons()
        registerCells()
        configureDataSource()
        setupData()
    }
    
    private func setupViews() {
        collectionView.backgroundColor = .systemBackground
        navigationItem.title = "MultiSection Demo"
        collectionView.delegate = self
    }
    
    private func registerCells() {
        // Register cell classes
        collectionView.register(VerticalCell.self)
        collectionView.register(HorizontalCell.self)
        collectionView.register(CustomTextCell.self)
        collectionView.register(HorizontalScrollingCell.self)
        collectionView.register(HeaderFooterReusableView.self, ofKind: .header)
    }
    
    private func setupData() {
        let input: [CellSection] = [
            CellSection.horizontalScrollingCell(
                [
                    Playlist(id: "0", title: "Playlist-1", imageUrl: horizontalImages[3]),
                    Playlist(id: "2", title: "Playlist-2", imageUrl: horizontalImages[1]),
                    Playlist(id: "3", title: "Playlist-3", imageUrl: horizontalImages[2]),
                    Playlist(id: "1", title: "Playlist-4", imageUrl: horizontalImages[0])
                ]
            ),
            CellSection.vertical(
                [
                    Carousel(id: "0", title: "Carousel-1", imageUrl: verticalImages[0]),
                    Carousel(id: "1", title: "Carousel-2", imageUrl: verticalImages[1]),
                    Carousel(id: "2", title: "Carousel-3", imageUrl: verticalImages[2]),
                    Carousel(id: "3", title: "Carousel-4", imageUrl: verticalImages[3])
                ]
            ),
            CellSection.horizontal(
                [
                    Playlist(id: "0", title: "Playlist-1", imageUrl: horizontalImages[0]),
                    Playlist(id: "1", title: "Playlist-2", imageUrl: horizontalImages[1]),
                    Playlist(id: "2", title: "Playlist-3", imageUrl: horizontalImages[2]),
                    Playlist(id: "3", title: "Playlist-4", imageUrl: horizontalImages[3])
                ]
            ),
            CellSection.customText(
                [
                    Ads(id: "101", title: "Ads-1", imageUrl: horizontalImages[0]),
                    Ads(id: "102", title: "Ads-2", imageUrl: horizontalImages[1]),
                    Ads(id: "103", title: "Ads-3", imageUrl: horizontalImages[2]),
                    Ads(id: "104", title: "Ads-4", imageUrl: horizontalImages[3])
                ]
            )
        ]
        dataInput = input.enumerated().map { (offset: Int, model: CellSection) in
            let elements = model.elements().map { AnyDifferentiable($0) }
            return Section(model: model, elements: elements)
        }
        print(dataInput)
    }
    
    // MARK: DiffableCollectionViewDataSource
    
    fileprivate func configureDataSource() {
       
        dataSource = DiffableCollectionViewDataSource<Section, AnyDifferentiable>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, anyDifferentiable) -> UICollectionViewCell? in
                let section: CellSection = self.dataInput[indexPath.section].model
                switch section {
                case .vertical:
                    let cell = collectionView.dequeueReusableCell(for: indexPath) as VerticalCell
                    if let carousel = anyDifferentiable.base as? Carousel {
                        cell.render(with: carousel)
                    }
                    return cell
                case .horizontal:
                    let cell = collectionView.dequeueReusableCell(for: indexPath) as HorizontalCell
                    if let playlist = anyDifferentiable.base as? Playlist {
                        cell.render(with: playlist)
                    }
                    return cell
                case .customText:
                    let cell = collectionView.dequeueReusableCell(for: indexPath) as CustomTextCell
                    if let ads = anyDifferentiable.base as? Ads {
                        cell.render(with: ads)
                    }
                    return cell
                case .horizontalScrollingCell:
                    let cell = collectionView.dequeueReusableCell(for: indexPath) as HorizontalScrollingCell
                    if let playlist = anyDifferentiable.base as? [Playlist] {
                        cell.render(with: playlist)
                    }
                    return cell
                }
            }
        )
        
        dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) in
            guard let dataInput = self?.dataInput else {
                return nil
            }
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath) as HeaderFooterReusableView
            let headerTitle: String = dataInput[indexPath.section].model.headerViewTitle
            headerView.render(with: headerTitle)
            return headerView
        }
    }
    
    // MARK: Private methods
    
    fileprivate func setupBarButtons() {
        let refreshBarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshAction))
        let shuffleAllButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shuffleAllSections))
        let sectionDeleteButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(animateSectionDeletion))
        navigationItem.rightBarButtonItems = [refreshBarButton, shuffleAllButton, sectionDeleteButton]
    }

    @objc func refreshAction() {
       setupData()
    }

    @objc func shuffleAllSections() {
        dataInput.shuffle()
    }
    
    @objc func animateSectionDeletion() {
        let input: [CellSection] = [
            CellSection.vertical(
                [
                    Carousel(id: "0", title: "Carousel-1", imageUrl: verticalImages[0]),
                    Carousel(id: "1", title: "Carousel-2", imageUrl: verticalImages[1]),
                    Carousel(id: "3", title: "Carousel-3", imageUrl: verticalImages[2]),
                    Carousel(id: "4", title: "Carousel-4", imageUrl: verticalImages[3])
                ]
            ),
            CellSection.customText(
                [
                    Ads(id: "101", title: "Ads-1", imageUrl: horizontalImages[0]),
                    Ads(id: "101", title: "Ads-2", imageUrl: horizontalImages[1]),
                    Ads(id: "101", title: "Ads-3", imageUrl: horizontalImages[2]),
                    Ads(id: "101", title: "Ads-4", imageUrl: horizontalImages[3])
                ]
            )
        ]
        dataInput = input.enumerated().map { (offset: Int, model: CellSection) in
            let elements = model.elements().map { AnyDifferentiable($0) }
            return Section(model: model, elements: elements)
        }
    }
}

extension MultiSectionCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataInput[indexPath.section].elements.remove(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section: CellSection = dataInput[indexPath.section].model
        switch section {
        case .vertical:
            return CGSize(width: (view.frame.width - 1) / 2, height: 275)
        case .horizontal:
            return CGSize(width: view.frame.width, height: 190)
        case .horizontalScrollingCell:
            return CGSize(width: view.frame.width, height: 190)
        case .customText:
            return CGSize(width: view.frame.width, height: 98)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }

}
