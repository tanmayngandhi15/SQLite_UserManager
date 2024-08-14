//
//  TableViewModel.swift
//  Project_SqlLite
//
//  Created by Tanmay N Gandhi on 25/07/24.
//

import Foundation
import UIKit

class displayData: UITableViewCell {
    
    @IBOutlet weak var lbl_userData: UILabel!
    
    var deleteData: (() -> Void)?
    
    @IBAction func btn_delete(_ sender: UIButton) {
        deleteData?()
    }
    
    @IBOutlet var btn_del: UIButton!
    @IBOutlet var vw_tableView: UIView!
    @IBOutlet var btn_edt: UIButton!
    
    var editData: (() -> Void)?
    
    @IBAction func btn_edit(_ sender: UIButton) {
        editData?()
    }
    
    
}
