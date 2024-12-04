//
//  NewCourseViewController.swift
//  Alamofire
//
//  Created by Alexander Shevtsov on 22.11.2024.
//

import UIKit

final class NewCourseViewController: UIViewController {
    
    @IBOutlet var courseTitleTF: UITextField!
    @IBOutlet var numberOfLessonsTF: UITextField!
    @IBOutlet var numberOfTestsTF: UITextField!
    
    weak var delegate: NewCourseViewControllerDelegate? // слабая ссылка
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let course = Course(
            name: courseTitleTF.text ?? "Noname",
            imageUrl: Link.courseImageURL.url.absoluteString,
            numberOfLessons: Int(numberOfLessonsTF.text ?? "") ?? 0,
            numberOfTests: Int(numberOfTestsTF.text ?? "") ?? 0
        )
        delegate?.createCourse(course)
        dismiss(animated: true)
    }
 
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    dismiss(animated: true)
    }
}
