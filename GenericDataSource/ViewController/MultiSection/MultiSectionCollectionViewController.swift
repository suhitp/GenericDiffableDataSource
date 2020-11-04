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
                    return cell
                }
            }
        )
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .black
        navigationItem.title = "MultiSection Demo"
        collectionView.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView.register(VerticalCell.self)
        collectionView.register(HorizontalCell.self)
        collectionView.register(CustomTextCell.self)
        
        setupBarButtons()
        configureDataSource()
        setupData()
    }
    
    func setupData() {
        let input: [CellSection] = [
            CellSection.vertical(
                [
                    Carousel(id: "0", title: "Carousel-1", imageUrl: ""),
                    Carousel(id: "1", title: "Carousel-2", imageUrl: ""),
                    Carousel(id: "3", title: "Carousel-3", imageUrl: ""),
                    Carousel(id: "4", title: "Carousel-4", imageUrl: "")
                ]
            ),
            CellSection.horizontal(
                [
                    Playlist(id: "0", title: "Playlist-1", imageUrl: ""),
                    Playlist(id: "2", title: "Playlist-2", imageUrl: "")
                ]
            ),
            CellSection.customText(
                [
                    Ads(id: "101", title: "Ads-1", imageUrl: ""),
                    Ads(id: "101", title: "Ads-1", imageUrl: ""),
                    Ads(id: "101", title: "Ads-1", imageUrl: "")
                ]
            )
        ]
        dataInput = input.enumerated().map { (offset: Int, model: CellSection) in
            let elements = model.elements().map { AnyDifferentiable($0) }
            return Section(model: model, elements: elements)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataInput[indexPath.section].elements.remove(at: indexPath.row)
    }
    
    fileprivate func setupBarButtons() {
        let refreshBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(refreshAction))
        let shuffleAllButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(shuffleAllSections))
        navigationItem.rightBarButtonItems = [refreshBarButton, shuffleAllButton]
    }

    @objc func refreshAction() {
       setupData()
    }

    @objc func shuffleAllSections() {
        dataInput.shuffle()
    }
}

extension MultiSectionCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section: CellSection = dataInput[indexPath.section].model
        switch section {
        case .vertical:
            return CGSize(width: (view.frame.width - 1) / 2, height: 220)
        case .horizontal:
            return CGSize(width: view.frame.width, height: 190)
        default:
            return CGSize(width: view.frame.width, height: 98)
        }
    }
}
