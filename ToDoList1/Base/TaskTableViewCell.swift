import UIKit

class TaskTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UITextView!
    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var taskType: UIButton! /// đã tắt tương tác  UI
    // TODO: Tạo alertsheet cho phép chuyển type status
    
    // MARK: - Variables
    static let identifier = "TaskTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskDescriptionLabel.isScrollEnabled = false // Đảm bảo TextView có thể tự động mở rộng chiều cao
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Cấu hình view khi được chọn
    }
    
    // MARK: - Function register cell with the TableView
    static func register(with tableView: UITableView) {
        let nib = UINib(nibName: identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    
    // MARK: - Configure cell with data
    func configure(with task: ToDoModel) {
        taskNameLabel.text = task.title
        taskDescriptionLabel.text = task.description ?? ""
        
        if let imageData = task.image {
            taskImageView.image = UIImage(data: imageData) // Chuyển đổi từ Data? sang UIImage?
        } else {
            taskImageView.image = UIImage(systemName: "seal")         }
        
        switch task.type {
        case .inprogress:
            taskType.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            taskType.tintColor = .systemBlue
        case .completed:
            taskType.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            taskType.tintColor = .systemGreen
        default:
            taskType.setImage(UIImage(systemName: "circle"), for: .normal)
            taskType.tintColor = .systemGray
        }
    }
}
