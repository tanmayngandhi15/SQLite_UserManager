//
//  DatabaseManager.swift
//  Project_SqlLite
//
//  Created by Tanmay N Gandhi on 25/07/24.
//

import Foundation

class DatabaseManager: NSObject {

    static let shared = DatabaseManager()
    var database: FMDatabase?

    private override init() {
        super.init()
        database = FMDatabase(path: Util.getPath("Signup.db"))
        print("DBPath: \(database!)")
    }

    func saveData(_ modelInfo: SignUpModel) -> Bool {
        guard let db = database else {
            print("Database not initialized")
            return false
        }

        db.open()

        do {
            try db.executeUpdate("INSERT INTO Signup (email, name) VALUES (?, ?)", values: [modelInfo.email, modelInfo.name])
            db.close()
            return true
        } catch {
            print("Failed to insert data: \(error.localizedDescription)")
            db.close()
            return false
        }
    }
    
    func deleteData(withEmail email: String) -> Bool {
        guard let db = database else {
            print("Database not initialized")
            return false
        }

        db.open()

        do {

           let didSave = try db.executeUpdate("DELETE FROM Signup WHERE email = ?", withArgumentsIn: [email])
             
            db.close()
            return didSave
        } catch {
           
            print("Failed to delete data: \(error.localizedDescription)")
            db.close()
            return false
        }
    }
    
    func editData(nameToUpdate name: String, withEmail email: String) -> Bool {
        guard let db = database else {
            print("Database not initialized")
            return false
        }

        db.open()

        do {

           let didSave = try db.executeUpdate("UPDATE Signup SET name = ? WHERE email = ?", withArgumentsIn: [name, email])
             
            db.close()
            return didSave
        } catch {
           
            print("Failed to update data: \(error.localizedDescription)")
            db.close()
            return false
        }
    }
    
    func hasEmailData(withEmail email: String) -> Bool? {
        guard let db = database else {
            print("Database not initialized")
            return nil
        }

        db.open()

        do {

            let hasEmail = try db.executeUpdate("SELECT * FROM Signup WHERE email = ?", withArgumentsIn: [email])

            db.close()
            return !hasEmail
        } catch {
           
            print("Failed to update data: \(error.localizedDescription)")
            db.close()
            return nil
        }
    }

    
    
    func getData() -> [SignUpModel]? {
        guard let db = database else {
            print("Database not initialized")
            return nil
        }

        db.open()

        var results: [SignUpModel] = []

        do {
            let rs = try db.executeQuery("SELECT * FROM Signup", values: nil)
            
            while rs.next() {
                if let email = rs.string(forColumn: "email"),
                   let name = rs.string(forColumn: "name") {
                    let model = SignUpModel(email: email, name: name)
                    results.append(model)
                }
            }
            
            db.close()
            return results
        } catch {
            print("Failed to retrieve data: \(error.localizedDescription)")
            db.close()
            return nil
        }
    }

}

