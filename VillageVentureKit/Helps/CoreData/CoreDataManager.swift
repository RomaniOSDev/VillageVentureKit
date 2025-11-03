

import CoreData
import UIKit



final class CoreManager {
    
    static let shared = CoreManager()
//    let coreData = CoreManager.shared
    
    var delegat: AppDelegate
    var context: NSManagedObjectContext
    
    init() {
        delegat = UIApplication.shared.delegate as! AppDelegate
        context = delegat.persistentContainer.viewContext
    }
   
    
    func getResultDataArray() -> [ResultData]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ResultData")
        do {
            return try context.fetch(fetchRequest) as? [ResultData]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    func getResultData() -> ResultData? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ResultData")
        do {
            let data = try context.fetch(fetchRequest) as? [ResultData]
            return data?.last
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    func removeAllResult() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ResultData")
        do {
            let data = try? context.fetch(fetchRequest) as? [ResultData]
            data?.forEach({ context.delete($0) })
        }
        delegat.saveContext()
    }
    func editBestTime(_ time: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ResultData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [ResultData],
                 let attribute = data.first(where: { $0.id == 7 }) else { return }
            guard let newTime = timeFromString(time) else {
                print("Неверный формат времени")
                return
            }
            let lastSavedTime = getResultData()?.bestTime ?? Date()
            if newTime > lastSavedTime {
                attribute.bestTime = newTime
            } else {
                attribute.bestTime = lastSavedTime
            }
        }
        delegat.saveContext()
    }
    func editLevel(_ level: Int16) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ResultData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [ResultData],
                 let attribute = data.first(where: { $0.id == 7 }) else { return }
            if level > getResultData()?.levelCount ?? 0 {
                attribute.levelCount = level
            }
        }
        delegat.saveContext()
    }
    func editMatches(_ match: Int16) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ResultData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [ResultData],
                 let attribute = data.first(where: { $0.id == 7 }) else { return }
            if match > getResultData()?.matchesCount ?? 0 {
                attribute.matchesCount = match
            }
        }
        delegat.saveContext()
    }
    
    func addResultDefaults() {
       guard let nameEntity = NSEntityDescription.entity(forEntityName: "ResultData",
                                                         in: context) else { return }
        let model = ResultData(entity: nameEntity,
                              insertInto: context)
        model.id = 7
        model.bestTime = timeFromString("00:00") ?? Date()
        model.levelCount = 0
        model.matchesCount = 0
        delegat.saveContext()
    }

    private func timeFromString(_ timeString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.date(from: timeString)
    }
    private func dataFromString(_ currentDate: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: currentDate)
    }
}
