//
//  UIViewExtensions.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 02/11/20.
//

import Foundation
import UIKit

public extension UIView {

    func addAutoSubview(_ view: UIView) {
        view.useAutolayout()
        addSubview(view)
    }

    func addAutoSubviews(_ views: [UIView]) {
        for view in views {
            addAutoSubview(view)
        }
    }

    func useAutolayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func themeBackground(_ color: UIColor) {
        backgroundColor = color
    }
}

public extension UIView {
    
    func pinEdgesToSuperView(excluding excludedEdge: UIRectEdge, usingSafeArea: Bool = false, insets: UIEdgeInsets = .zero) {
        let superView = getSuperview()
        useAutolayout()
        if usingSafeArea, #available(iOS 11, *) {
            let safeAreaGuide = superView.safeAreaLayoutGuide
            guard !excludedEdge.contains(.all) else {
                fatalError("UIRectEdge.all should not be used as excluded type)")
            }
            if !excludedEdge.contains(.top) {
                self.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: insets.top).isActive = true
            }
            
            if !excludedEdge.contains(.bottom) {
                self.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: insets.bottom).isActive = true
            }
            
            if !excludedEdge.contains(.left) {
                self.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: insets.left).isActive = true
            }
            
            if !excludedEdge.contains(.right) {
                self.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: insets.right).isActive = true
            }
            
        } else {
            self.pinEdges(to: superView, excluding: excludedEdge, insets: insets)
        }
    }
    
    func pinEdges(to view: UIView, insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right)
        ])
    }
    
    func pinEdges(to view: UIView, excluding excludedEdge: UIRectEdge, insets: UIEdgeInsets) {
        guard !excludedEdge.contains(.all) else {
            fatalError("UIRectEdge.all should not be used as excluded type)")
        }
        
        if !excludedEdge.contains(.top) {
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        }
        
        if !excludedEdge.contains(.bottom) {
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
        }
        
        if !excludedEdge.contains(.left) {
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        }
        
        if !excludedEdge.contains(.right) {
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
        }
    }
    
    private func getSuperview() -> UIView {
        guard let superView = self.superview else {
            fatalError("Unable to create this constraint to it's superview, because it has no superview.")
        }
        return superView
    }
}

