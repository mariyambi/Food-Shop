//
//  ApiManager.swift
//  CakeShop
//
//  Created by Mariyambi on 13/10/20.
//  Copyright © 2020 YaraTech. All rights reserved.
//

import Foundation
class ApiManager{
    
    
    var responseHandler : ((_ data:Data?, _ error: Error?) -> Void)? = nil
    
    func fetchAllCategories(){
        makeGetRequest(url: ApiConstants.categories)
    }
    
    func fetchCakesInCategory(categoryID:Int){
        makeGetRequest(url: "\(ApiConstants.listCakeByCategory)\(categoryID)")
    }
    
    private func makeGetRequest(url:String){
        
        let components = URLComponents(string: url)!
        
        let request = URLRequest(url: components.url!)
        
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error in
            
            DispatchQueue.main.asyncAfter(deadline: .now(), execute:{
                    if self.responseHandler != nil{
                        self.responseHandler!(data, error)
                    }
            })
            
        })
        
        task.resume()
        
    }
    
}
