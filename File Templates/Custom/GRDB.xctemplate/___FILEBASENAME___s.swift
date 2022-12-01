//___FILEHEADER___

import GRDB
import RxGRDB
import RxSwift

/// ___FILEBASENAMEASIDENTIFIER___ is responsible for high-level operations on the Entitys database.
struct ___FILEBASENAMEASIDENTIFIER___: GRDBRequest {
    
    typealias Entity = ___VARIABLE_productName:identifier___
    
    internal let dbWriter: DatabaseWriter
    
    init(dbWriter: DatabaseWriter) {
        self.dbWriter = dbWriter
    }
    
    // MARK: - Implementation
    //
    // ⭐️ Good practice: when we want to update the database, we define methods
    // that accept a Database connection, because they can easily be composed.
}
