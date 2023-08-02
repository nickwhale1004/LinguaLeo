//
//  PlayerDetailsViewModel.swift
//  LinguaLeo
//
//  Created by Никита Шляхов on 02.08.2023.
//

import Foundation

protocol PlayerDetailsViewModelDelegate: AnyObject {
	func playerDetailsViewModel(_ viewModel: PlayerDetailsViewModel, willDelete model: PlayerStatisticsModel)
}

final class PlayerDetailsViewModel {
	
	// MARK: - Types
	
	enum Section: Hashable {
		case player
		case info
		case delete
	}
	
	enum Row: Hashable {
		case name(String)
		case age(Int)
		case country(String)
		case score(Int)
		case level(Int)
		case delete
	}
	
	// MARK: - Properties
	
	var delegate: PlayerDetailsViewModelDelegate?
	var dataSource: TableDataSource<Section, Row>?
	
	var willBack: (() -> Void)?
	
	private let statistics: PlayerStatisticsModel
	
	// MARK: - Initialization
	
	init(statistics: PlayerStatisticsModel) {
		self.statistics = statistics
	}
	
	// MARK: - Methods
	
	func deletePlayer() {
		delegate?.playerDetailsViewModel(self, willDelete: statistics)
		willBack?()
	}
	
	func viewDidLoad() {
		updateDataSource()
	}
	
	private func updateDataSource() {
		var snapShot = Snapshot<Section, Row>()
		
		snapShot.appendSections([
			.player,
			.info,
			.delete
		])
		snapShot.appendItems([
			.name(statistics.player.name),
			.age(statistics.player.age),
			.country(statistics.player.country)
		], toSection: .player)
		
		snapShot.appendItems([
			.score(statistics.playerInfo.score),
			.level(statistics.playerInfo.level)
		], toSection: .info)
		
		snapShot.appendItems([.delete], toSection: .delete)
		
		DispatchQueue.main.async {
			self.dataSource?.apply(snapShot, animatingDifferences: false)
		}
	}
}

// MARK: - Section+Title

extension PlayerDetailsViewModel.Section {
	var title: String? {
		switch self {
		case .info:
			return "Info"
		case .player:
			return "Player"
			
		case .delete:
			return nil
		}
	}
}

// MARK: - Row+Title

extension PlayerDetailsViewModel.Row {
	var title: String? {
		switch self {
		case .name:
			return "Name"
		case .age:
			return "Age"
		case .country:
			return "Country"
		case .score:
			return "Score"
		case .level:
			return "Level"
		case .delete:
			return "Delete player"
		}
	}
}

