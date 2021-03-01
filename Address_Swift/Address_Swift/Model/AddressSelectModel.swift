//
//  AddressSelectModel.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/03/01.
//

import Foundation

protocol AdrSelectJsonModelProtocol: class{
    func adrSelectItemDownloaded(items: AddressModel)
}

class AddressSelectModel: NSObject{
    var delegate: AdrSelectJsonModelProtocol!
    var urlPath = "http://127.0.0.1:8080/swift_address/AdrSelect_ios.jsp"
    
    var resultMy = ""
    
    
    func downloadItems(addressNo : Int){
        let urlAdd = "?addressNo=\(addressNo)"
        urlPath = urlPath + urlAdd
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to download data")
            } else {
                print("Data is downloading")
                // URLSession에 들어있는 data를 parsing
                self.parseJSON(data!)
            }
        }
        task.resume() // 위의 task를 실행해주는 함수.
    }
    
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()
        var query: AddressModel = AddressModel()
        
        do{
            // JSON 모델 탈피(?)
            // JSON 파일 불러오는 함수 → JSONSerialization
            // options ???
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        }catch let error as NSError{
            print(error)
        }
        
        // json은 key와 value값이 필요하므로 Dictionary 타입 사용
        var jsonElement = NSDictionary()
        
        print("상세정보 전")
        
        for i in 0..<jsonResult.count{
            // jsonResult[i]번째를 NSDictionary 타입으로 변환
            jsonElement = jsonResult[i] as! NSDictionary
            print("나의 정보 후 \(jsonElement)")
            print("for후 \(jsonResult[i])")
            
            // DBModel instance 선언
            // let query = DBModel() // 배열이 비어있으므로 밑에 query.~~~ 다 연결해준것
            
            
            //  scode는 jsonElement의 code값인데, String으로 형변환 시켜.
            if let addressNo = jsonElement["addressNo"] as? Int,
               let addressName = jsonElement["addressName"] as? String,
               let addressPhone = jsonElement["addressPhone"] as? String,
               let addressEmail = jsonElement["addressEmail"] as? String,
               let addressText = jsonElement["addressText"] as? String,
               let addressBirth = jsonElement["addressBirth"] as? String,
               let addressImage = jsonElement["addressImage"] as? String{
                // 아래처럼 미리 생성해놓은 constructor 사용해도 됨.
             query = AddressModel(addressNo: addressNo, addressName: addressName, addressPhone: addressPhone, addressEmail: addressEmail, addressText: addressText, addressBirth: addressBirth, addressImage: addressImage)
                
            }
            
        }
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.adrSelectItemDownloaded(items: query)
            
        })
    }
    
} // END
