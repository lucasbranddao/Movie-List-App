//
//  Network.swift
//  Movies
//
//  Created by Lucas Brandão on 25/01/21.
//

import Foundation

struct Network {
        
    static func request(request: Request, completionHandler: @escaping (_ response: Response) -> Void) {
        let urlRequest = request.asURLRequest()!
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let response = Response(data: data, response: response, error: error)
            
            if(error != nil){
              //  print("Erro uploading: \(error!.localizedDescription)")
            }
            
            if let data = data {
                print(String(data: data, encoding: String.Encoding.utf8) ?? "No response !!!!")
            } else {
               // print("Error: \(error?.localizedDescription) !!!!")
            }
            DispatchQueue.main.async() {
                completionHandler(response)
            }
        }
        task.resume()
    }
}
