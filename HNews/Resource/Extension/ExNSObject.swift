//
//  ExNSObject.swift
//  HNews
//
//  Created by Edu on 03/02/21.
//

import Foundation

extension NSObject {
    
    func mLog(_ items: Any..., separator: String = " ", terminator: String = "\n", inRelease: Bool = false) {
        
        if inRelease {
            print(items, separator, terminator)
        }else{
            #if DEBUG
            print(items, separator, terminator)
            #endif
        }
    }
    
}
