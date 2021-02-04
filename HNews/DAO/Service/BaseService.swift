//
//  BaseService.swift
//  HNews
//
//  Created by Edu on 03/02/21.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

class BaseService {
    
    //MARK: Build Headers
    func buildHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        return headers
    }
    
    //MARK: Base Request
    func excRequest<T: Codable>(requestIn: Promise<T>) -> Promise<T> {
        return Promise { seal in
            requestIn.done{ response in
                seal.fulfill(response)
            }.catch{ error in
                return seal.reject(error)
            }
        }
    }
}

extension JSON {
    
    func makeJSONDecode<T: Codable>(_ typeIn: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode(typeIn, from: self.rawData(options: .fragmentsAllowed))
        } catch {
            return nil
        }
    }
}

extension Dictionary {
    
    func makeObjectDecode<T: Codable>(_ typeIn: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode(typeIn, from: JSONSerialization.data(withJSONObject: self, options: .prettyPrinted))
        } catch {
            return nil
        }
    }
}
