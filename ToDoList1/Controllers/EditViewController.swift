import UIKit

class EditViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var previewImage: UIImageView!
    
    // MARK: - Variables
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chỉnh sửa"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Xong",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(updateTask))
    }
    
    // MARK: - Function update task
    // FIXME: Xử lý cập nhật dữ liệu!
    @objc func updateTask() {
        navigationController?.popViewController(animated: true)
    }
}
