//
//  GifCollectionCell.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 21.10.2023.
//

import UIKit
import SnapKit

final class GifWithTextCell: UICollectionViewCell {
    
    // MARK: UIElements
    
    private let gifImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let gifName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
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

private extension GifWithTextCell {
    func setupHierarchy() {
        addSubview(gifImage)
        addSubview(gifName)
    }
}

// MARK: - Setup constraints

private extension GifWithTextCell {
    func setupLayout() {
        gifImage.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        gifName.snp.makeConstraints {
            $0.top.equalTo(gifImage.snp.bottom).offset(10)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}

// MARK: - Setup properties

extension GifWithTextCell {
    func configureCell(gifModel: GifModel) {
        gifName.text = gifModel.name
        // FIXME: Temporary nil-coalising
        #warning("Must change it")
        gifImage.image = UIImage(systemName: gifModel.imageName ?? "")
    }
    
    override func prepareForReuse() {
        gifName.text = nil
        gifImage.image = nil
    }
}

// MARK: - Identifier cell

extension String {
    static let gifWithTextCell = "GifWithTextCell"
}
