//
//  CustomLabel.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 16.10.2023.
//

import UIKit

final class CustomLabel: UILabel {
    private var textLabel = ""
    
    init(textForLabel: String) {
        super.init(frame: .zero)
        self.textLabel = textForLabel
        setupLabelProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    private func setupLabelProperties() {
        text = textLabel
        font = UIFont.systemFont(ofSize: 20)
    }
}
