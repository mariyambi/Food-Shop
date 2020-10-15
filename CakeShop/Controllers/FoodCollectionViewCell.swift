//
//  FoodCollectionViewCell.swift
//  CakeShop
//
//  Created by Mariyambi on 14/10/20.
//  Copyright © 2020 YaraTech. All rights reserved.
//

import UIKit
import Kingfisher


class FoodCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    
    
    func populateUi(food: Food){
        titlelabel.text = food.title
        
        rootView.setCardView()
        if  let url = URL(string : "\(ApiConstants.imageForFood)\(food.image ?? "")"){
             
            imageView.kf.setImage(with: url,
                                   placeholder: nil,
                                   options: [.transition(ImageTransition.fade(1))])
            
        }
    }
}
