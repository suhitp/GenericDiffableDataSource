//
//  ShuffledEmojiCollectionViewController.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 04/11/20.
//

import UIKit
import DifferenceKit

enum SectionID: Differentiable, CaseIterable {
    case first, second, third, four, five, six
}

class ShuffledEmojiViewController: UIViewController {

    typealias Section = ArraySection<SectionID, String>
   
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 50, height: 30)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()

    lazy var collectionView: UICollectionView = UICollectionView(
        frame: view.bounds,
        collectionViewLayout: flowLayout
    )

    var dataSource: DiffableCollectionViewDataSource<Section, String>!

    private lazy var data = [Section]()
    
    private var dataInput: [Section] {
        get { return data }
        set {
            dataSource.reload(with: newValue) {
                self.data = $0
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupBarButtons()
        setupDataSource()
        refresh()
    }

    fileprivate func setupView() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        navigationItem.title = "Emoji"
    }

    fileprivate func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .systemBackground
        } else {
            collectionView.backgroundColor = .black
        }
        collectionView.delegate = self
        collectionView.register(EmojiCell.self)
    }

    fileprivate func setupDataSource() {
        dataSource = DiffableCollectionViewDataSource<Section, String>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(for: indexPath) as EmojiCell
                cell.render(with: item)
                return cell
            }
        )
    }

    fileprivate func setupBarButtons() {
        let refreshBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(refreshAction))
        let shuffleAllButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(shuffleAllEmojis))
        let shuffleSectionButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(shuffleSections))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(refreshEmojis))
        navigationItem.rightBarButtonItems = [refreshBarButton, shuffleAllButton, shuffleSectionButton, refreshButton]
    }

    @objc func refreshAction() {
        shuffleAllEmojis()
    }

    @objc func refreshEmojis() {
        refresh()
    }

    func refresh() {
        let ids = SectionID.allCases
        let Emojis = (0x1F600...0x1F647).compactMap { UnicodeScalar($0).map(String.init) }
        let splitedCount = Int((Double(Emojis.count) / Double(ids.count)).rounded(.up))

        dataInput = ids.enumerated().map { offset, model in
            let start = offset * splitedCount
            let end = min(start + splitedCount, Emojis.endIndex)
            let Emojis = Emojis[start..<end]
            return Section(model: model, elements: Emojis)
        }
    }

    @objc func shuffleAllEmojis() {
        var flattenEmojis = ArraySlice(dataInput.flatMap { $0.elements })
        flattenEmojis.shuffle()

        dataInput = dataInput.map { section in
            var section = section
            section.elements = Array(flattenEmojis.prefix(section.elements.count))
            flattenEmojis.removeFirst(section.elements.count)
            return section
        }
    }

    @objc func shuffleSections() {
        dataInput.shuffle()
    }

    func remove(at indexPath: IndexPath) {
        dataInput[indexPath.section].elements.remove(at: indexPath.row)
    }
}


extension ShuffledEmojiViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        remove(at: indexPath)
    }
}
