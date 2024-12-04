//
//  CoursesViewController.swift
//  Alamofire
//
//  Created by Alexander Shevtsov on 22.11.2024.
//

import UIKit

protocol NewCourseViewControllerDelegate: AnyObject {
    func createCourse(_ course: Course)
}

final class CoursesViewController: UITableViewController {
    
    private var courses: [Course] = []
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        fetchCourses()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let newCourseVC = navigationVC.topViewController as? NewCourseViewController else { return }
        newCourseVC.delegate = self
    }
    
    private func fetchCourses() {
        networkManager.fetchCourses(from: Link.coursesURL.url) { [unowned self] result in
            switch result {
            case .success(let courses):
                self.courses = courses
                tableView.reloadData()
            case .failure(let error):
                showAlert(withTitle: "Oops...", andMessage: error.localizedDescription)
            }
        }
    }
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}

// MARK: - UITableViewDataSource
extension CoursesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count // кол строк зависит от кол элем в массиве
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
        let course = courses[indexPath.row]
        cell.configure(with: course)
        return cell
    }
}

// MARK: - NewCourseViewControllerDelegate
extension CoursesViewController: NewCourseViewControllerDelegate {
    func createCourse(_ course: Course) {
        networkManager.postCourse(to: Link.postRequest.url, with: course) { [unowned self] result in
            switch result {
            case .success(let course):
                courses.append(course)
                let indexPath = IndexPath(row: courses.count - 1, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            case .failure(let error):
                showAlert(withTitle: "Oops...", andMessage: error.localizedDescription)
            }
        }
    }
}
