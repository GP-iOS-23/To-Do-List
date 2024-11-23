//
//  ViewController.swift
//  TO-DO_List
//
//  Created by Глеб Поляков on 18.11.2024.
//

import UIKit
import Foundation

final class RootViewController: UIViewController, RootViewModelDelegate {
    
    private let primaryView = RootView()
    private let viewModel = RootViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(primaryView)
        view.backgroundColor = .systemBackground
        title = "TO-DO List"
        viewModel.delegate = self
        addConstraints()
        viewModel.fetchTasks()
        setupAddButton()
        
        NotificationCenter.default.addObserver(forName: .didAddTask, object: nil, queue: .main) { [weak self] notification in
            guard let task = notification.object as? Task else { return }
            self?.viewModel.addNewTask(with: task)
        }
    }
    
    private func setupAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector (addTask))
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func addTask() {
        let vc = AddingScreenViewController()
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true)
    }
    
    // MARK: - RootViewModelDelegate
    
    func didFetchTasks() {
        primaryView.configure(with: viewModel)
    }
    
    func didUpdateTasks() {
        DispatchQueue.main.async { [weak self] in
            self?.primaryView.reloadData()
        }
    }
}

