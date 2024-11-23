//
//  RootView.swift
//  TO-DO_List
//
//  Created by Глеб Поляков on 18.11.2024.
//

import Foundation
import UIKit

final class RootView: UIView {
    
    private var viewModel: RootViewModel?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RootTableViewCell.self,
                           forCellReuseIdentifier: RootTableViewCell.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        addConstraints()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("fatal error")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Public
    public func configure(with viewModel: RootViewModel) {
        self.viewModel = viewModel
    }
    
    public func reloadData() {
        tableView.reloadData()
    }
}
// MARK: - UITableViewDataSource

extension RootView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfTasks ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RootTableViewCell.cellIdentifier, for: indexPath) as? RootTableViewCell
        else { fatalError() }
        guard let task = viewModel?.getTask(for: indexPath) else {
            fatalError("Error creating cellViewModel")
        }
        cell.configure(with: RootTableViewCellViewModel(task: task))
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel?.deleteTask(for: indexPath)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension RootView: UITableViewDelegate { }
