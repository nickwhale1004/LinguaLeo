//
//  NSDiffableDataSourceSnapshot+Extension.swift
//  LinguaLeo
//
//  Created by Никита Шляхов on 02.08.2023.
//
import UIKit

typealias Snapshot<Section: Hashable, Row: Hashable> = NSDiffableDataSourceSnapshot<Section, Row>
typealias TableDataSource<Section: Hashable, Row: Hashable> = UITableViewDiffableDataSource<Section, Row>
