//
//  StarModel.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/02/22.
//

import Foundation

class StarModel: NSObject{
    // Properties (Java의 field)
    var user_userEmail: String?
    var address_addressNo: Int?
    var addressName: String?
    var addressPhone: String?
    var addressEmail: String?
    var addressText: String?
    var addressBirth: String?
    var addressImage: String?
    
    // Empty constructor
    override init() {
        
    }
    
    // constructor
    init(user_userEmail: String, address_addressNo: Int) {
        self.user_userEmail = user_userEmail
        self.address_addressNo = address_addressNo
    }
    
   
}
