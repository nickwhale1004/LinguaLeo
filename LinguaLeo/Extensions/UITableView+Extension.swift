//
//  UITableView+Extension.swift
//  LinguaLeo
//
//  Created by Никита Шляхов on 02.08.2023.
//

import UIKit

extension UITableView {
	func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
		return dequeueReusableCell(withIdentifier: T.id, for: indexPath) as? T ?? T()
	}
	
	func register(_ type: UITableViewCell.Type) {
		register(type, forCellReuseIdentifier: type.id)
	}
}
