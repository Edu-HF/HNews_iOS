//
//  APIResource.swift
//  HNews
//
//  Created by Edu on 03/02/21.
//

import Foundation
import Alamofire

//MARK: Protocols
protocol EndPointType {
    var mBaseURL: URL? { get }
    var mWSName: String { get }
}

//MARK: Structs
struct APIError: Codable {
    let onSuccess: Bool
    let onError: APIErrorDetail
}

struct APIErrorDetail: Codable {
    let message, name: String
    let code: Int
}

//MARK: Enums
enum APIResource {
    case getHNewsByDate
}

//MARK: Extension
extension APIResource: EndPointType {
    
    var mBaseURL: URL? {
        let mDict = Bundle.main.infoDictionary
        let mURL = mDict?["MAIN_SERVER_URL"] as? String
        return URL(string: mURL ?? "")
    }
    
    var mWSName: String {
        
        switch self {
            
        case .getHNewsByDate: return "search_by_date"
        
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getHNewsByDate: return .get
        }
    }
}
