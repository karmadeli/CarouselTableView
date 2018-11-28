//
//  ViewController.swift
//
//  Created by Chad Murdock on 10/26/18.
//  Copyright © 2018 KarmaDeli Works. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rotaryView: iCarousel!
    @IBOutlet weak var headerImageView: UIImageView!
    
    //MARK: - Properties
    private let viewModel = CarouselViewModel()
    private let headerViewModel = CarouselViewModel()

    //MARK: - Helper Methods
    func getImages(){
        headerViewModel.makeQuery(for: "Horror Movie Poster")

        viewModel.makeQuery(for: "Ladybugs")
        viewModel.makeQuery(for: "Dogs")
        viewModel.makeQuery(for: "waves")
        
    }
    
    //MARK: - Property Getters
    func getViewModel()->CarouselViewModel{
        return viewModel
    }
   
    func getHeaderViewModel()->CarouselViewModel{
        return headerViewModel
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.setLogo(navItem: navigationItem)
        
        rotaryView.type = .rotary
        rotaryView.isPagingEnabled = true
        
        //tableView.delegate = self
        tableView.dataSource = self
        
        getImages()
        
        headerViewModel.dispatchGroup.notify(queue: .main) {[weak self] in
            self?.rotaryView.reloadData()
        }
        viewModel.dispatchGroup.notify(queue: .main) {[weak self] in
            self?.tableView.reloadData()
            }
        }
    }

extension ViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource{
    //MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return viewModel.dataSource.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return viewModel.dataSource[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TableViewCell else {return UITableViewCell()}
        
        cell.setupCollectionViewDataSourceDelegate(vc: self, section: indexPath.section)
        
        return cell
    }
    
    //MARK: - CollectionView DataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource[collectionView.tag].images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionViewCell else {return UICollectionViewCell()}
        
        let image = viewModel.dataSource[collectionView.tag].images[indexPath.item]
        cell.graphicImage.image = image
    
        return cell
    }
    
}




