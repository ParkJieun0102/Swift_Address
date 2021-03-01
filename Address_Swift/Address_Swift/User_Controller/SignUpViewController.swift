//
//  SignUpViewController.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/02/17.
//


// 회원가입 
import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var txtUserEmail: UITextField!
    @IBOutlet weak var txtUserPw: UITextField!
    @IBOutlet weak var txtUserPwCheck: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtUserPhone: UITextField!
    
    @IBOutlet weak var lblPwCheck: UILabel!
    @IBOutlet weak var lblIdCheck: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        fieldCheck()
        pwCheck()
        insertUser() 
        
    }
    
    // 모든값 입력하도록 막기
    func fieldCheck()  {
        if (txtUserEmail.text == "" || txtUserPw.text == "" || txtUserPwCheck.text == "" || txtUserName.text == "" || txtUserPhone.text == ""){
            // 입력한 값이 없을 때
            let userAlert = UIAlertController(title: "경고", message: "모두 입력해주세요.", preferredStyle: UIAlertController.Style.actionSheet)
            let onAction = UIAlertAction(title: "네, 알겠습니다.", style: UIAlertAction.Style.default, handler: nil)
            userAlert.addAction(onAction)
            present(userAlert, animated: true, completion: nil)
        }
    }
    
    // 입력한 비밀번호와 한번더 입력한 비밀번호가 같은지 확인
    func pwCheck(){
        if (txtUserPw.text != txtUserPwCheck.text){
            // 입력한 비밀번호가 일치하지 않을때
            let userAlert = UIAlertController(title: "경고", message: "입력하신 비밀번호가 일치하지 않습니다.", preferredStyle: UIAlertController.Style.actionSheet)
            let onAction = UIAlertAction(title: "네, 알겠습니다.", style: UIAlertAction.Style.default, handler: nil)
            userAlert.addAction(onAction)
            present(userAlert, animated: true, completion: nil)
        }
    }
    
    func insertUser() {
        let userEmail = txtUserEmail.text
        let userPw = txtUserPwCheck.text
        let userName = txtUserName.text
        let userPhone = txtUserPhone.text
        
        let signUpModel = SignUpModel() // instance 선언
        let result = signUpModel.userSignUpItems(userEmail: userEmail!, userPw: userPw!, userName: userName!, userPhone: userPhone!)
        
        if result == true{
            // insert 잘됨
            let resultAlert = UIAlertController(title: "완료", message: "입력되었습니다.", preferredStyle: UIAlertController.Style.actionSheet)
            let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true) // 현재화면 종료
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil) // 열심히 만든 알럿창 보여주는 함수
        } else {
            // insert 실패
            let resultAlert = UIAlertController(title: "실패", message: "문제가 발생했습니다. 같은 에러가 지속적으로 발생하면 관리자에게 문의주세요.", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil) // 열심히 만든 알럿창 보여주는 함수
        }
    }
    
    
    // 갖고있는 아이디값이랑 비교해서 중복되는지 알려줌 -> 어캐 실시간?
    func idCheck() {
        let userEmail = txtUserEmail.text
        let signUpModel = SignUpModel()
        let result = signUpModel.userIdCheckItems(userEmail: userEmail!)
        
        if result == true {
            lblIdCheck.textColor = UIColor.blue
            lblIdCheck.text = "사용 가능한 이메일입니다."
        }else {
            lblIdCheck.textColor = UIColor.red
            lblIdCheck.text = "사용이 불가능한 이메일입니다."
        }
    }
    
    //    //  비밀번호 입력값이 같은지 비교 -> 어캐 실시간..?
    //    func pwCheck(){
    //        if txtUserPw.text == txtUserPwCheck.text {
    //            lblPwCheck.textColor = UIColor.blue
    //            lblPwCheck.text = "비밀번호가 일치합니다."
    //        }else{
    //            lblPwCheck.textColor = UIColor.red
    //            lblPwCheck.text = "비밀번호가 일치하지 않습니다."
    //        }
    //
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    // 아무곳이나 눌러 softkeyboard 지우기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
