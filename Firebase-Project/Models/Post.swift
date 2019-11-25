
import Foundation
import FirebaseFirestore

struct Post {
    let pic: String
    let body: String
    let id: String
    let creatorID: String
    let dateCreated: Date?
    
    init(pic: String, body: String, creatorID: String, dateCreated: Date? = nil) {
        self.pic = pic
        self.body = body
        self.creatorID = creatorID
        self.id = UUID().description
        self.dateCreated = dateCreated
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let pic = dict["pic"] as? String,
            let body = dict["body"] as? String,
            let userID = dict["creatorID"] as? String,
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
        
        self.pic = pic
        self.body = body
        self.creatorID = userID
        self.id = id
        self.dateCreated = dateCreated
    }
    
    var fieldsDict: [String: Any] {
        return [
            "pic": self.pic,
            "body": self.body,
            "creatorID": self.creatorID
        ]
    }
}
