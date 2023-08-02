//
//  PlayerStatisticsModel.swift
//  LinguaLeo
//
//  Created by Никита Шляхов on 02.08.2023.
//

import Foundation

struct PlayerStatisticsModel: Codable, Hashable {
	var player: PlayerModel
	var playerInfo: PlayerInfoModel
}
