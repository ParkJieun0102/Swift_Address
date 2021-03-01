//
//  MySelectModel.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/03/01.
//

import Foundation

protocol MyJsonModelProtocol: class{
    func myItemDownloaded(items: UserModel)
}

class MySelectModel: NSObject{
    var delegate: MyJsonModelProtocol!
    let urlPath = "http://127.0.0.1:8080/swift_address/myQuery_ios.jsp?userEmail=\(Share.userID)"
    
    var resultMy = ""
    
    
    func downloadItems(){
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
        var query: UserModel = UserModel()
        
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
        
        print("나의 정보 전")
        
        for i in 0..<jsonResult.count{
            // jsonResult[i]번째를 NSDictionary 타입으로 변환
            jsonElement = jsonResult[i] as! NSDictionary
            print("나의 정보 후 \(jsonElement)")
            print("for후 \(jsonResult[i])")
            
            // DBModel instance 선언
            // let query = DBModel() // 배열이 비어있으므로 밑에 query.~~~ 다 연결해준것
            
            
            //  scode는 jsonElement의 code값인데, String으로 형변환 시켜.
            if let userEmail = jsonElement["userEmail"] as? String,
               let userPw = jsonElement["userPw"] as? String,
               let userName = jsonElement["userName"] as? String,
               let userPhone = jsonElement["userPhone"] as? String{
                // 아래처럼 미리 생성해놓은 constructor 사용해도 됨.
             query = UserModel(userEmail: userEmail, userPw: userPw, userName: userName, userPhone: userPhone)
                
            }
            
        }
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.myItemDownloaded(items: query)
            
        })
    }
    
} // END
