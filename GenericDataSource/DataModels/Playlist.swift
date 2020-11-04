//
//  Playlist.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 04/11/20.
//

import Foundation
import DifferenceKit

struct Playlist: Hashable, Differentiable {
   
    let id: String
    let title: String
    let imageUrl: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
