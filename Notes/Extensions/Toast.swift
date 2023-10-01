//
//  Toast.swift
//  Notes
//
//  Created by Victor Peralta on 30/09/23.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message: String, duration: TimeInterval = 2.0) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.view.alpha = 0.7
        alertController.view.layer.cornerRadius = 15
        
        self.present(alertController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
}
