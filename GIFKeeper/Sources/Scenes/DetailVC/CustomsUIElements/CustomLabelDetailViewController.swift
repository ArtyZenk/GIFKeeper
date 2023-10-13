//
//  CustomLabelDetailViewController.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 16.10.2023.
//

import UIKit

final class CustomLabelDetailViewController: UILabel {
    private var title: String = ""
    
    init(text: String) {
        super.init(frame: .zero)
        self.title = text
        setupLabelProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupLabelProperties() {
        text = title
        font = UIFont.systemFont(ofSize: 20)
    }
}
