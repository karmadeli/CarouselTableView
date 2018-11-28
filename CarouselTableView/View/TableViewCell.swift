//
//  TableViewCell.swift
//  AMCCodingChallenge
//
//  Created by Chad Murdock on 10/26/18.
//  Copyright © 2018 KarmaDeli Works. All rights reserved.
//

import UIKit

protocol someProto{
    func setup(dataSource: UICollectionViewDelegate & UICollectionViewDataSource, section: Int)
}


class TableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: someProto?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        
     }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension TableViewCell {
    
    //Set vc as datasource and delegate for collectionView property
    
    func setupCollectionViewDataSourceDelegate(vc: ViewController, section: Int){
        delegate?.setup(dataSource: vc, section: section)
        collectionView.delegate = vc
        collectionView.dataSource = vc
        collectionView.tag = section
        collectionView.reloadData()
    }
   
}
