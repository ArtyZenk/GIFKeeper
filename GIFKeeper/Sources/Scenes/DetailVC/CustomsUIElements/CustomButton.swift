//
//  CustomButton.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 13.10.2023.
//

import UIKit

final class CustomButton: UIButton {
    private var titleButton = ""
    
    init(titleForButton: String) {
        super.init(frame: .zero)
        self.titleButton = titleForButton
        setupButtonProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupButtonProperties() {
        setTitle(titleButton, for: .normal)
        let color = titleButton == "Delete" ? .red : UIColor.appMainColor()
        setTitleColor(color, for: .normal)
        layer.cornerRadius = 18
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}
