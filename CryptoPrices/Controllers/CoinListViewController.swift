//
//  CoinListViewController.swift
//  CryptoPrices
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import UIKit

final class CoinListViewController: UIViewController {
    
    private(set) var tableView = UITableView(frame: .zero, style: .plain)
    private(set) var refreshControl = UIRefreshControl()
    private(set) var viewModel: CoinListViewModel
    
    init(viewModel: CoinListViewModel = CoinListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) not supported") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cryptos"
        view.backgroundColor = .systemBackground
        setupTable()
        bind()
        setupNavigationTheme()
        viewModel.fetch()
    }
    
    private func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 68
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupNavigationTheme() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "moon.circle"),
            style: .plain,
            target: self,
            action: #selector(handleThemeTap)
        )
    }
    
    private func bind() {
        viewModel.onUpdate = { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
        viewModel.onError = { [weak self] error in
            self?.refreshControl.endRefreshing()
            let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    @objc internal func handleRefresh() {
        viewModel.fetch()
    }
    
    @objc internal func handleThemeTap() {
        let sheet = UIAlertController(title: "Tema", message: nil, preferredStyle: .actionSheet)
        Theme.allCases.forEach { theme in
            sheet.addAction(UIAlertAction(title: theme.title, style: .default) { _ in
                ThemeManager.shared.apply(theme, to: self.view.window)
            })
        }
        sheet.addAction(.init(title: "Cancelar", style: .cancel))
        present(sheet, animated: true)
    }
}

extension CoinListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.reuseId, for: indexPath) as? CoinTableViewCell else {
            return UITableViewCell()
        }
        let vm = viewModel.viewModelForCell(at: indexPath.row)
        cell.configure(with: vm)
        return cell
    }
}

extension CoinListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coin = viewModel.coins[indexPath.row]
        let detailVM = CoinDetailViewModel(coin: coin)
        let vc = CoinDetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(vc, animated: true)
    }
}
