//
//  NetworkService.swift
//  Fetch
//
//  Created by Ahmed Buttar on 6/9/24.
//

import Foundation
import Combine

// TODO: make generic network service in future

struct Response {
    
    var data: Data?
    
    init(data: Data?) {
        self.data = data
    }
}

protocol NetworkServiceProtocol {
    func request(request: URLRequest) -> AnyPublisher<Response, Error>
}

class NetworkService: NetworkServiceProtocol {
    
    let session: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    func request(request: URLRequest) -> AnyPublisher<Response, Error> {
        return Future<Response, Error> { [weak self] promise in
            guard let self = self else { return }
            let dataTask = self.session.dataTask(with: request) { data, response, error in
                if let httpReponse = response as? HTTPURLResponse {
                    switch httpReponse.statusCode {
                    case 200...300:
                        promise(.success(Response(data: data)))
                    default:
                        print("error")
                    }
                }
                
                if let error = error {
                    promise(.failure(error))
                }
            }
            dataTask.resume()
        }
        .eraseToAnyPublisher()
    }
    
    
}
