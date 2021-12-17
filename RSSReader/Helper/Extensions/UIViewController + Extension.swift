//
//  UIViewController + Extension.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 17.12.2021..
//

import Foundation
import UIKit

extension UIViewController {

  func presentAlert(withTitle title: String, message : String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)

    alertController.addAction(action)

    self.present(alertController, animated: true, completion: nil)
  }
}
