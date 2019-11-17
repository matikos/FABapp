//
//  FruitData.swift
//  FABapp
//
//  Created by Your Host on 11/14/19.
//  Copyright © 2019 Mati Kos. All rights reserved.
//

import Foundation

struct FruitData: Decodable {
    let fruit: [Fruit]
}

struct Fruit: Decodable {
    let type: String
    let price: Float
    let weight: Float
}
