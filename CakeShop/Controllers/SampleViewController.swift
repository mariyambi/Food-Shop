//
//  SampleViewController.swift
//  CakeShop
//
//  Created by Mariyambi on 14/10/20.
//  Copyright © 2020 YaraTech. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController, CategoriesDelegate {
    func fetchFoodByCategory(foodList: [Food]) {
        self.foodList = foodList
        self.removeLoadingIndicator()
        self.foodCollectionView.reloadData()
    }
    
    func fetchedAllCategories(foodCategoryList: [FoodCategory]) {
        
    }
    
    func showError(message: String) {
        self.removeLoadingIndicator()
        self.showAlert(title: "Error", message: message)
    }
    
    
    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    
    var foodList = [Food]()
    var category: FoodCategory? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let interactor = FoodInteractor()
        interactor.delegate = self
       
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        
        
        self.addLoadingIndicator("")

        interactor.fetchFoodPerCategory(categoryID: (category?.id)!)
        navigationItem.title = "Food menu"
        navigationController?.navigationBar.barTintColor = .red
        navigationItem.titleView?.backgroundColor = .white
        
    }
    

    
}

extension SampleViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCollectionViewCell
        
        cell.populateUi(food: foodList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
           
           let width = (collectionView.frame.size.width/2) - 5
        return CGSize(width: width, height: 200.0)
            
           
       }
    
}
