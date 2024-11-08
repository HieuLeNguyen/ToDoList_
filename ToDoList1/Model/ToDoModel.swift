import Foundation
import UIKit


struct ToDoModel: Codable {
    var title: String
    var description: String?
    var image: Data? // UIImage sẽ được chuyển thành Data để lưu trữ
    var type: ToDoType
}

enum ToDoType: String, Codable {
    case new
    case inprogress
    case completed
}
