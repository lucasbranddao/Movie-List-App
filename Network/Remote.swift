//
//  Remote.swift
//  Movies
//
//  Created by Lucas Brandão on 25/01/21.
//

import Foundation


struct Remote {
    static func makeRequest<T: Decodable>(request: Request, completionHandler: @escaping (T?, _ errorMessage: String?) -> Void) {
        Network.request(request: request, completionHandler: { response in
            guard let data = response.data  else {
                completionHandler(nil, response.error?.localizedDescription)
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completionHandler(object, nil)
            } catch let error {
                print(error)
                completionHandler(nil, "Não foi possível obter dados do usuário")
            }
        })
    }
}
