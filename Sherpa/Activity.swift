//
//  Activity.swift
//

import Foundation
import Parse

class Activity:PFObject, PFSubclassing{
    
    
    @NSManaged var userImage: PFFile?
    @NSManaged var userName: String?
    @NSManaged var numberTrees: String?
    @NSManaged var extraDetail: String?
    
    
    //MARK : PFSubclassing Protocol
    
    static func parseClassName() -> String {
        return "Activity"
    }
    
    override init(){
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
}
