//
//  ImageClient.swift
//
//  Created by Chad Murdock on 10/26/18.
//  Copyright © 2018 KarmaDeli Works. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ImageClient{
    
    static func fetchImage(for searchTerm: String, completion: @escaping (Section)->()){
        fetchData(for: searchTerm) { (photoSources) in
            
            let section = Section(title: searchTerm)
            for src in photoSources{
                let url = "https://farm\(src.farmID).staticflickr.com/\(src.serverID)/\(src.id)_\(src.secret).jpg"
                Alamofire.request(url).responseImage(completionHandler: { (response) in
                    if response.result.isSuccess{
                        if let image = response.result.value{

                            section.images.append(image)
                        }
                    }else{
                        print(response.error?.localizedDescription as Any)
                    }
                    if section.images.count == photoSources.count{
                       completion(section)
                    }
                })
            }
        }
    }
    
    static func fetchData(for searchTerm: String, completion: @escaping([FlickrImageSrc])->()){
        let unsignedKey = "dc40d1d9a403bf435d4e3392f166ef83"
        let url = "https://api.flickr.com/services/rest/"
        let searchMethod = "flickr.photos.search"
        let params = ["api_key": unsignedKey, "format" : "json", "tags" : searchTerm, "method": searchMethod, "nojsoncallback":"1", "page":"1", "per_page" : "10"]
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            if response.result.isSuccess{
                
                if let flickrResponse = response.result.value as? [String:Any], let flickrPhotos = flickrResponse["photos"] as? [String:Any], let photoArray = flickrPhotos["photo"] as? [[String:Any]] {
                   
                    var photos = [FlickrImageSrc]()

                    for el in photoArray{
                        let srcInfo = FlickrImageSrc()
                        guard let id = el["id"] as? String else {return}
                        guard let farm = el["farm"] as? Int else {return}
                        guard let secret = el["secret"] as? String else {return}
                        guard let server = el["server"] as? String else {return}

                        srcInfo.farmID = farm
                        srcInfo.id = id
                        srcInfo.secret = secret
                        srcInfo.serverID = server
                        photos.append(srcInfo)
                    }
                    completion(photos)
                  
                }
            }else {print (response.error?.localizedDescription as Any)}
        }
    }
}









