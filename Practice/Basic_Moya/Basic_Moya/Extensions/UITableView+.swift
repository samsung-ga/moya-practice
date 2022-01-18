//
//  UITableView+.swift
//  Basic_Moya
//
//  Created by Wody on 2022/01/18.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type, forIndexPath indexPath: IndexPath) -> T? {
        let cellName = String(describing: cell)
        return self.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? T
    }
  
}
