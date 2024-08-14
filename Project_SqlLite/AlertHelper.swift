//
//  AlertHelper.swift
//  Project_SqlLite
//
//  Created by Tanmay N Gandhi on 13/08/24.
//


import UIKit

class AlertHelper {
    static func showAlert(on viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
