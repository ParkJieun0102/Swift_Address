//
//  IDModel.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/03/01.
//

import Foundation

class IDModel: NSObject{
    // Properties (Java의 field)
    var userEmail: String?
    var userName: String?
    var userPhone: String?
    
    // Empty constructor
    override init() {
        
    }
    
    // constructor
    init(userEmail: String) {
        self.userEmail = userEmail
    }
}
