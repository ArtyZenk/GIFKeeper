//
//  FavoriteHeader.swift
//  GIFKeeper
//
//  Created by Artyom Guzenko on 21.10.2023.
//

import UIKit

final class FavoriteHeader: UICollectionReusableView {
    
    // MARK: UI
    
    let title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(
            ofSize: Constants.titleFontSize,
            weight: .bold
        )
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
    
    // MARK: Override methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
    }
}

// MARK: - Setup Hierarchy

private extension FavoriteHeader {
    func setupHierarchy() {
        addSubview(title)
    }
}

// MARK: - Setup Layout

private extension FavoriteHeader {
    func setupLayout() {
        title.snp.makeConstraints {
            $0.left.equalTo(self).offset(Constants.titleLeftConstrain)
            $0.bottom.equalTo(self)
        }
    }
}

extension String {
    static let favoriteHeader = "FavoriteHeader"
}

// MARK: - Constants

private enum Constants {
    static let titleFontSize: CGFloat = 32
    static let titleLeftConstrain: CGFloat = -5
}
