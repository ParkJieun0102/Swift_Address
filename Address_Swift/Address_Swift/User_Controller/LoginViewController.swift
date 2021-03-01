//
//  LoginViewController.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/02/24.
//

import UIKit

class LoginViewController: UIViewController, LoginJsonModelProtocol {
    
    
    @IBOutlet weak var txtPw: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    //
    @IBOutlet weak var btnRound: UIButton!
    @IBOutlet weak var btnRound1: UIButton!
    
    var result = 3
    var userReceiveItem = UserModel() // AddressModel 객체 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.title = "로그인 화면"
        btnRound.layer.cornerRadius = 15
        btnRound1.layer.cornerRadius = 15
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func checkUser() {
        
        print("check:\(result)")
        if result == 1{
            
            // 회원정보가 있을 때
            Share.userID = txtEmail.text!
            self.performSegue(withIdentifier: "afterChecking", sender: self)
        }else if result == 0{
            // 회원정보가 없을 때
            let userAlert = UIAlertController(title: "경고", message: "ID나 암호가 틀렸습니다.", preferredStyle: UIAlertController.Style.actionSheet)
            let onAction = UIAlertAction(title: "네, 알겠습니다.", style: UIAlertAction.Style.default, handler: nil)
            userAlert.addAction(onAction)
            present(userAlert, animated: true, completion: nil)
        }
    }
    
    
    func loginItemDownloaded(items: Int) {
        result = items
        checkUser()
        print(result)
    }
    
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        
        let userEmail = txtEmail.text
        let userPw = txtPw.text
        
        let loginjsonModel = LoginJsonModel()
        loginjsonModel.delegate = self
        loginjsonModel.downloadItems(userEmail: userEmail!, userPw: userPw!)
        
    }
    
    
    
    
    
    
    // 아무곳이나 눌러 softkeyboard 지우기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
