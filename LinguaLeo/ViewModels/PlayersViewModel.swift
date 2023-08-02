//
//  PlayersViewModel.swift
//  LinguaLeo
//
//  Created by Никита Шляхов on 02.08.2023.
//

import Foundation

final class PlayersViewModel {
	
	// MARK: - Types
	
	enum Section: Hashable {
		case country(title: String)
	}
	
	enum Row: Hashable {
		case player(_ model: PlayerStatisticsModel)
	}
	
	// MARK: - Properties
	
	var dataSource: TableDataSource<Section, Row>?
	
	private let service: DataServiceProtocol

	private var players: [PlayerStatisticsModel] = [] {
		didSet {
			updateDataSource()
		}
	}
	
	// MARK: - Initialization
	
	init(service: DataServiceProtocol = DataService()) {
		self.service = service
	}
	
	// MARK: - Methods
	
	func viewDidLoad() {
		service.getPlayers { [weak self] result in
			guard let self else { return }
			
			switch result {
			case let .success(model):
				players = model
				
			case let .failure(error):
				print(error)
			}
		}
	}
	
	private func updateDataSource() {
		var dict = [String: [PlayerStatisticsModel]]()
		
		players.forEach {
			if dict[$0.player.country] == nil {
				dict[$0.player.country] = [PlayerStatisticsModel]()
			}
			dict[$0.player.country]?.append($0)
		}
		
		var snapShot = Snapshot<Section, Row>()
		
		let sections = dict.keys.sorted(by: <).map { Section.country(title: $0) }
		snapShot.appendSections(sections)
		
		dict.keys.forEach {
			let rows = dict[$0]?
				.sorted(by: { $0.playerInfo.score > $1.playerInfo.score})
				.map { Row.player($0) }
			
			snapShot.appendItems(rows ?? [], toSection: Section.country(title: $0))
		}
		DispatchQueue.main.async {
			self.dataSource?.apply(snapShot, animatingDifferences: false)
		}
	}
}

// MARK: - PlayerDetailsViewModelDelegate

extension PlayersViewModel: PlayerDetailsViewModelDelegate {
	func playerDetailsViewModel(_ viewModel: PlayerDetailsViewModel, willDelete model: PlayerStatisticsModel) {
		players.removeAll { $0 == model }
	}
}
