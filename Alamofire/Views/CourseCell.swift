//
//  CourseCell.swift
//  Alamofire
//
//  Created by Alexander Shevtsov on 22.11.2024.
//

import UIKit

final class CourseCell: UITableViewCell {
    
    @IBOutlet var courseImage: UIImageView!
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var numberOfLessons: UILabel!
    @IBOutlet var numberOfTests: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with course: Course) {
        courseNameLabel.text = course.name
        numberOfLessons.text = "Number of lessons: \(course.numberOfLessons)"
        numberOfTests.text = "Number of tests: \(course.numberOfTests)"
        
        networkManager.fetchData(from: course.imageUrl) { [unowned self] result in
            switch result {
            case .success(let imageData):
                courseImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
