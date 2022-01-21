//
//  TableViewCell.swift
//  RxMoya+MVVM
//
//  Created by Wody on 2022/01/19.
//

import UIKit

class TableViewCell: UITableViewCell {
  var nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 12)
    label.textColor = .black
    return label
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    addSubview(nameLabel)
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      nameLabel.topAnchor.constraint(equalTo: topAnchor),
      nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
}
