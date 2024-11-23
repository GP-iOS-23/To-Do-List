//
//  AddingScreenViewController.swift
//  TO-DO_List
//
//  Created by Глеб Поляков on 19.11.2024.
//

import UIKit

class AddingScreenViewController: UIViewController, AddindScreenViewDelegate {
    
    private let primaryView = AddindScreenView()
    private let viewModel = AddindScreenViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(primaryView)
        view.backgroundColor = .systemBackground
        primaryView.delegate = self
        primaryView.configure(with: viewModel)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - AddingScreenViewDelegate
    func didSaveData() {
        self.dismiss(animated: true)
    }
}
