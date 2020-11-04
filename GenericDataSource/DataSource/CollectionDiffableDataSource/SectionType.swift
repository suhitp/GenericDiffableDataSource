//
//  SectionType.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 04/11/20.
//

import Foundation
import DifferenceKit

public protocol SectionType: DifferentiableSection {
    
    associatedtype Model: Differentiable
    associatedtype Element: Differentiable
    
    var model: Model { get set }
    var elements: [Element] { get set }
}
