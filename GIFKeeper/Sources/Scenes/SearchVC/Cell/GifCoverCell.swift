//
//  GifGroupCell.swift
//  GIFKeeper
//
//  Created by Artyom Guzenko on 12.10.2023.
//

import UIKit
import SnapKit

final class GifCoverCell: UICollectionViewCell {

    // MARK: - UIElements
    
    private var coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration view

private extension GifCoverCell {
    func setupHierarchy() {
        addSubview(coverImage)
    }
    
    func setupLayout() {
        coverImage.snp.makeConstraints { make in make.edges.equalToSuperview() }
    }
}

extension String {
    static let groupCell = "GroupCell"
}
