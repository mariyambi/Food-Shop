//
//  UISimpleSlidingTabController.swift
//  CakeShop
//
//  Created by Mariyambi on 14/10/20.
//  Copyright © 2020 YaraTech. All rights reserved.
//

import UIKit

class UISimpleSlidingTabController: UIViewController {

    private let collectionHeader = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        private let collectionPage = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        private let collectionHeaderIdentifier = "COLLECTION_HEADER_IDENTIFIER"
        private let collectionPageIdentifier = "COLLECTION_PAGE_IDENTIFIER"
        private var items = [UIViewController]()
        private var titles = [String]()
        private var colorHeaderActive = UIColor.black
        private var colorHeaderInActive = UIColor.gray
        private var colorHeaderBackground = UIColor.white
        private var currentPosition = 0
    private var tabStyle = SlidingTabStyle.fixed
        private let heightHeader = 50
        
        private static let titleFont = UIFont.boldSystemFont(ofSize: 16)
        
        func addItem(item: UIViewController, title: String){
            items.append(item)
            titles.append(title)
        }
        
        func setHeaderBackgroundColor(color: UIColor){
            colorHeaderBackground = color
        }
        
        func setHeaderActiveColor(color: UIColor){
            colorHeaderActive = color
        }
        
        func setHeaderInActiveColor(color: UIColor){
            colorHeaderInActive = color
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
        }
        func setCurrentPosition(position: Int){
            currentPosition = position
            let path = IndexPath(item: currentPosition, section: 0)
            
            DispatchQueue.main.async {
                if self.tabStyle == .flexible {
                    self.collectionHeader.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
                }
                
                self.collectionHeader.reloadData()
            }
            
            DispatchQueue.main.async {
               self.collectionPage.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
            }
        }
        
        func setStyle(style: SlidingTabStyle){
            tabStyle = style
        }
        
        func getCurrentIndex () -> Int{
            currentPosition
        }
        func getViewController(at: Int) -> UIViewController{
            items[at]
        }
        func build(){
            // view
            view.addSubview(collectionHeader)
            view.addSubview(collectionPage)
            
            // collectionHeader
            collectionHeader.translatesAutoresizingMaskIntoConstraints = false
//            collectionHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            
            collectionHeader.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant:10).isActive = true
            
           
            collectionHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0).isActive = true
            collectionHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0).isActive = true
            collectionHeader.heightAnchor.constraint(equalToConstant: CGFloat(heightHeader)).isActive = true
            (collectionHeader.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
            collectionHeader.showsHorizontalScrollIndicator = false
            collectionHeader.backgroundColor = .white//colorHeaderBackground
            collectionHeader.register(HeaderCell.self, forCellWithReuseIdentifier: collectionHeaderIdentifier)
            collectionHeader.delegate = self
            collectionHeader.dataSource = self
            collectionHeader.reloadData()
            
            let layout = collectionHeader.collectionViewLayout as! UICollectionViewFlowLayout
            layout.minimumInteritemSpacing = 10
            
            // collectionPage
            collectionPage.translatesAutoresizingMaskIntoConstraints = false
            collectionPage.topAnchor.constraint(equalTo: collectionHeader.bottomAnchor).isActive = true
            collectionPage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            collectionPage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            collectionPage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            collectionPage.backgroundColor = .clear
            collectionPage.showsHorizontalScrollIndicator = false
            (collectionPage.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
            collectionPage.isPagingEnabled = true
            collectionPage.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionPageIdentifier)
            collectionPage.delegate = self
            collectionPage.dataSource = self
            collectionPage.reloadData()
        }
        
        private class HeaderCell: UICollectionViewCell {
            
            private let label = UILabel()
            private let indicator = UIView()
        
            
            var text: String! {
                didSet {
                    label.text = text
                }
            }
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                setupUI()
            }
            
            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            func select(didSelect: Bool, activeColor: UIColor, inActiveColor: UIColor){
                indicator.backgroundColor = activeColor
                
                if didSelect {
                    label.textColor = activeColor
                    indicator.isHidden = false
                    self.contentView.backgroundColor = .red
                }else{
                    label.textColor = inActiveColor
                    indicator.isHidden = true
                    self.contentView.backgroundColor = .white
                }
            }
            
            private func setupUI(){
                // view
                self.addSubview(label)
                self.addSubview(indicator)
                
                // label
                label.translatesAutoresizingMaskIntoConstraints = false
                label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
                label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                label.font = titleFont
                
                // indicator
                indicator.translatesAutoresizingMaskIntoConstraints = false
                indicator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                indicator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                indicator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                indicator.heightAnchor.constraint(equalToConstant: 4).isActive = true
                
                self.contentView.backgroundColor = .red
                
                self.contentView.setCardView()
            
            }
            
        }
        
    }

    extension UISimpleSlidingTabController: UICollectionViewDelegate{
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            setCurrentPosition(position: indexPath.row)
            if let delegate = getViewController(at: currentPosition) as? SlidingTabDelegate{
                delegate.reloadPage()
            }
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            if scrollView == collectionPage{
                let currentIndex = Int(self.collectionPage.contentOffset.x / collectionPage.frame.size.width)
                setCurrentPosition(position: currentIndex)
                if let delegate = getViewController(at: currentPosition) as? SlidingTabDelegate{
                     delegate.reloadPage()
                }
            }
        }
    }

    extension UISimpleSlidingTabController: UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == collectionHeader {
                return titles.count
            }
            
            return items.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == collectionHeader {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionHeaderIdentifier, for: indexPath) as! HeaderCell
                cell.text = titles[indexPath.row]
                
                var didSelect = false
                
                if currentPosition == indexPath.row {
                    didSelect = true
                }
                
                cell.select(didSelect: didSelect, activeColor: colorHeaderActive, inActiveColor:colorHeaderInActive)
                
                return cell
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionPageIdentifier, for: indexPath)
            let vc = items[indexPath.row]
            
            cell.addSubview(vc.view)
            
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.view.topAnchor.constraint(equalTo: cell.topAnchor, constant: CGFloat(25)).isActive = true
            vc.view.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
            
            return cell
        }
    }

    extension UISimpleSlidingTabController: UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == collectionHeader {
                if tabStyle == .fixed {
                    let spacer = CGFloat(titles.count)
                    return CGSize(width: view.frame.width / spacer, height: CGFloat(heightHeader))
                }else{
                    let width = titles[indexPath.row].widthOfString(usingFont: UISimpleSlidingTabController.titleFont) + 20
                    return CGSize(width: width, height: CGFloat(heightHeader))
                }
            }
            
            return CGSize(width: view.frame.width, height: view.frame.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            if collectionView == collectionHeader {
                return 10
            }
            
            return 0
        }
    }

    enum SlidingTabStyle: String {
        case fixed
        case flexible
    }
    protocol SlidingTabDelegate {
        func reloadPage()
    }
    extension String{
        func widthOfString(usingFont font: UIFont) -> CGFloat {
                 let fontAttributes = [NSAttributedString.Key.font: font]
                 let size = self.size(withAttributes: fontAttributes)
                 return size.width
             }
    }



