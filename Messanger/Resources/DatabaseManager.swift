//
//  DatabaseManager.swift
//  Messanger
//
//  Created by Sumit Joshi on 08/07/21.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
}

// MARK: - Account MANAGEMENT
extension DatabaseManager {
    public func userExists(with email: String,
                           completion: @escaping((Bool)-> Void)) {
        var safeEmail = email.replacingOccurrences(of: ".", with: "_")
            safeEmail = email.replacingOccurrences(of: "@", with: "_")
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
            
        })
    }
    
    ///Inserts new usser to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        
        ])
    }
}
    struct ChatAppUser {
        let firstName: String
        let lastName: String
        let emailAddress: String
        
        var safeEmail: String {
            var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "_")
                safeEmail = emailAddress.replacingOccurrences(of: "@", with: "_")
            return safeEmail
        }
//      let profilePictureUrl: String
    }
    

