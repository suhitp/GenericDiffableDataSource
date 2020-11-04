//
//  CellSection.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 04/11/20.
//

import Foundation
import DifferenceKit

enum CellSection: Differentiable, Equatable, Hashable {
    
    case vertical([Carousel])
    case horizontal([Playlist])
    case customText([Ads])
    
    func elements() -> [AnyHashable] {
        switch self {
        case .customText(let carousels):
            return carousels
        case .horizontal(let playlists):
            return playlists
        case .vertical(let ads):
            return ads
        }
    }
    
    func isContentEqual(to source: CellSection) -> Bool {
        return source.elements() == self.elements()
    }
    
    var differenceIdentifier: String {
        return UUID().uuidString
    }
}

