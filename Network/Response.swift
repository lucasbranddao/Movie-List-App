//
//  Response.swift
//  Movies
//
//  Created by Lucas Brandão on 25/01/21.
//

import Foundation

struct Response {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
}
