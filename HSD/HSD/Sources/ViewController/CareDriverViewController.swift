//
//  CareDriverViewController.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import Combine
import UIKit

final class CareDriverViewController: UIViewController {
    
    private let stateProvider: CareDriverStateProvider
    private var cancellables = Set<AnyCancellable>()
    
    private enum Section {
        case content
    }
    
    private lazy var dataSource: UITableViewDiffableDataSource<Section, Trip> = {
       UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView: UITableView, indexPath: IndexPath, trip: Trip) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell") as? TripCell else {
                fatalError("Handle error nicely")
            }
            cell.configure(trip)
            return cell
        })
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(TripCell.self, forCellReuseIdentifier: "TripCell")
        view.rowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        view.delegate = self
        return view
    }()
    
    init(stateProvider: CareDriverStateProvider) {
        self.stateProvider = stateProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Rides" // [KL]: would use localizable.strings for localizations
        setupLayout()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stateProvider.load()
    }
    
    private func bindData() {
        stateProvider
            .statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.updateUI(with: state)
            }
            .store(in: &cancellables)
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        let closeItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeView))
        navigationItem.leftBarButtonItem = closeItem
    }

    private func updateUI(with state: CareDriverState) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Trip>()
        snapshot.appendSections([.content])
        snapshot.appendItems(state.tripData.trips, toSection: .content)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc private func closeView() {
        dismiss(animated: true)
    }
}

extension CareDriverViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        stateProvider.showAlert(for: item, from: self)
    }
}
