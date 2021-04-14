//
//  GetMoviesRequest.swift
//  Movies
//
//  Created by Lucas Brandão on 26/01/21.
//

import Foundation

enum SearchType{
    case advanced
    case byTitle
}

class GetMoviesRequest: Request{
    
    init(genres: [String]? = [],  type: SearchType,  title: String? = "") {
        switch type {
        case .advanced:
            if let genres = genres{
                var a = "/advancedsearch?genre="
                for (i,genre) in genres.enumerated(){
                    if i == 0{
                        a.append(genre)
                    }
                    else{
                        a.append(",\(genre)")
                    }
                }
                params.append(a)
            }
        case .byTitle:
            params.append("/search?title=\(title ?? "")")
        }

    }
    var params = ""
    var endpoint: String{
            return APIConstants.baseEndpoint + "\(params)"
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
