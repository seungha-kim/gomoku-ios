//
//  MyTestView.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/17.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import UIKit

class MyTestView: UIView, UIViewConfiguration {
    private lazy var box = UIView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAll()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAll()
    }

    func configureView() {
        backgroundColor = .yellow
        box.backgroundColor = .green
        self.addSubview(box)
    }
    
    func configureConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        box.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.center.equalTo(self)
        }
    }
}
