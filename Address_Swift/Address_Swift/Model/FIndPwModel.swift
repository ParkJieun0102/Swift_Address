//
//  FIndPwModel.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/03/01.
//

import Foundation

// protocol은 DB의 table과 연결되어있기 때문에 필요한 것.
// insertModel에선 필요없다 (?)
protocol PwJsonModelProtocol: class{
    func pwItemDownloaded(items: String) // <- 여기에 담은 아이템을 아래 delegate에서 사용하고, tableView에서 궁극적으로 사용.
}

class FindPwModel: NSObject{
    var delegate: PwJsonModelProtocol!
    var urlPath = "http://127.0.0.1:8080/swift_address/findPW_ios.jsp"
    var resultPW = ""
    
    func downloadItems(userName: String, userPhone: String, userEmail: String){
        
        let urlAdd = "?userName=\(userName)&userPhone=\(userPhone)&userEmail=\(userEmail)"
        urlPath = urlPath + urlAdd
        
        // 한글 url encoding → 한글 글씨가 %로 바뀌어서 날아감.
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
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
        
        
        print("for전")
        
        for i in 0..<jsonResult.count{
            // jsonResult[i]번째를 NSDictionary 타입으로 변환
            jsonElement = jsonResult[i] as! NSDictionary
            
            // DBModel instance 선언
            // let query = DBModel() // 배열이 비어있으므로 밑에 query.~~~ 다 연결해준것
            
            
            //  scode는 jsonElement의 code값인데, String으로 형변환 시켜.
            if let userPw = jsonElement["userPw"] as? String{
                self.resultPW = userPw
            }
            
            // locations.add(query) // locations 배열에 한뭉텅이씩 담기
        }
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.pwItemDownloaded(items: self.resultPW)
        })
    }
    
} // END
