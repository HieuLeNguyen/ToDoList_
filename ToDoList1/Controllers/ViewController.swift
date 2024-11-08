import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Variables
    var tasks: [ToDoModel] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Register TaskTableViewCell
        TaskTableViewCell.register(with: tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100 // Đây là giá trị ước tính chiều cao trước khi tự động tính toán
        
        /// Setup
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        /// Get all current saved tasks
        updateTasks()
    }
    
    // MARK: - Function update tasks
    func updateTasks() {
        tasks.removeAll()
        
        // Lấy `count` từ UserDefaults
        let count = UserDefaults.standard.integer(forKey: "count")
        guard count > 0 else {
            return
        }
        
        for i in 1...count {
            // Lấy dữ liệu kiểu `Data` từ UserDefaults
            if let taskData = UserDefaults.standard.data(forKey: "task_\(i)") {
                do {
                    let decoder = JSONDecoder()
                    let toDo = try decoder.decode(ToDoModel.self, from: taskData)
                    print("Tiêu đề công việc: \(toDo.title)")
                    tasks.append(toDo) // Giả sử `tasks` là mảng `ToDoModel`
                } catch {
                    print("Lỗi khi giải mã dữ liệu: \(error)")
                }
            }
        }
        
        tableView.reloadData()
    }
    
    
    // MARK: - Function add todo
    @IBAction func didTapAdd() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "createVC") as! CreateViewController
        // TODO: Handle With Closure
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
        let task = tasks[indexPath.row]
        cell.configure(with: task)
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditVC") as! EditViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // TODO: Tạo chức năng xoá khi trượt qua trái
}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
}

// TODO: Các chức năng
/**
 _ Tạo
 _ Cập nhật
 _ Xoá
 _ Hiển thị phân theo task
 _ Tìm kiếm todo theo tên, description
 _ Save to UserDefault
 */
