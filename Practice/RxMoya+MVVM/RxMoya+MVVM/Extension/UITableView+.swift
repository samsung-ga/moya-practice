//
//  UITableView+.swift
//  RxMoya+MVVM
//
//  Created by Wody on 2022/01/19.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type, forIndexPath indexPath: IndexPath) -> T? {
        let cellName = String(describing: cell)
        return self.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? T
    }
    
    func registerCell<T: UITableViewCell>(cell: T.Type) {
        let identifier = String(describing: cell)
        let nib = UINib(nibName: identifier, bundle: nil)
    
        if cell.isExistNibFile { self.register(nib, forCellReuseIdentifier: identifier) }
        else { self.register(cell, forCellReuseIdentifier: identifier) }
    }
}
