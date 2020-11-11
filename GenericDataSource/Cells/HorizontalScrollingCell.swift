//
//  HorizontalScrollingCell.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 10/11/20.
//

import UIKit
import DifferenceKit

enum HScrollSection: Differentiable, CaseIterable {
    case one
}


class HorizontalScrollingCell: UICollectionViewCell, NibReusable {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var layout: UICollectionViewFlowLayout!
    
    private typealias Section = ArraySection<HScrollSection, Playlist>
   
    private var dataSource: DiffableCollectionViewDataSource<Section, Playlist>!
    
    private var data: [Section] = []
    
    private var dataInput: [Section] {
        get {
          return data
        }
        set {
            dataSource.reload(with: newValue) { newData in
                self.data = newData
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        setupDataSource()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.register(HorizontalCell.self)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = .zero
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 190)
    }
    
    fileprivate func setupDataSource() {
        dataSource = DiffableCollectionViewDataSource<Section, Playlist>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, playlist) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(for: indexPath) as HorizontalCell
                cell.render(with: playlist)
                return cell
            }
        )
    }
    
    func render(with playlists: [Playlist]) {
        if dataInput.isEmpty {
            dataInput = [
                Section(model: .one, elements: playlists)
            ]
        }
    }
}

