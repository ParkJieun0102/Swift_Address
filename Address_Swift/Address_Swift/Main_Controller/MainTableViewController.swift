//
//  MainTableViewController.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/02/17.
//

import UIKit

class MainTableViewController: UITableViewController, AddressJsonModelProtocol {
    
    @IBOutlet var MainTableView: UITableView!
    
    var MainItem: NSArray = NSArray() // 배열 (한번 정해지면 바꿀 수 없음.)
    // NSMutableArray → arraylist (추가 가능)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = Share.userID
//        self.title = Share.userID
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: true)
        
        // instance 선언
        let addressJsonModel = AddressJsonModel()
        addressJsonModel.delegate = self // jsonModel에서 일 시키고, 그걸 self(여기서 쓸거임)
        addressJsonModel.downloadItems() // jsonModel에서 이 메소드 실행해서 일 처리해!
        
        
    }
    
    func addressItemDownloaded(items: NSArray) {
        // JsonModel의 locations에 담겨져서 넘어옴.
        MainItem = items
        self.MainTableView.reloadData()
    }
    
    // 입력, 수정, 삭제 후 DB 재구성 → Table 재구성
    override func viewWillAppear(_ animated: Bool) {
        
        let addressJsonModel = AddressJsonModel() // protocol연결된 클래스 객체 선언
        addressJsonModel.delegate = self // 일 처리 시킬건데, 이 화면에서 시킬거고
        addressJsonModel.downloadItems() // jsonModel의 downloadItems를 처리하게 할거야.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MainItem.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath)
        
        // Configure the cell...
        // cell 정의
        // 현재 배열값으로 들어온 cell 풀어서 정의.
        let item: AddressModel = MainItem[indexPath.row] as! AddressModel
        cell.textLabel?.text = "성명 : \(item.addressName!)"
        cell.detailTextLabel?.text = "연락처 : \(item.addressPhone!)"
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // 정보 넘기기 *********************************************
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adrDetail"{
            // 사용자가 클릭한 위치는 sender가 알고있는데, 그 위치인 TableView Cell을 담을 변수 cell.
            let cell = sender as! UITableViewCell
            // 그 위치는 이제 indexPath에서 지정.
            let indexPath = self.MainTableView.indexPath(for: cell)
            // 보낼 컨트롤러 위치
            let detailAdrViewController = segue.destination as! DetailAdrViewController
            
            let addressNo = MainItem[(indexPath! as NSIndexPath).row] as! AddressModel
            
            // detailview의 receiveItem에 =~~~~를 보낸다.
            detailAdrViewController.addressReceiveNo = addressNo.addressNo!
            
            
        }
     }
    // *************************************************************************
    
    
    
    // 아무곳이나 눌러 softkeyboard 지우기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
