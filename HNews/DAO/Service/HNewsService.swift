//
//  HNewsService.swift
//  HNews
//
//  Created by Edu on 03/02/21.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON

class HNewsService: BaseService {
    
    //Observation: Just because the application is quite simple, this class is very simple, but otherwise it would be very complete and configurable.
    
    //MARK: Get HNews List
    func getHNewsList() -> Promise<ResponseHNewsList> {
        
        let mJSON = [
            "query" : "mobile"
        ]
        
        let mRequest = APIRequest.shared.makeRequest(resourceIn: APIResource.getHNewsByDate, typeIn: ResponseHNewsList.self, parametersIn: mJSON, encodingIn: .httpBody, headersIn: self.buildHeaders())
        
        return self.excRequest(requestIn: mRequest)
    }
}
