//
//  Carousel.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 02/11/20.
//

import Foundation
import DifferenceKit

struct Carousel: Hashable, Differentiable {
   
    let id: String
    let title: String
    let imageUrl: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

