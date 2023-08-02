//
//  PlayersViewController.swift
//  LinguaLeo
//
//  Created by Никита Шляхов on 02.08.2023.
//

import UIKit

final class PlayersViewController: UIViewController {
	
	// MARK: - Subviews
	
	private lazy var tblView: UITableView = {
		let tbl = UITableView()
		tbl.translatesAutoresizingMaskIntoConstraints = false
		tbl.delegate = self
		tbl.register(DetailTableViewCell.self)
		return tbl
	}()
	
	// MARK: - Properties
	
	private let viewModel: PlayersViewModel
	
	// MARK: - Initialization
	
	init(viewModel: PlayersViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		
		viewModel.dataSource = createDataSource()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.viewDidLoad()
		setupUI()
		setupConstraints()
	}
	
	// MARK: - Methods
	
	private func setupUI() {
		view.addSubview(tblView)
		view.backgroundColor = .white
		title = "Players statistics"
	}
	
	private func setupConstraints() {
		let constraints = [
			NSLayoutConstraint(item: tblView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: tblView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: tblView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: tblView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: 0)
		]
		view.addConstraints(constraints)
		NSLayoutConstraint.activate(constraints)
	}
}

// MARK: - UITableViewDelegate

extension PlayersViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard case let .country(title) = viewModel.dataSource?.sectionIdentifier(for: section) else { return nil }
		
		let lbl = UILabel()
		lbl.textAlignment = .center
		lbl.font = .boldSystemFont(ofSize: 28)
		lbl.text = title
		lbl.backgroundColor = .white
		return lbl
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard case let .player(model) = viewModel.dataSource?.itemIdentifier(for: indexPath) else { return }
		
		let detailsViewModel = PlayerDetailsViewModel(statistics: model)
		detailsViewModel.delegate = viewModel
		let vc = PlayerDetailsViewController(viewModel: detailsViewModel)
		navigationController?.pushViewController(vc, animated: true)
	}
}

// MARK: - DataSource

extension PlayersViewController {
	func createDataSource() -> TableDataSource<PlayersViewModel.Section, PlayersViewModel.Row> {
		return TableDataSource<PlayersViewModel.Section, PlayersViewModel.Row>(tableView: tblView) { tblView, indexPath, row in
			switch row {
			case let .player(model):
				let cell: DetailTableViewCell = tblView.dequeueReusableCell(for: indexPath)
				let cellViewModel = DetailViewModel(model)
				cell.configure(cellViewModel)
				return cell
			}
		}
	}
}

