//
//  ViewController+iCarousel.swift
//
//  Created by Chad Murdock on 10/28/18.
//  Copyright © 2018 KarmaDeli Works. All rights reserved.
//

import Foundation
import UIKit

//MARK: Bonus Points Section
extension ViewController: iCarouselDelegate, iCarouselDataSource{
    
    //MARK: iCarousel DataSource Methods
    func numberOfItems(in carousel: iCarousel) -> Int {
        if !getHeaderViewModel().dataSource.isEmpty{
            return getHeaderViewModel().dataSource[carousel.tag].images.count
        }
        return 0
    }
    
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = headerImageView.layer.cornerRadius
        imageView.clipsToBounds = headerImageView.clipsToBounds
        imageView.frame = headerImageView.frame
        imageView.contentMode = headerImageView.contentMode
        
        if view != nil{
            guard let aImageView = view as? UIImageView else {return imageView}
            imageView = aImageView
        }
        imageView.image = getHeaderViewModel().dataSource[carousel.tag].images[index]
        return imageView
    }
    
    //MARK: iCarousel Delegate Methods
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch option {
        case .spacing:
            return 1.35
        default:
            return value
        }
    }
    
}

