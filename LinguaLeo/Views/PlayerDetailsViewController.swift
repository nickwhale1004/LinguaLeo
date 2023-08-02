//
//  PlayerDetailsViewController.swift
//  LinguaLeo
//
//  Created by Никита Шляхов on 02.08.2023.
//

import UIKit

final class PlayerDetailsViewController: UIViewController {
	
	// MARK: - Subviews
	
	private lazy var tblView: UITableView = {
		let tbl = UITableView()
		tbl.translatesAutoresizingMaskIntoConstraints = false
		tbl.delegate = self
		tbl.register(DetailTableViewCell.self)
		tbl.register(ButtonTableViewCell.self)
		return tbl
	}()
	
	// MARK: - Properties
	
	private let viewModel: PlayerDetailsViewModel
	
	// MARK: - Initialization
	
	init(viewModel: PlayerDetailsViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		
		viewModel.dataSource = createDataSource()
		viewModel.willBack = { [weak self] in
			guard let self else { return }
			navigationController?.popViewController(animated: true)
		}
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
		title = "Player details"
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

extension PlayerDetailsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let title = viewModel.dataSource?.sectionIdentifier(for: section)?.title else { return nil }
		
		let lbl = UILabel()
		lbl.textAlignment = .center
		lbl.font = .boldSystemFont(ofSize: 28)
		lbl.text = title
		lbl.backgroundColor = .white
		return lbl
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard case .delete = viewModel.dataSource?.itemIdentifier(for: indexPath) else { return }
		viewModel.deletePlayer()
	}
}

// MARK: - DataSource

extension PlayerDetailsViewController {
	func createDataSource() -> TableDataSource<PlayerDetailsViewModel.Section, PlayerDetailsViewModel.Row> {
		return TableDataSource<PlayerDetailsViewModel.Section, PlayerDetailsViewModel.Row>(tableView: tblView) { tblView, indexPath, row in
			let cellViewModel: DetailViewModel
			
			switch row {
			case let .name(text), let .country(text):
				cellViewModel = DetailViewModel(title: row.title, description: text)
				
				let cell: DetailTableViewCell = tblView.dequeueReusableCell(for: indexPath)
				cell.configure(cellViewModel)
				return cell
			
			case let .age(count), let .level(count), let .score(count):
				cellViewModel = DetailViewModel(title: row.title, description: "\(count)")
				
				let cell: DetailTableViewCell = tblView.dequeueReusableCell(for: indexPath)
				cell.configure(cellViewModel)
				return cell
				
			case .delete:
				let cell: ButtonTableViewCell = tblView.dequeueReusableCell(for: indexPath)
				cell.configure(row.title)
				return cell
			}
		}
	}
}
