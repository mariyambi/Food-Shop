//
//  UIViewControllerExtension.swift
//  CakeShop
//
//  Created by Mariyambi on 15/10/20.
//  Copyright © 2020 YaraTech. All rights reserved.
//

import Foundation
import  UIKit
import SVProgressHUD

extension UIViewController{
    func addLoadingIndicator(_ message: String?){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.150, execute: {
            // MBProgressHUD.showAdded(to: self.view, animated: true)
                   SVProgressHUD.setMinimumSize(CGSize(width: 250.0, height: 150.0))
                   SVProgressHUD.setDefaultMaskType(.black)
                   SVProgressHUD.show(withStatus: message)
        })
       
    }
    
    func removeLoadingIndicator(){
        //MBProgressHUD.hide(for: self.view, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.150, execute: {
            SVProgressHUD.dismiss()
        })
        
    }

    func showAlert(title: String?, message: String?, handler: (()->Void)? = nil) {
               let alerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
               let cancelAction = UIAlertAction(title: "OK", style: .cancel){ alertAction in
                   if let safeHandler = handler{
                       safeHandler()
                   }
               }
               alerController.addAction(cancelAction)
               present(alerController, animated: true, completion: nil)
    }
}
