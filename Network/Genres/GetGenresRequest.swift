//
//  GetGenresRequest.swift
//  Movies
//
//  Created by Lucas Brandão on 25/01/21.
//

import Foundation

class GetGenresRequest: Request{
    var endpoint: String{
        return APIConstants.baseEndpoint + "/getParams?param=genre"
    }

    var method: HTTPMethod = .get
    var headers: [String : String]{
        var dic = [
        "x-rapidapi-host" : "ott-details.p.rapidapi.com",
        "useQueryString" : "true"
        ]
        dic.updateValue(APIConstants.token, forKey: "x-rapidapi-key")
        return dic
    }
}
