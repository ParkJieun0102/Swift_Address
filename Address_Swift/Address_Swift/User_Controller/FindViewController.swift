//
//  FindViewController.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/02/17.
//


// 아이디 / 비밀번호 찾기
import UIKit

class FindViewController: UIViewController, IdJsonModelProtocol, PwJsonModelProtocol{
    
    
    @IBOutlet weak var FindName: UITextField!
    @IBOutlet weak var FindPhone: UITextField!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var FindEmail: UITextField!
    
    @IBOutlet weak var FindBtn: UIButton!
    
    var resultID = ""
    var resultPW = ""
    var checking = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        lblEmail.isHidden = true
        FindEmail.isHidden = true
        
    }
    
    
    func idItemDownloaded(items: String) {
        resultID = items
        print("아이디는? \(items)")
        
        let resultAlert = UIAlertController(title: "찾음", message: "\(FindName.text!)님의 아이디는 : \(resultID)", preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        resultAlert.addAction(onAction)
        present(resultAlert, animated: true, completion: nil) // 열심히 만든 알럿창 보여주는 함수
    }
    
    func pwItemDownloaded(items: String) {
        resultPW = items
        print("아이디는? \(items)")
        
        let resultAlert = UIAlertController(title: "찾음", message: "\(FindName.text!)님의 비밀번호는 : \(resultPW)", preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        resultAlert.addAction(onAction)
        present(resultAlert, animated: true, completion: nil) // 열심히 만든 알럿창 보여주는 함수
    }
    
    @IBAction func btnFindId(_ sender: UIButton) {
        
        if checking == 0{
            print("아이디 찾기")
            let findIdModel = FindIdModel()
            findIdModel.delegate = self
            findIdModel.downloadItems(userName: FindName.text!, userPhone: FindPhone.text!)
        }else if checking == 1{
            print("비밀번호 찾기")
            let findPwModel = FindPwModel()
            findPwModel.delegate = self
            findPwModel.downloadItems(userName: FindName.text!, userPhone: FindPhone.text!, userEmail: FindEmail.text!)
            
        }
        
        
    }
    
    
    @IBAction func sgChangeFind(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // 아이디 찾기
            checking = 0
            lblEmail.isHidden = true
            FindEmail.isHidden = true
            FindBtn.setTitle("아이디 찾기", for: .normal)
            
            FindName.text = ""
            FindPhone.text = ""
            
        }else if sender.selectedSegmentIndex == 1{
            // 비밀번호 찾기
            checking = 1
            lblEmail.isHidden = false
            FindEmail.isHidden = false
            FindBtn.setTitle("비밀번호 찾기", for: .normal)
            
            FindName.text = ""
            FindPhone.text = ""
        }
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
