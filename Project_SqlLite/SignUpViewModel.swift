//
//  SignUpViewModel.swift
//  Project_SqlLite
//
//  Created by Tanmay N Gandhi on 13/08/24.
//

class SignUpViewModel {

    func getSqlData(completion: ([SignUpModel]) -> Void) {
        if let data = DatabaseManager.shared.getData() {
            completion(data)
        }
    }

    func deleteUser(email: String, completion: (Bool) -> Void) {
        let isDelete = DatabaseManager.shared.deleteData(withEmail: email)
        if isDelete {
            self.getSqlData {_ in 
                completion(true)
            }
        } else {
            completion(false)
        }
    }

    func editUser(name: String, email: String, completion: (Bool) -> Void) {
        let isEdit = DatabaseManager.shared.editData(nameToUpdate: name, withEmail: email)
        if isEdit {
            self.getSqlData {_ in 
                completion(true)
            }
        } else {
            completion(false)
        }
    }
    
    private func saveData(email: String, name: String, completion: (Result<Void, SignUpError>) -> Void) {
            let isSave = DatabaseManager.shared.saveData(SignUpModel(email: email, name: name))
            if isSave {
                self.getSqlData {_ in 
                    completion(.success(()))
                }
            } else {
                completion(.failure(.saveFailed))
            }
        }
    
    func hasEmailData(email: String, name: String, completion: (Result<Void, SignUpError>) -> Void) {
            guard let hasEmail = DatabaseManager.shared.hasEmailData(withEmail: email), !hasEmail else {
                completion(.failure(.emailExists))
                return
            }

            saveData(email: email, name: name, completion: completion)
        }
    
}

