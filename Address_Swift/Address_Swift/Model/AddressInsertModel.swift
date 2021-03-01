//
//  AddressInsertModel.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/02/17.
//

import Foundation


class AddressInsertModel: NSObject{
    
    var urlPath = "http://127.0.0.1:8080/swift_address/addressInsert_ios.jsp"
    
    
    // insertItems의 () 매개변수들은 AddViewController에서 값을 넣어줘서 함께 실행할거고 → Bool로 실행 여부 확인할거야.
    func addressInsertItems(addressName: String, addressPhone: String, addressEmail: String, addressText: String, addressBirth: String, at filepath: URL, completionHandler: @escaping(Data?, URLResponse?) -> Void) {
        let urlAdd = "?addressName=\(addressName)&addressPhone=\(addressPhone)&addressEmail=\(addressEmail)&addressText=\(addressText)&addressBirth=\(addressBirth)"
        urlPath = urlPath + urlAdd
        
        // 한글 url encoding → 한글 글씨가 %로 바뀌어서 날아감.
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        // 실제 url
        let url: URL = URL(string: urlPath)! // 텍스트 글자를 url모드로 바꿔줌
        let parameters = [
            "name" : ""
//            "content" : content,
//            "User_uSeqno" : String(USERSEQNO),
//            "Recipe_rSeqno" : String(RECIPESEQNO)
        ]

        // 경로로부터 요청을 생성한다. 이 때 Content-Type 헤더 필드를 변경한다.
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\"XXXXX\"",
                         forHTTPHeaderField: "Content-Type")
        
        // 파일URL로부터 multipart 데이터를 생성하고 업로드한다.
        if let data = buildBody(with: filepath, parameters: parameters) {
            let task = URLSession.shared.uploadTask(with: request, from: data){ data, res, _ in
                completionHandler(data, res)
            }
            task.resume()
        }
    } // func END
    func buildBody(with fileURL: URL, parameters: [String: String]?) -> Data? {
        // 파일을 읽을 수 없다면 nil을 리턴
        guard let filedata = try? Data(contentsOf: fileURL) else {
            return nil
        }
        
        // 바운더리 값을 정하고,
        // 각 파트의 헤더가 될 라인들을 배열로 만든다.
        // 이 배열을 \r\n 으로 조인하여 한 덩어리로 만들어서
        // 데이터로 인코딩한다.
        let boundary = "XXXXX"
        let mimetype = "image/jpeg"
        let headerLines = ["--\(boundary)",
            "Content-Disposition: form-data; name=\"file\"; filename=\"\(fileURL.lastPathComponent)\"",
            "Content-Type: \(mimetype)",
            "\r\n"]
        var data = headerLines.joined(separator:"\r\n").data(using:.utf8)!
        
        // 그 다음에 파일 데이터를 붙이고
        data.append(contentsOf: filedata)
        data.append(contentsOf: "\r\n".data(using: .utf8)!)
        
        // 일반적인 데이터 넣을때 사용하는 폼
        // --\(boundary)\r\n
        // Content-Disposition: form-data; name=\"값\"\r\n\r\n
        // 내용\r\n
        let lines = ["--\(boundary)","Content-Disposition: form-data; name=\"name\"\r\n","values\r\n"]
        data.append(contentsOf: lines.joined(separator: "\r\n").data(using: .utf8)!)
        /*
        if parameters != nil {
            for (key, value) in parameters! {
                let lines = ["--\(boundary)","Content-Disposition: form-data; name=\"\(key)\"\r\n","\(value)\r\n"]
                data.append(contentsOf: lines.joined(separator: "\r\n").data(using: .utf8)!)
            }
        }
        */
        
        // 마지막으로 데이터의 끝임을 알리는 바운더리를 한 번 더 사용한다.
        // 이는 '새로운 개행'이 필요하므로 앞에 \r\n이 있어야 함에 유의 한다.
        data.append(contentsOf: "\r\n--\(boundary)--".data(using:.utf8)!)
        return data
    }
}
