//
//  ApiRequestEndpoints.swift
//  SevenPeaksTask
//
//  Created by Adinarayana Machavarapu on 23/10/21.
//

import Foundation
import NetworkManager

let baseUrl = "https://www.apphusetreach.no/application/119267"

enum ApiRequestEndpoints: EndpointProtocol {
    case getCarsList
  
    var defaultHeaders: HTTPHeaders {
        var httpHeaders : [String:String] = [:]
        httpHeaders = ["Content-Type": "application/json"]
        return httpHeaders
    }
    
    var baseURL: URL {
        return URL(string:baseUrl)!
    }

    public var path: String {
        switch self {
        case .getCarsList:
            return "/article/get_articles_list"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getCarsList:
            return .get
        }
    }

     var task: HTTPTask {
        switch self {
        case .getCarsList:
            return .requestPlain
        }
    }

    public var headers: HTTPHeaders? {
        return defaultHeaders
    }
}
