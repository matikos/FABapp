//
//  FruitViewController.swift
//  FABapp
//
//  Created by Your Host on 11/15/19.
//  Copyright © 2019 Mati Kos. All rights reserved.
//

import UIKit


class FruitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var fruitList: UITableView!
    
    var listOfFruits = [Fruit]() {
        
        didSet {
            DispatchQueue.main.async {
                self.fruitList.reloadData()
            }
        }
    }
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fruitList.dataSource = self
        let fruitManager = FruitManager()
        fruitManager.performRequest {[weak self] result in
            switch result{
            case .failure(let error):
                print(error)
                print("Hello, Line 34.")
            case .success(let fruits):
                self?.listOfFruits = fruits
                print("Hello, Line 37.")
            }
        }
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to reload from API")
        refresher.addTarget(self, action: #selector(FruitViewController.invokeReload), for: UIControl.Event.valueChanged)
        fruitList.addSubview(refresher)
    }
    
    @objc func invokeReload () {
        let fruitManager = FruitManager()
        fruitManager.performRequest {[weak self] result in
            switch result{
            case .failure(let error):
                print(error)
                print("error on line 89.")
            case .success(let fruits):
                self?.listOfFruits = fruits
                print("success on line 92.")
            }
        }
        fruitList.reloadData()
        refresher.endRefreshing()
    }
    
    //MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfFruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        cell.textLabel?.text = listOfFruits[indexPath.row].type
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // fruitList.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? DetailViewController {
            dvc.type = listOfFruits[(fruitList.indexPathForSelectedRow?.row)!].type
            dvc.price = "\(listOfFruits[(fruitList.indexPathForSelectedRow?.row)!].price / 100)"
            dvc.weight = "\(listOfFruits[(fruitList.indexPathForSelectedRow?.row)!].weight / 100)"
        }
        
    }
    
    
    
}


