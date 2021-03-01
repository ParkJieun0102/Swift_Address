//
//  MyUpdateViewController.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/03/01.
//

import UIKit

class MyUpdateViewController: UIViewController, MyJsonModelProtocol {
   
    @IBOutlet weak var lblmyEmail: UILabel!
    @IBOutlet weak var txtMyName: UITextField!
    @IBOutlet weak var txtMyPw: UITextField!
    @IBOutlet weak var txtMyPhone: UITextField!
    
    var userReceiveItem = UserModel() // AddressModel 객체 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mySelectModel = MySelectModel()
        mySelectModel.delegate = self
        mySelectModel.downloadItems()
        
    }
    
    
    func myItemDownloaded(items: UserModel) {
        userReceiveItem = items
        print("나의 정보 : \(items.userName!)")
        
        lblmyEmail.text = Share.userID
        txtMyName.text = userReceiveItem.userName!
        txtMyPw.text = userReceiveItem.userPw!
        txtMyPhone.text = userReceiveItem.userPhone!
        
    }

    @IBAction func btnMyUpdate(_ sender: UIButton) {
        let userPw = txtMyPw.text
        let userName = txtMyName.text
        let userPhone = txtMyPhone.text
        let userEmail = lblmyEmail.text
        
        let myupdateModel = MyUpdateModel() // instance 선언
        let result = myupdateModel.myupdateItems(userPw: userPw!, userName: userName!, userPhone: userPhone!, userEmail: userEmail!)
        
        if result == true{
            let resultAlert = UIAlertController(title: "완료", message: "수정 되었습니다.", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }else{
            let resultAlert = UIAlertController(title: "실패", message: "에러가 발생 되었습니다.", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
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
