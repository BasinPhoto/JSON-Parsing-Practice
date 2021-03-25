//
//  APIManager.swift
//  JSON Parsing Practice
//
//  Created by Sergey Basin on 25.03.2021.
//

import Foundation

enum ApiType {
    
    case login
    case getUsers
    case getPosts
    case getAlbums
    
    //базовый УРЛ
    var baseUrl: String {
        return "https://jsonplaceholder.typicode.com/"
    }
    
    //хедеры
    var headers: [String: String] {
        switch self {
            case .login:
                return ["authToken": "12345"]
        default:
            return [:]
        }
    }
    
    //путь запроса
    var path: String {
        switch self {
        case .login:
            return "login"
        case .getUsers:
            return "users"
        case .getPosts:
            return "posts"
        case .getAlbums:
            return "albums"
        }
    }
    
    //формируем запрос
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseUrl)!)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        switch self {
        case .login:
            request.httpMethod = "POST"
            return request
        default:
            request.httpMethod = "GET"
            return request
        }
    }
}

class APImanager {
    static let shared = APImanager()
    
    func getUsers(completion: @escaping (Users) -> Void) {
        let request = ApiType.getUsers.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let users = try? JSONDecoder().decode(Users.self, from: data) {
                completion(users)
            } else {
                completion([])
            }
        }
        task.resume()
    }
    
    func getPosts(completion: @escaping (Posts) -> Void) {
        let request = ApiType.getPosts.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let posts = try? JSONDecoder().decode(Posts.self, from: data) {
                completion(posts)
            } else {
                completion([])
            }
        }
        task.resume()
    }
    
    func getAlbums(completion: @escaping (Albums) -> Void) {
        let request = ApiType.getAlbums.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let albums = try? JSONDecoder().decode(Albums.self, from: data) {
                completion(albums)
            } else {
                completion([])
            }
        }
        task.resume()
    }
}
