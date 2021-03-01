//
//  UpdateViewController.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/02/17.
//

import UIKit
protocol UpdateDelegate {
    func reloadData()
}

class UpdateViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtText: UITextField!
    @IBOutlet weak var txtBirth: UITextField!
    
    var delegate : UpdateDelegate?
    var AddressReceiveItem = AddressModel()
    
    let imagePickerController = UIImagePickerController()
    var imageURL: URL?
    
    var checkImage = 0
    @IBOutlet weak var ivProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtName.text = AddressReceiveItem.addressName
        txtPhone.text = AddressReceiveItem.addressPhone
        txtEmail.text = AddressReceiveItem.addressEmail
        txtText.text = AddressReceiveItem.addressText
        txtBirth.text = AddressReceiveItem.addressBirth
        
        // 이미지뷰를 터치했을때 이벤트 주기 +++++++++++++++++
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToImage))
        ivProfile.addGestureRecognizer(tapGesture)
        ivProfile.isUserInteractionEnabled = true
        // ++++++++++++++++++++++++++++++++++++++++
        imagePickerController.delegate = self


        if AddressReceiveItem.addressImage == "null" {
            // 이미지 없을때
        } else {
            // 이미지 있을때
            let url = URL(string: "http://127.0.0.1:8080/swift_address/\(AddressReceiveItem.addressImage!)")
            
            let data = try! Data(contentsOf: url!)
            ivProfile.image = UIImage(data: data)
        }
        
//        let Image = AddressReceiveItem.addressImage
//
//        let url = URL(string: "http://127.0.0.1:8080/swift_address/\(Image!)")
//        if Image == "" {
//            // 이미지 없을 때
//            ivProfile.image = UIImage(named: "logo.png")
//        }else{
//            // 이미지 있을 때
//            let data = try! Data(contentsOf: url!)
//            ivProfile.image = UIImage(data: data)
//        }
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            checkImage = 2
            ivProfile.image = image
            
            imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL
        }
        
        // 켜놓은 앨범 화면 없애기
        dismiss(animated: true, completion: nil)
    }
    
    @objc func touchToImage(sender: UITapGestureRecognizer) {
        
        if (sender.state == .ended) {
            // 앨범 호출
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnAdrUpdate(_ sender: UIButton) {
        
        let addressName = txtName.text
        let addressPhone = txtPhone.text
        let addressEmail = txtEmail.text
        let addressText = txtText.text
        let addressBirth = txtBirth.text
        let addressNo = AddressReceiveItem.addressNo
        
        
        let addressUpdateModel = AddressUpdateModel() // instance 선언
        // 이미지가 있을 때
        if checkImage == 2 {
            addressUpdateModel.addressUpdateItems(addressName: addressName!, addressPhone: addressPhone!, addressEmail: addressEmail!, addressText: addressText!, addressBirth: addressBirth!, addressNo: addressNo!, at: imageURL!, completionHandler: {_, _ in
                DispatchQueue.main.async { () -> Void in
                    if self.delegate != nil{
                        self.delegate?.reloadData()
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }
            })
            
        }else {
            
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
    
    
    // 아무곳이나 눌러 softkeyboard 지우기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
