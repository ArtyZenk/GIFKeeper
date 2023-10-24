//
//  SectionsHeader.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 21.10.2023.
//

import UIKit

final class SectionsHeader: UICollectionReusableView {

     // MARK: UIElements
     
     private let title: UILabel = {
         let title = UILabel()
         title.font = UIFont.systemFont(
            ofSize: 25,
            weight: .light)
         title.textColor = UIColor.appMainColor()
         return title
     }()

     // MARK: Init
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupHierarchy()
         setupLayout()
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 }

 // MARK: - Setup Hierarchy

 private extension SectionsHeader {
     func setupHierarchy() {
         addSubview(title)
     }
 }

 // MARK: - Setup constraints

 private extension SectionsHeader {
     func setupLayout() {
         title.snp.makeConstraints {
             $0.left.equalToSuperview().offset(10)
             $0.bottom.equalToSuperview()
         }
     }
 }

// MARK: - Setup properties

extension SectionsHeader {
    func set(titleText: String) {
        title.text = titleText
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
    }
}

// MARK: - Identifier

 extension String {
     static let sectionsHeader = "SectionsHeader"
 }
