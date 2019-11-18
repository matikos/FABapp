//
//  FruitManager.swift
//  FABapp
//
//  Created by Your Host on 11/14/19.
//  Copyright © 2019 Mati Kos. All rights reserved.
//

import Foundation

enum FruitError: Error {
    case noDataAvailable
    case canNotProccessData
}

struct FruitManager {
    
    let fruitURL: URL
    
    init() {
        let fruitString = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json"
        guard let fruitURL = URL(string: fruitString) else {fatalError()}
        self.fruitURL = fruitURL
    }
    
    
    
    func performRequest(completion: @escaping(Result<[Fruit], FruitError>)-> Void) {
        let dataTask = URLSession.shared.dataTask(with: fruitURL) {data,_,_ in
            
            guard let safeData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(FruitData.self, from: safeData)
                let decodedFruit = decodedData.fruit
                
                completion(.success(decodedFruit))
                print ("success on line 42")
            } catch {
                completion(.failure(.canNotProccessData))
                print("error on line 45")
            }
        }
        dataTask.resume()
    }
}
