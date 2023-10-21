//
//  FavoriteGifCoverCell.swift
//  GIFKeeper
//
//  Created by Artyom Guzenko on 19.10.2023.
//

import UIKit

final class FavoriteGifCoverCell: UICollectionViewCell {

    // MARK: UI
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private let titleCover: UILabel = {
        let label = UILabel()
        label.text = Constants.titleImageText
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
    
    func configureCell(coverName: String) {
        titleCover.text = coverName
    }
}

// MARK: - Setup hierarchy

private extension FavoriteGifCoverCell {
    func setupHierarchy() {
        coverImageView.addSubview(titleCover)
        addSubview(coverImageView)
    }
}

// MARK: - Setup layout

private extension FavoriteGifCoverCell {
    func setupLayout() {
        coverImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        titleCover.snp.makeConstraints { $0.center.equalTo(coverImageView) }
    }
}

// MARK: - Constants

private enum Constants {
    static let titleImageText = "Cover"
}

extension String {
    static let favoriteGifCell = "FavoriteGifCell"
}
