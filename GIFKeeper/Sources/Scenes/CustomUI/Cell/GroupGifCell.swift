//
//  GroupsGifCell.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 21.10.2023.
//

import UIKit
import SnapKit

// FIXME: Temporary model
#warning("Add in viper module")

protocol CursorProtocol {
    func setCursor(isEnabled: Bool)
}

final class GroupGifCell: UICollectionViewCell, CursorProtocol {

    // MARK: UIElements
    
    private let groupCoverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = CGColor(
            red: 58 / 255,
            green: 163 / 255,
            blue: 144 / 255,
            alpha: 1
        )
        return imageView
    }()
    
    private let groupName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Sample"
        label.adjustsFontSizeToFitWidth = true
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

private extension GroupGifCell {
    func setupHierarchy() {
        addSubview(groupCoverImage)
        groupCoverImage.addSubview(groupName)
    }
}

// MARK: - Setup constraints

private extension GroupGifCell {
    func setupLayout() {
        groupCoverImage.snp.makeConstraints { $0.edges.equalToSuperview() }
        groupName.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview().inset(Constants.indentUIElements)
        }
    }
}

// MARK: - Setup properties

extension GroupGifCell {
    func set(name: String) {
        groupName.text = name
    }
    
    func setCursor(isEnabled: Bool) {
        groupCoverImage.layer.borderWidth = isEnabled ? 4 : 0
    }
    
    override func prepareForReuse() {
        groupName.text = nil
    }
}

// MARK: - Constants

extension GroupGifCell {
    enum Constants {
        static let indentUIElements: CGFloat = 10
    }
}

// MARK: - Identifier cell

extension String {
    static let groupGifCell = "GroupGifCell"
}
