//
//  Course.swift
//  Alamofire
//
//  Created by Alexander Shevtsov on 22.11.2024.
//

struct Course: Codable {
    let name: String
    let imageUrl: String // проще передать String а не URL
    let numberOfLessons: Int
    let numberOfTests: Int
    
    init(name: String, imageUrl: String, numberOfLessons: Int, numberOfTests: Int) {
        self.name = name
        self.imageUrl = imageUrl
        self.numberOfLessons = numberOfLessons
        self.numberOfTests = numberOfTests
    }
    
    init(courseData: [String: Any]) {
        name = courseData["name"] as? String ?? ""// приводим к стринг
        imageUrl = courseData["imageUrl"] as? String ?? ""
        numberOfLessons = courseData["number_of_lessons"] as? Int ?? 0
        numberOfTests = courseData["number_of_tests"] as? Int ?? 0
    }
    
    static func getCourses(from jsonValue: Any) -> [Course] {
        guard let coursesData = jsonValue as? [[String: Any]] else { return [] }
        return coursesData.map { Course(courseData: $0) } // функция вместо кода внизу 

//        var courses: [Course] = []
//
//        for courseData in coursesData {
//            let course = Course(courseData: courseData)
//            courses.append(course)
//        }
//        
//        return courses
    }
}
