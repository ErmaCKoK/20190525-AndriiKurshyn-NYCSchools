//
//  UIViewController+Alert.swift
//  20190525-AndriiKurshyn-NYCSchools
//
//  Created by Andrii Kurshyn on 5/26/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(with error: Error) {
        let message = (error as NSError).localizedDescription
        let ac = UIAlertController(title: "Ooops!", message:message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
    
}
