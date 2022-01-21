//
//  UIView+.swift
//  RxMoya+MVVM
//
//  Created by Wody on 2022/01/19.
//

import Foundation
import UIKit

extension UIView {
  
  // Nib이 Bundle에 있는지 확인
  static var isExistNibFile: Bool {
    let identifier = String(describing: self)
    return Bundle.main.path(forResource: identifier, ofType: "nib") != nil
  }
}
