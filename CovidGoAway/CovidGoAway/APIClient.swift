//
//  APIClient.swift
//  CovidGoAway
//
//  Created by Kelby Mittan on 12/11/20.
//

import Foundation

struct APIClient {
    
    public func fetchAllData(completion: @escaping (Result<[CovidDataWrapper],Error>) -> ()) {
        let endpoint = "https://corona.lmao.ninja/v2/countries?sort=country"
        guard let url = URL(string: endpoint) else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let results = try JSONDecoder().decode([CovidDataWrapper].self, from: data)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
}
