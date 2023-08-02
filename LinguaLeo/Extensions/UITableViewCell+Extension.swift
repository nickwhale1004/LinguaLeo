//
//  UITableViewCell+Extension.swift
//  LinguaLeo
//
//  Created by Никита Шляхов on 02.08.2023.
//

import UIKit

extension UITableViewCell {
	static var id: String {
		String(describing: self) + "ID"
	}
}
