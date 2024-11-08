import UIKit

class CreateViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var previewImage: UIImageView!
    
    // MARK: - Variables
    var update: (() -> Void)?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tạo công việc"
        /// add: button save
        let saveBarButtonItem = UIBarButtonItem(title: "Lưu", style: .done, target: self, action: #selector(saveToDo))
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    // MARK: - Function save todo
    @objc private func saveToDo() {
        guard let title = titleField.text, !title.isEmpty else {
            let alert = UIAlertController(title: "Lưu thất bại",
                                          message: "Vui lòng điền tên công việc!",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            return
        }
        
        // Lấy giá trị count hiện tại từ UserDefaults
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        let newCount = currentCount + 1 // Tính toán newCount trước khi sử dụng
        
        
        // FIXME: kiểm tra thô về ảnh hiện có
        if previewImage.image == UIImage(systemName: "photo") {
            previewImage.image = nil
        }
        
        // Tạo mô hình mới
        let toDo = ToDoModel(
            title: title,
            description: descTextView.text,
            image: previewImage.image?.pngData(), // Chuyển UIImage thành Data
            type: .new // Ví dụ kiểu mặc định là `new`
        )
        
        // Mã hóa mô hình thành Data
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(toDo)
            UserDefaults.standard.set(data, forKey: "task_\(newCount)")
            
            // Cập nhật `count` và lưu lại
            let newCount = (UserDefaults.standard.integer(forKey: "count") + 1)
            UserDefaults.standard.set(newCount, forKey: "count")
            
            update?()
            navigationController?.popViewController(animated: true)
            
        } catch {
            print("Lỗi khi mã hóa dữ liệu: \(error)")
        }
    }
    
}

// MARK: - UITextViewDelegate
extension CreateViewController: UITextViewDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleField.resignFirstResponder()
        return true
    }
}
