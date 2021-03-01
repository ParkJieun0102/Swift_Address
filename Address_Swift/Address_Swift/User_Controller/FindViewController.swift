//
//  FindViewController.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/02/17.
//


// 아이디 / 비밀번호 찾기
import UIKit

class FindViewController: UIViewController, IdJsonModelProtocol{
    
    
    @IBOutlet weak var FindName: UITextField!
    @IBOutlet weak var FindPhone: UITextField!
    
    var resultID = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    
    func idItemDownloaded(items: String) {
        resultID = items
        print("아이디는? \(items)")
        
        let resultAlert = UIAlertController(title: "찾음", message: "\(FindName.text!) 아이디는 : \(resultID)", preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        resultAlert.addAction(onAction)
        present(resultAlert, animated: true, completion: nil) // 열심히 만든 알럿창 보여주는 함수
    }
    
    @IBAction func btnFindId(_ sender: UIButton) {
        print("아이디 찾기")
        
        let findIdModel = FindIdModel()
        findIdModel.delegate = self
        findIdModel.downloadItems(userName: FindName.text!, userPhone: FindPhone.text!)
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
