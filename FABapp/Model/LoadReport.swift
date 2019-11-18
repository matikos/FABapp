//
//  LoadReport.swift
//  FABapp
//
//  Created by Your Host on 11/18/19.
//  Copyright © 2019 Mati Kos. All rights reserved.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case otherProblem
}

struct LoadReport {
    let reportURL: URL
    
    init (_ querry: TimeInterval) {
        let reportString = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats?event=load&data=\(Int(querry * 1000))"
        guard let reportURL = URL(string: reportString) else {fatalError()}
        self.reportURL = reportURL
        print(reportString)
    }
    func report (complietion: @escaping(Result<String, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: reportURL)
            urlRequest.httpMethod = "GET"
            let dataTask = URLSession.shared.dataTask(with: urlRequest) {_, response, error in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    complietion(.failure(.responseProblem))
                    return
                }
            }
            dataTask.resume()
            
        }
    }
}
