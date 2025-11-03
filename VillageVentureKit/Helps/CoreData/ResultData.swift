

import Foundation
import CoreData

@objc(ResultData)
public class ResultData: NSManagedObject {}
extension ResultData {
    @NSManaged public var id: Int16
    @NSManaged public var levelCount: Int16
    @NSManaged public var matchesCount: Int16
    @NSManaged public var bestTime: Date
}
extension ResultData : Identifiable {}
