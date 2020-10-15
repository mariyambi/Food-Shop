//
//  ViewController.swift
//  CakeShop
//
//  Created by Mariyambi on 13/10/20.
//  Copyright © 2020 YaraTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CategoriesDelegate {
    func fetchFoodByCategory(foodList: [Food]) {
        
    }
    
    
    @IBOutlet weak var viewContainer: UIView!
    
    func showError(message: String) {
        self.removeLoadingIndicator()
        self.showAlert(title: "Error", message: message)
       
    }
    
    func fetchedAllCategories(foodCategoryList: [FoodCategory]) {
        
        self.tabs = foodCategoryList
        self.removeLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now(), execute:{
            self.setupUI()
            self.slidingTabController.setCurrentPosition(position: self.selectedIndex)
        })
    }
    
    private let slidingTabController = UISimpleSlidingTabController()
    
    var selectedIndex = 0
    
    var tabs = [FoodCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let interactor = FoodInteractor()
        interactor.delegate = self
        self.addLoadingIndicator("")
        interactor.fetchAllCatogaries()
        
    }
    
    private func setupUI(){
        
        // navigation
        navigationItem.title = "Food Menu"
        navigationController?.navigationBar.barTintColor = .red
        view.backgroundColor = .clear
        viewContainer.addSubview(slidingTabController.view)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        for tab in tabs{
            let vc = storyBoard.instantiateViewController(withIdentifier: "SampleVC") as! SampleViewController
            vc.category = tab
            slidingTabController.addItem(item: vc, title: tab.title ?? "")
            
        }
        
        
        
        
        slidingTabController.setHeaderActiveColor(color: .white)
        slidingTabController.setHeaderInActiveColor(color: .black)
        slidingTabController.setHeaderBackgroundColor(color: .red)
        slidingTabController.setCurrentPosition(position: 0)
        slidingTabController.setStyle(style: .flexible)
        
        slidingTabController.build()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .clear
        
    }
    
}

