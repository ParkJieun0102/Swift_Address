//
//  AddressModel.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/02/17.
//

import Foundation

// Java의 Bean -> Address
class AddressModel: NSObject{
    // Properties (Java의 field)
    var addressNo: Int?
    var addressName: String?
    var addressPhone: String?
    var addressEmail: String?
    var addressText: String?
    var addressBirth: String?
    var addressStar: String?
    var addressImage: String?
    
    // Empty constructor
    override init() {
        
    }
    
    // constructor
    init(addressNo: Int, addressName: String, addressPhone: String, addressEmail: String, addressText: String, addressBirth:String, addressStar:String, addressImage:String) {
        self.addressNo = addressNo
        self.addressName = addressName
        self.addressPhone = addressPhone
        self.addressEmail = addressEmail
        self.addressText = addressText
        self.addressBirth = addressBirth
        self.addressStar = addressStar
        self.addressImage = addressImage
    }
    
    // constructor
    init(addressNo: Int, addressName: String, addressPhone: String, addressEmail: String, addressText: String, addressBirth:String, addressImage:String) {
        self.addressNo = addressNo
        self.addressName = addressName
        self.addressPhone = addressPhone
        self.addressEmail = addressEmail
        self.addressText = addressText
        self.addressBirth = addressBirth
        self.addressImage = addressImage
    }
}
