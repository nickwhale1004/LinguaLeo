//
//  DetailTableViewCell.swift
//  LinguaLeo
//
//  Created by Никита Шляхов on 02.08.2023.
//

import UIKit

final class DetailTableViewCell: UITableViewCell {
	
	// MARK: - Subviews
	
	private lazy var lblTitle: UILabel = {
		let lbl = UILabel()
		lbl.font = .boldSystemFont(ofSize: 17)
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	
	private lazy var lblDescription: UILabel = {
		let lbl = UILabel()
		lbl.textAlignment = .right
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
	
	func configure(_ viewModel: DetailViewModel) {
		lblTitle.text = viewModel.title
		lblDescription.text = viewModel.description
	}
	
	private func setupUI() {
		selectionStyle = .none
		contentView.addSubview(lblDescription)
		contentView.addSubview(lblTitle)
	}
	
	private func setupConstraints() {
		let constraints = [
			NSLayoutConstraint(item: lblTitle, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leadingMargin, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: lblTitle, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0),
			
			NSLayoutConstraint(item: lblDescription, attribute: .leading, relatedBy: .equal, toItem: lblTitle, attribute: .trailing, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: lblDescription, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .topMargin, multiplier: 1, constant: 0),
			NSLayoutConstraint(item: lblDescription, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1, constant: 0),
		]
		contentView.addConstraints(constraints)
		NSLayoutConstraint.activate(constraints)
	}
}
