//
//  SettingsCell.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 17.11.2023.
//

import UIKit

final class SettingsCell: UITableViewCell {
    
    // MARK: UIElements
    
    private let title: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var value: UILabel = {
        let label = UILabel()
        label.contentMode = .right
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15)
        label.isUserInteractionEnabled = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkPressed))
        label.addGestureRecognizer(tapGesture)
        label.isHidden = true
        return label
    }()
    
    private lazy var toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isHidden = true
        toggle.addTarget(self, action: #selector(togglePressed(target:)), for: .valueChanged)
        return toggle
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Handle actions methods
    
    @objc private func togglePressed(target: UISwitch) {
        // FIXME: Temporary data
        #warning("Text data, needs to be change")
        if title.text == "Dark theme on" {}
    }
    
    @objc private func linkPressed() {
        openLinkFromValue()
    }
    
    private func openLinkFromValue() {
        guard let attributedString = value.attributedText else { return }
        attributedString.enumerateAttribute(
            .link,
            in: NSRange(
                location: 0,
                length: attributedString.length
            ), options: []) { 
                value, range, _ in
                if let url = value as? URL {
                    if let url = URL(string: url.absoluteString) {
                        UIApplication.shared.open(url)
                    }
                }
            }
    }
}

// MARK: - Configuration contentView

private extension SettingsCell {
    func setupHierarchy() {
        [title, value, toggle].forEach{ contentView.addSubview($0) }
    }
    
    func setupLayout() {
        title.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalToSuperview().offset(Constants.indentUI)
        }
        
        value.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalTo(title.snp.right).offset(Constants.indentUI)
            $0.right.equalToSuperview().inset(Constants.indentUI)
        }
        
        toggle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(title.snp.right).offset(Constants.indentUI)
            $0.right.equalToSuperview().inset(Constants.indentUI)
        }
    }
}

// MARK: - Setup properties

extension SettingsCell {
    func set<T>(titleText: String, valueOut: T) {
        title.text = titleText
        
        switch valueOut {
            case let valueWrapped as Bool :
                toggle.isHidden = false
                toggle.isOn = valueWrapped
            case let valueWrapped as URL :
                value.isHidden = false
                let attributedString = NSAttributedString(
                    string: "Link of project",
                    attributes: [NSAttributedString.Key.link: valueWrapped]
                )
                value.attributedText = attributedString
                value.isUserInteractionEnabled = true
            case let valueWrapped as String :
                value.isHidden = false
                value.text = valueWrapped
                value.isUserInteractionEnabled = false
            default :
                defaultStateCell()
        }
    }
    
    // MARK: PrepareForReuse

    override func prepareForReuse() {
        super.prepareForReuse()
        defaultStateCell()
    }
    
    private func defaultStateCell() {
        title.text = nil
        
        toggle.isHidden = true
        toggle.isOn = false
        
        value.attributedText = nil
        value.isHidden = true
        value.isUserInteractionEnabled = false
    }
}

// MARK: - Constants

private enum Constants {
    static let indentUI = 10
}

extension String {
    static let settingsCell = SettingsCell.description()
}
