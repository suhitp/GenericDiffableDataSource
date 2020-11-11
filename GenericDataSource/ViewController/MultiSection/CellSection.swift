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
    case horizontalScrollingCell([Playlist])
    
    func elements() -> [AnyHashable] {
        switch self {
        case .customText(let carousels):
            return carousels
        case .horizontal(let playlists):
            return playlists
        case .vertical(let ads):
            return ads
        case .horizontalScrollingCell(let playlists):
            return [playlists]
        }
    }
    
    func isContentEqual(to source: CellSection) -> Bool {
        return source.elements() == self.elements()
    }
    
    var differenceIdentifier: String {
        return UUID().uuidString
    }
    
    var headerViewTitle: String {
        switch self {
        case .customText:
            return "Custom Thumbnail n Text Header"
        case .horizontal:
            return "Horizontal Image Header"
        case .vertical:
            return "Vertical Image Header"
        case .horizontalScrollingCell:
            return "Horizontal Scrolling Cell Header"
        }
    }
}

