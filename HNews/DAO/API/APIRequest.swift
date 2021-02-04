//
//  APIRequest.swift
//  HNews
//
//  Created by Edu on 03/02/21.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON

enum RequestError: Error {
    case APIError(String)
    case UNError
    case ErrorParsing
}

class APIRequest: NSObject {
    
    //MARK: Shared Instance
    static let shared = APIRequest()
    
    //MARK: Main Make Request Method
    func makeRequest<T: Codable>(resourceIn: APIResource, typeIn: T.Type, parametersIn: Parameters? = nil, encodingIn: URLEncoding? = nil, headersIn: HTTPHeaders? = nil) -> Promise<T> {
        
        guard let mURL = resourceIn.mBaseURL?.appendingPathComponent(resourceIn.mWSName) else { return Promise { seal in seal.reject(RequestError.UNError)} }
        var mainRequest: DataRequest!
        mainRequest = AF.request(mURL, method: resourceIn.method, parameters: parametersIn, headers: headersIn)
        
        return Promise { seal in
            mainRequest
                .validate()
                .responseJSON(queue: DispatchQueue.global(qos: .userInitiated)) { response in
                    print(response)
                    guard let dataResponse = response.data else { return seal.reject(RequestError.UNError) }
                    
                    if let dataResult = self.makeDecode(typeIn, dataResponse) {
                        self.mLog("MAIN API RESPONSE: ", dataResult)
                        return seal.fulfill(dataResult)
                    }else{
                        return seal.reject(RequestError.UNError)
                    }
            }
        }
    }
    
    //MARK: Private Methods for Decoder Data
    private func makeDecode<T: Codable>(_ typeIn: T.Type, _ dataIn: Data) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode(typeIn, from: dataIn)
        } catch {
            return makeDecodeWithFragments(dataIn)
        }
    }
    
    private func makeDecodeWithFragments<T: Codable>(_ dataIn: Data) -> T? {
        do {
            return try JSONSerialization.jsonObject(with: dataIn, options: .allowFragments) as? T
        } catch {
            return nil
        }
    }
    
    private func makeParamsJSONSerialization(paramsIn: Parameters?) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: paramsIn ?? [], options: JSONSerialization.WritingOptions(rawValue: 0))
        } catch  {
            return nil
        }
    }
}
