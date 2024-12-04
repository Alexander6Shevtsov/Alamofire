//
//  NetworkManager.swift
//  Alamofire
//
//  Created by Alexander Shevtsov on 23.11.2024.
//

import Foundation
import Alamofire

enum Link {
    case coursesURL
    case postRequest
    case courseImageURL
    
    var url: URL {
        switch self {
        case .coursesURL:
            return URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_courses")!
        case .postRequest:
            return URL(string: "https://jsonplaceholder.typicode.com/posts")!
        case .courseImageURL:
            return URL(string: "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png")!
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCourses(from url: URL, completion: @escaping (Result<[Course], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let jsonValue):
                    let courses = Course.getCourses(from: jsonValue)
                    completion(.success(courses))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { responseData in
                switch responseData.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func postCourse(to url: URL, with parameters: Course, completion: @escaping (Result<Course, AFError>) -> Void) {
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(encoder: JSONEncoder()))
            .validate()
            .responseDecodable(of: Course.self) { dataResponse in
                switch dataResponse.result {
                case .success(let course):
                    completion(.success(course))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
