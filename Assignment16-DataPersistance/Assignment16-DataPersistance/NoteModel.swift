
import Foundation

final class Note: Codable {
    var header: String
    var content: String
    
    init(header: String, content: String) {
        self.header = header
        self.content = content
    }
    
    static let dummyData = [
    Note(header: "Task1", content: "Call .... as soon as I wake up"),
    Note(header: "Task2", content: "Buy a birthday gift for ...."),
    Note(header: "Task3", content: "Fix the broken car part"),
    Note(header: "Task4", content: "Make a TODO list for Monday"),
    Note(header: "Task5", content: "Buy groceries"),
    Note(header: "Task6", content: "Watch that movie I was recommended"),
    Note(header: "Task7", content: "Sleep"),
    Note(header: "Task8", content: "Sleep even more"),
    Note(header: "Task9", content: "Don't forget to wake up"),
    ]
}
