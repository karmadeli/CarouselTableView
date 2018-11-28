//
//  CarouselViewModel.swift
//
//  Created by Chad Murdock on 10/27/18.
//  Copyright © 2018 KarmaDeli Works. All rights reserved.
//

import Foundation
import UIKit

class CarouselViewModel{
    
    var dataSource = [Section]()
    let dispatchGroup = DispatchGroup()
    
    func setLogo(navItem: UINavigationItem){
        let logo = UIImage(named: "shudderLogo")
        let titleImageView  = UIImageView(image: logo)
        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 54)
        navItem.titleView = titleImageView
    }
    
    func makeQuery(for searchTerm: String){
        self.dispatchGroup.enter()
        ImageClient.fetchImage(for: searchTerm) {[weak self] (section) in
            self?.dataSource.append(section)
            self?.dispatchGroup.leave()
        }
    }
    
}






















