//
//  ButtonTableViewCell.swift
//  LinguaLeo
//
//  Created by Никита Шляхов on 03.08.2023.
//

import UIKit

final class ButtonTableViewCell: UITableViewCell {
	
	// MARK: - Subviews
	
	private lazy var lblTitle: UILabel = {
		let lbl = UILabel()
		lbl.font = .boldSystemFont(ofSize: 17)
		lbl.textColor = .white
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	
	// MARK: - Initialization
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Methods
	
	func configure(_ title: String?) {
		lblTitle.text = title
	}
	
	private func setupUI() {
		selectionStyle = .none
		contentView.backgroundColor = .black
		contentView.addSubview(lblTitle)
	}
	
	private func setupConstraints() {
		let constraints = [
			NSLayoutConstraint(item: lblTitle, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: lblTitle, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0),
		]
		contentView.addConstraints(constraints)
		NSLayoutConstraint.activate(constraints)
	}
}
