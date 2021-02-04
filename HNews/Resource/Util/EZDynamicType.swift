//
//  EZDynamicType.swift
//  HNews
//
//  Created by Edu on 03/02/21.
//

import Foundation

class EZDynamicType<T> {
    
    typealias Listener = (T) -> ()
    private var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bindAndTrigger(_ listenerIn: Listener?) {
        self.listener = listenerIn
        listener?(value)
    }
    
    func bind(_ listenerIn: Listener?) {
        self.listener = listenerIn
    }
    
    init(_ v: T) {
        value = v
    }
    
    func removeBind() {
        self.listener = nil
    }
}
