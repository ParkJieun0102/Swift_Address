//
//  DetailAdrViewController.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/02/17.
//

import UIKit
import MessageUI

class DetailAdrViewController: UIViewController, StarCountJsonModelProtocol {
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var imgTestNO: UIImageView!
    
    // 프로필
    @IBOutlet weak var ivProfile: UIImageView!
    
    
    var addressReceiveItem = AddressModel() // AddressModel 객체 선언
    var result = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = addressReceiveItem.addressName
        lblPhone.text = addressReceiveItem.addressPhone
        lblEmail.text = addressReceiveItem.addressEmail
        
        let starjsonModel = StarCountJsonModel()
        starjsonModel.delegate = self
        starjsonModel.downloadItems(user_userEmail: Share.userID, address_addressNo: addressReceiveItem.addressNo!)
        
        
        // 이미지뷰를 터치했을때 이벤트 주기 +++++++++++++++++
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToStar))
        imgTestNO.addGestureRecognizer(tapGesture)
        imgTestNO.isUserInteractionEnabled = true
        // ++++++++++++++++++++++++++++++++++++++++
        
        
       
        // ++++++++++++++++++++++++++++++++++++++++
        if addressReceiveItem.addressImage == "null" {
            // 이미지 없을때
        } else {
            // 이미지 있을때
            let url = URL(string: "http://127.0.0.1:8080/swift_address/\(addressReceiveItem.addressImage!)")
            print("url : \(url)")
            let data = try! Data(contentsOf: url!)
            ivProfile.image = UIImage(data: data)
        }
        // ++++++++++++++++++++++++++++++++++++++++
        
        
    }
    
    // 입력, 수정, 삭제 후 DB 재구성 → Table 재구성
    override func viewWillAppear(_ animated: Bool) {
        
        //        let addressJsonModel = AddressJsonModel() // protocol연결된 클래스 객체 선언
        //        addressJsonModel.delegate = self // 일 처리 시킬건데, 이 화면에서 시킬거고
        //        addressJsonModel.downloadItems() // jsonModel의 downloadItems를 처리하게 할거야.
    }
    
    @objc func touchToStar(sender: UITapGestureRecognizer) {
        
        if (sender.state == .ended) {
            //
            if imgTestNO.image == UIImage(named: "yes_like.png") {
                print("해지")
                imgTestNO.image = UIImage(named: "no_like.png")
                let addressNo = addressReceiveItem.addressNo
                let starDeleteModel = StarDeleteModel() // instance 선언
                let result_Delete = starDeleteModel.starDeleteItems(addressNo: addressNo!)
                
                if result_Delete == true{
                    // insert 잘됨
                    let resultAlert = UIAlertController(title: "완료", message: "즐겨찾기에서 해제되었습니다.", preferredStyle: UIAlertController.Style.alert)
                    let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    resultAlert.addAction(onAction)
                    present(resultAlert, animated: true, completion: nil) // 열심히 만든 알럿창 보여주는 함수
                } else {
                    // insert 실패
                    let resultAlert = UIAlertController(title: "실패", message: "문제가 발생했습니다. 같은 에러가 지속적으로 발생하면 관리자에게 문의주세요.", preferredStyle: UIAlertController.Style.alert)
                    let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    resultAlert.addAction(onAction)
                    present(resultAlert, animated: true, completion: nil) // 열심히 만든 알럿창 보여주는 함수
                }
                
                //
            }else{
                print("등록")
                imgTestNO.image = UIImage(named: "yes_like.png")
               
                let addressNo = addressReceiveItem.addressNo
                let starInsertModel = StarInsertModel() // instance 선언
                let result_Insert = starInsertModel.starInsertItems(user_userEmail: Share.userID, address_addressNo: addressNo!)
                
                if result_Insert == true{
                    // insert 잘됨
                    let resultAlert = UIAlertController(title: "완료", message: "즐겨찾기에 입력되었습니다.", preferredStyle: UIAlertController.Style.alert)
                    let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
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
            
        }
        
    }
    
    func starItemDownloaded(items: Int) {
        result = items
        checkStar()
        print(result)
    }
    
    // 이미지 띄우기
    func checkStar() {
        print("check:\(result)")
        if result == 0{
            // 즐겨찾기 등록이 되어있지 않을 때
            imgTestNO.image = UIImage(named: "no_like.png")
        }else if result == 1{
            // 즐겨찾기 등록이 되어있을 때
            imgTestNO.image = UIImage(named: "yes_like.png")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func btnCall(_ sender: UIButton) {
        let phone = lblPhone.text
        // 전화번호 지정
        if let phoneCallURL = URL(string: lblPhone.text!) {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
        
        //        // text 값 받기 ==> 안됨
        //        let phoneNum = lblName.text
        //        if let phoneCallURL = URL(string: "tel://\(String(describing: phoneNum))") {
        //            let application:UIApplication = UIApplication.shared
        //            if (application.canOpenURL(phoneCallURL)) {
        //                application.open(phoneCallURL, options: [:], completionHandler: nil)
        //            }
        //        }
        
    }
    
    @IBAction func btnEmail(_ sender: UIButton) {
        let email = lblEmail.text
        
        if let phoneEmailURL = URL(string: email!) {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneEmailURL)) {
                application.open(phoneEmailURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    @IBAction func btnMessage(_ sender: UIButton) {
        let phone = lblPhone.text
        
        if let phoneMessageURL = URL(string: phone!) {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneMessageURL)) {
                application.open(phoneMessageURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    // 연락처 삭제
    @IBAction func btnAdrDelete(_ sender: UIButton) {
        
        let addressNo =  addressReceiveItem.addressNo
        print("addressNo = \(addressNo!)")
        
        let resultAlert = UIAlertController(title: "삭제", message: "삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: "예", style: UIAlertAction.Style.default, handler: {ACTION in
            let addressDeleteModel = AddressDeleteModel() // instance 선언
            let result = addressDeleteModel.addressDeleteItems(addressNo: addressNo!)
            if result == true{
                let resultAlert = UIAlertController(title: "완료", message: "삭제가 완료 되었습니다.", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {ACTION in
                    self.navigationController?.popViewController(animated: true)
                })
                resultAlert.addAction(onAction)
                self.present(resultAlert, animated: true, completion: nil)
            }else{
                let resultAlert = UIAlertController(title: "실패", message: "에러가 발생 되었습니다.", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                resultAlert.addAction(onAction)
                self.present(resultAlert, animated: true, completion: nil)
            }})
        let cancelAction = UIAlertAction(title: "아니요", style: UIAlertAction.Style.default, handler: nil)
        
        resultAlert.addAction(onAction)
        resultAlert.addAction(cancelAction)
        present(resultAlert, animated: true, completion: nil)
        
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let updateViewController = segue.destination as! UpdateViewController
        //
        let addressNo = addressReceiveItem.addressNo
        let addressText = addressReceiveItem.addressText
        
        if segue.identifier == "btnUpdate" {
            
            updateViewController.AddressReceiveItem.addressName = lblName.text
            updateViewController.AddressReceiveItem.addressPhone = lblPhone.text
            updateViewController.AddressReceiveItem.addressEmail = lblEmail.text
            updateViewController.AddressReceiveItem.addressNo = addressNo
            updateViewController.AddressReceiveItem.addressBirth = addressReceiveItem.addressBirth
            updateViewController.AddressReceiveItem.addressText = addressText
            updateViewController.AddressReceiveItem.addressImage = addressReceiveItem.addressImage
        }
        
    }
    
    
    
    
    
    // 아무곳이나 눌러 softkeyboard 지우기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
