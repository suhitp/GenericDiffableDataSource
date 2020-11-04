//
//  Reusable.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 02/11/20.
//

import Foundation

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(reflecting: self)
    }
}

public typealias NibReusable = NibLoadable & Reusable
