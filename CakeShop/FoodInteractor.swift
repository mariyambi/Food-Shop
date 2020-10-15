//
//  CakeMenuInteractor.swift
//  CakeShop
//
//  Created by Mariyambi on 13/10/20.
//  Copyright © 2020 YaraTech. All rights reserved.
//

import Foundation
protocol CategoriesDelegate {
    func fetchedAllCategories(foodCategoryList:[FoodCategory])
    func showError(message:String)
    func fetchFoodByCategory(foodList:[Food])
}
class FoodInteractor{
    
    
    var delegate:CategoriesDelegate? = nil
    
    func fetchFoodPerCategory(categoryID:Int){
        let apiManager = ApiManager()
        apiManager.responseHandler = {data,error in
            
            if error == nil{
                
                if let responseData = data{
                    let decoder = JSONDecoder()
                    
                    if let response = try? decoder.decode(FoodByCategoriesResponse.self, from: responseData){
                       
                        if response.data?.count ?? 0 > 0{
                            
                            self.delegate?.fetchFoodByCategory(foodList: response.data!)
                        }else{
                            self.delegate?.showError(message: "No data found")
                        }
                        
                        
                    }else{
                       self.delegate?.showError(message: "Sorry! Something went wrong")
                    }
                }else{
                   self.delegate?.showError(message: "Sorry! Something went wrong")
                }
                
            }else{
                self.delegate?.showError(message: "No data found")
            }
            
        }
        apiManager.fetchCakesInCategory(categoryID: categoryID)
    }
    
    
    func fetchAllCatogaries(){
        let apiManager = ApiManager()
        apiManager.responseHandler = {data,error in
            
            if error == nil{
                if let responseData = data{
                    let decoder = JSONDecoder()
                    
                    if let response = try? decoder.decode(CategoriesResponse.self, from: responseData){
                        if response.data?.count ?? 0 > 0 {
                             self.delegate?.fetchedAllCategories(foodCategoryList: response.data!)
                        }else{
                          self.delegate?.showError(message: "Sorry! No categories found")
                        }
                       
                        
                    }else{
                         self.delegate?.showError(message: "Sorry! Something went wrong")
                    }
                    
                }else{
                     self.delegate?.showError(message: "Sorry! Something went wrong")
                }
               
                
            }else{
                self.delegate?.showError(message: "Sorry! No categories found")
            }
            
        }
        apiManager.fetchAllCategories()
    }
}
