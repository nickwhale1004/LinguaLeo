//
//  PlayerModel.swift
//  LinguaLeo
//
//  Created by Никита Шляхов on 02.08.2023.
//

import Foundation

struct PlayerModel: Codable, Hashable {
	var name: String
	var country: String
	var age: Int
}
