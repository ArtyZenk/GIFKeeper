//
//  CustomStackView.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 16.10.2023.
//

import UIKit

final class CustomStackView: UIStackView {
    
    init() {
        super.init(frame: .zero)
        setupStackViewProperties()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackViewProperties() {
        axis = .vertical
        spacing = 2
    }
}
