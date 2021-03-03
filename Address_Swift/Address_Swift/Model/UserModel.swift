//
//  UserModel.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/02/17.
//

import Foundation

class UserModel: NSObject{
    // Properties (Java의 field)
    var userEmail: String?
    var userPw: String?
    var userName: String?
    var userPhone: String?
    var userDeletedate: String?
    
    // Empty constructor
    override init() {
        
    }
    
    // constructor
    init(userEmail: String, userPw: String) {
        self.userEmail = userEmail
        self.userPw = userPw
    }
    
    // constructor
    init(userEmail: String, userPw: String, userName: String, userPhone: String, userDeletedate:String) {
        self.userEmail = userEmail
        self.userPw = userPw
        self.userName = userName
        self.userPhone = userPhone
        self.userDeletedate = userDeletedate
    }
    
    // constructor
    init(userEmail: String, userPw: String, userName: String, userPhone: String) {
        self.userEmail = userEmail
        self.userPw = userPw
        self.userName = userName
        self.userPhone = userPhone
    }
}
