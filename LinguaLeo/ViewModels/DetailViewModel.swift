//
//  DetailViewModel.swift
//  LinguaLeo
//
//  Created by Никита Шляхов on 02.08.2023.
//

import UIKit

struct DetailViewModel: Hashable {
	var title: String?
	var description: String?
}

extension DetailViewModel {
	init(_ model: PlayerStatisticsModel) {
		title = model.player.name
		description = "\(model.playerInfo.score) scores"
	}
}
