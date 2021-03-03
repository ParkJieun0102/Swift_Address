//
//  TableViewCell.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/02/22.
//

import UIKit

// 1 >Create protocolo
protocol MyCellDelegate {
    func btnCloseTapped(cell: TableViewCell)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var hiddenNo: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var btnStar: UIButton!
    
    var delegate: MyCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func btnDelete(_ sender: UIButton) {
        //8 > set this condition and call your proto func
            delegate?.btnCloseTapped(cell: self)
        
    }
    
    
}
