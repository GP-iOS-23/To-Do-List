//
//  RootTableViewCell.swift
//  TO-DO_List
//
//  Created by Глеб Поляков on 18.11.2024.
//

import Foundation
import UIKit

final class RootTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "RootTableViewCell"

    private let taskLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let primaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stackView.layoutMargins = insets
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let secondaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stackView.layoutMargins = insets
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(primaryStackView)
        primaryStackView.addArrangedSubview(completeButton)
        primaryStackView.addArrangedSubview(secondaryStackView)
        secondaryStackView.addArrangedSubview(taskLabel)
        secondaryStackView.addArrangedSubview(descriptionLabel)
        addConstraints()
        
        completeButton.addTarget(self, action: #selector(completed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taskLabel.text = nil
        descriptionLabel.text = nil
    }
    
    
    @objc private func completed() {
        completeButton.isSelected.toggle()
        if completeButton.isSelected {
            taskLabel.strikeThrough(with: taskLabel.text ?? "")
            descriptionLabel.strikeThrough(with: descriptionLabel.text ?? "")
        } else {
            taskLabel.removeStrikeThrough()
            descriptionLabel.removeStrikeThrough()
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            primaryStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            primaryStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            primaryStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            primaryStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            primaryStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            primaryStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            secondaryStackView.topAnchor.constraint(equalTo: primaryStackView.topAnchor),
            secondaryStackView.rightAnchor.constraint(equalTo: primaryStackView.rightAnchor),
            secondaryStackView.bottomAnchor.constraint(equalTo: primaryStackView.bottomAnchor),
            secondaryStackView.leftAnchor.constraint(equalTo: completeButton.rightAnchor),
            secondaryStackView.widthAnchor.constraint(equalTo: primaryStackView.widthAnchor, multiplier: 0.8),
            
            completeButton.topAnchor.constraint(equalTo: primaryStackView.topAnchor),
            completeButton.leftAnchor.constraint(equalTo: primaryStackView.leftAnchor),
            completeButton.bottomAnchor.constraint(equalTo: primaryStackView.bottomAnchor),
        ])
    }
    
    //MARK: - Public
    public func configure(with viewModel: RootTableViewCellViewModel) {
        taskLabel.text = viewModel.taskText
        descriptionLabel.text = viewModel.description
        completeButton.isSelected = viewModel.isCompleted
    }
}
