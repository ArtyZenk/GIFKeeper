//
//  CustomUIElements.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 13.10.2023.
//

import UIKit

final class CustomButtonDetailViewController: UIButton {
    private var text = ""
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        
        setupButtonProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupButtonProperties() {
        setTitle(text, for: .normal)
        let color = text == "Delete" ? .red : UIColor.appMainColor()
        setTitleColor(color, for: .normal)
        layer.cornerRadius = 18
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}
