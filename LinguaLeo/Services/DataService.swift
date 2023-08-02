//
//  DataService.swift
//  LinguaLeo
//
//  Created by Никита Шляхов on 02.08.2023.
//

import Foundation

enum DataServiceError: Error {
	case readFileError
	case parseError
}

protocol DataServiceProtocol {
	func getPlayers(_ completion: @escaping (Result<[PlayerStatisticsModel], DataServiceError>) -> ())
}

final class DataService: DataServiceProtocol {
	func getPlayers(_ completion: @escaping (Result<[PlayerStatisticsModel], DataServiceError>) -> ()) {
		DispatchQueue.global().async {
			do {
				guard
					let fileURL = Bundle.main.url(forResource: "test", withExtension: "json")
				else {
					completion(.failure(.readFileError))
					return
				}
				let data = try Data(contentsOf: fileURL)
				
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let playersData = try decoder.decode([PlayerStatisticsModel].self, from: data)
				
				completion(.success(playersData))
			} catch {
				completion(.failure(.parseError))
			}
		}
	}
}
