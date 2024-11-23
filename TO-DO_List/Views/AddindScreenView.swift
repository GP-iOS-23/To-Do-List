//
//  AddindScreenView.swift
//  TO-DO_List
//
//  Created by Глеб Поляков on 19.11.2024.
//

import Foundation
import UIKit

protocol AddindScreenViewDelegate: AnyObject {
    func didSaveData()
}

final class AddindScreenView: UIView {
    
    private var viewModel: AddindScreenViewModel?
    public weak var delegate: AddindScreenViewDelegate?
    
    private let taskText: UITextField = {
        let textField = UITextField()
        textField.placeholder = "What you're going to do?"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let descriptionText: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Any addistional info"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .lightGray
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return divider
    }()
    
    private let taskStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack.layoutMargins = insets
        stack.distribution = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.cornerRadius = 10
        stack.backgroundColor = .systemBackground
        return stack
    }()
    
    private let dateStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack.layoutMargins = insets
        stack.distribution = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.cornerRadius = 10
        stack.backgroundColor = .systemBackground
        return stack
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Deadline:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 15
        return button
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false
        // Text
        addSubview(taskStackView)
        taskStackView.addArrangedSubview(taskText)
        taskStackView.addArrangedSubview(divider)
        taskStackView.addArrangedSubview(descriptionText)
        // Deadline date
        addSubview(dateStackView)
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(datePicker)
        
        addSubview(saveButton)
        addConstraints()
        setupButton()
        setUpTaskTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            taskStackView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            taskStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            taskStackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),
            taskStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            
            taskText.heightAnchor.constraint(equalTo: taskStackView.heightAnchor, multiplier: 0.3),
            
            dateStackView.topAnchor.constraint(equalTo: taskStackView.bottomAnchor, constant: 20),
            dateStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateStackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),
            dateStackView.heightAnchor.constraint(equalTo: taskStackView.heightAnchor, multiplier: 0.3),
            
            saveButton.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 30),
            saveButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func setupButton() {
        saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
    }
    
    private func setUpTaskTextField() {
        taskText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            saveButton.isEnabled = true
            saveButton.backgroundColor = .systemBlue
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = .systemGray
        }
    }
    
    @objc private func saveData() {
        guard let taskText = taskText.text else {
            return
        }
        let newTask = Task(id: UUID(),
                           taskText: taskText,
                           description: descriptionText.text ?? "",
                           isCompleted: false,
                           createdAt: Date(),
                           deadline: datePicker.date)
        viewModel?.saveData(task: newTask)
        delegate?.didSaveData()
    }
    
    // MARK: - Public
    public func configure(with viewModel: AddindScreenViewModel) {
        self.viewModel = viewModel
    }
}
