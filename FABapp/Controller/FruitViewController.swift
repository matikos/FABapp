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
        var fruitManager = FruitManager()
        fruitManager.performRequest {[weak self] result in
            switch result{
            case .failure(let error):
                print(error)
                print("error loading data on line 34")
            case .success(let fruits):
                self?.listOfFruits = fruits
                print("success loading data on line 37")
            }
            let loadReport = LoadReport(fruitManager.timeQuerry)
            loadReport.report { result in
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let success):
                    print(success)
                }
            }
        }

        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to reload from API")
        refresher.addTarget(self, action: #selector(FruitViewController.invokeReload), for: UIControl.Event.valueChanged)
        fruitList.addSubview(refresher)
    }
         //MARK: - Refresher
    @objc func invokeReload () {
        var fruitManager = FruitManager()
        fruitManager.performRequest {[weak self] result in
            switch result{
            case .failure(let error):
                print(error)
                print("error  with refresh on line 62.")
            case .success(let fruits):
                self?.listOfFruits = fruits
                print("success with refresh on line 65.")
            }
        }
        let loadReport = LoadReport(fruitManager.timeQuerry)
        loadReport.report { result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let success):
                print(success)
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
        
        cell.accessoryType = .disclosureIndicator
        
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
