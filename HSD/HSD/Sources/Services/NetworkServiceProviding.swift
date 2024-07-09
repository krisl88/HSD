//
//  NetworkServiceProviding.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import Foundation

protocol NetworkServiceProviding {

    func request<T: Decodable>(
        _ request: URLRequest,
        params: [AnyHashable: Any]?,
        completion: @escaping APICallback<T>
    )
}

final class NetworkServiceProvider: NetworkServiceProviding {
    
    private let session = URLSession.shared
    
    func request<T: Decodable>(
        _ request: URLRequest,
        params: [AnyHashable: Any]? = nil,
        completion: @escaping APICallback<T>
    ) {
        let task = session.dataTask(with: request,
                                    completionHandler: { data, response, error in
            
            guard let data = data else {
                completion(.failure(.networkError(error)))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode(T.self, from: data)
                completion(.success(decoded))
            }
            catch {
                completion(.failure(APIError.unableToDecode))
            }
        })
        
        // [KL]: can add this to a queue or limit concurrent requests
        task.resume()
    }
}

