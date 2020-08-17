//
//  UIViewConfiguration.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/17.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import UIKit

protocol UIViewConfiguration: UIView {
    func configureView()
    func configureConstraints()
    func configureActions()
}

extension UIViewConfiguration {
    func configureAll() {
        configureView()
        configureConstraints()
        configureActions()
    }
    
    func configureView() {}
    func configureConstraints() {}
    func configureActions() {}
}
