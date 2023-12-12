//
//  CustomTextField.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 16.10.2023.
//

import UIKit

final class CustomTextField: UITextField {
    
    init() {
        super.init(frame: .zero)
        setupTextFieldProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    private func setupTextFieldProperties() {
        font = .systemFont(ofSize: 20)
        clearsOnBeginEditing = true
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    }
}
