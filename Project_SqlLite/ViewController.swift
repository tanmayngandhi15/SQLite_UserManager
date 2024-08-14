//
//  ViewController.swift
//  Project_SqlLite
//
//  Created by Tanmay N Gandhi on 25/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtF_Email: UITextField!
    @IBOutlet weak var txtF_Name: UITextField!
    @IBOutlet weak var tv_displayData: UITableView!

    private let viewModel = SignUpViewModel()
  
     var userDataArr = [SignUpModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tv_displayData.layer.shadowColor = UIColor.black.cgColor
        tv_displayData.layer.shadowOpacity = 0.5
        tv_displayData.layer.shadowOffset = CGSize(width: 0, height: 2)
        tv_displayData.layer.shadowRadius = 4
        tv_displayData.layer.cornerRadius = 10
        
        loadUserData()
    }
    
    private func loadUserData() {
            viewModel.getSqlData { [weak self] data in
                guard let self = self else { return }
                self.userDataArr = data
                self.tv_displayData.reloadData()
            }
        }

        private func deleteUser(email: String) {
            viewModel.deleteUser(email: email) { [weak self] success in
                if success {
                    self?.loadUserData()
                } else {
                    AlertHelper.showAlert(on: self!, title: "Error", message: "Failed to delete user data.")
                }
            }
        }

        private func editUser(name: String, email: String) {
            
         let alertController = UIAlertController(title: "Edit Name", message: nil, preferredStyle: .alert)
        
            alertController.view.tintColor = UIColor.black
            
            alertController.addTextField { textField in
                textField.placeholder = name
                textField.textColor = UIColor.black
            }
            
            let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
                guard let self = self else { return }
                
                if let newText = alertController.textFields?.first?.text, !newText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                   
                    self.viewModel.editUser(name: newText, email: email) { [weak self] success in
                        if success {
                            self?.loadUserData()
                        } else {
                            AlertHelper.showAlert(on: self!, title: "Error", message: "Failed to edit user data.")
                        }
                    }
                }
            }
            
            alertController.addAction(saveAction)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            present(alertController, animated: true, completion: nil)
        }

    @IBAction func btn_save(_ sender: UIButton) {
        guard let txtEmail = txtF_Email.text, !txtEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            AlertHelper.showAlert(on: self, title: "Error", message: "Please enter EmailID.")
            return
        }
        guard let txtName = txtF_Name.text, !txtName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            AlertHelper.showAlert(on: self, title: "Error", message: "Please enter Name.")
            return
        }

        viewModel.hasEmailData(email: txtEmail, name: txtName) { [weak self] result in
            switch result {
                
            case .success:
                self?.txtF_Email.text = ""
                self?.txtF_Name.text = ""
                self?.loadUserData()
                
            case .failure(let error):
                let message: String
                switch error {
                case .emailExists:
                    message = "Email already exists."
                case .saveFailed:
                    message = "Failed to save user data."
                }
                AlertHelper.showAlert(on: self!, title: "Error", message: message)
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTableviewDisplay", for: indexPath) as! displayData
        let modelData = userDataArr[indexPath.row]

        cell.lbl_userData.text = "\(modelData.name)" // \t\(modelData.email)
        
        cell.deleteData = {
            
            self.deleteUser(email: modelData.email)
        }
        
        cell.editData = {
            
            self.editUser(name: modelData.name, email: modelData.email)
        }
        
        cell.btn_edt.layer.cornerRadius = 12
        cell.btn_del.layer.cornerRadius = 12
        cell.vw_tableView.layer.cornerRadius = 12
        
        return cell
    }
}

