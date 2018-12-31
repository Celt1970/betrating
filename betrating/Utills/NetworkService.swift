//
//  NetworkService.swift
//  betrating
//
//  Created by Yuriy borisov on 17.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit

typealias getForecastListCompletion = ([ForecastListItem]?) -> Void
typealias loadSinglePhotoCompletion = (UIImage) -> Void
typealias getForecastByIdCompletion = (ForecastByIdItem?) -> Void
typealias getRaitingsListCompletion = ([BookmakersListItem2]?) -> Void
typealias getBookmakerByIDCompletion = (BookmakerById?) -> Void
typealias getNewsListCompletion = ([NewsListItem]?) -> Void
typealias getNewsByIdCompletion = (NewsByIdItem?) -> Void

class NetworkService{
    
    private let baseUrl = URL(string: "http://betrating.ru/mobileapi")
    private let dateFormatter = DateFormatter()
    private let decoder = JSONDecoder()
    private var session: URLSession{
        let conf = URLSessionConfiguration.default
        let sess = URLSession(configuration: conf)
        return sess
    }
    
    private func request(url: URL,queue: DispatchQueue, completion: @escaping (Data) -> Void) {
        let request = URLRequest(url: url)
        queue.async {
            let task = self.session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let data = data else { return }
                DispatchQueue.main.async {
                    completion(data)
                }
            }
            task.resume()
        }
    }
    
    
    private func dataRequest <T:Decodable> (endPoint: String, type: T.Type, completion: @escaping (T) -> Void ) {
        guard let url = baseUrl?.appendingPathComponent(endPoint) else {
            print("Wrong url")
            return
        }
        let queue = DispatchQueue.global(qos: .userInteractive)
        request(url: url, queue: queue) { data in
            guard let decoded = try? self.decoder.decode(type, from: data) else {
                print("Invalid JSON")
                return
            }
            DispatchQueue.main.async {
                completion(decoded)
            }
        }
    }
    
    func getNewsById(id: Int, completion: @escaping getNewsByIdCompletion) {
        dataRequest(endPoint: "/news/\(id)", type: NewsByIdItem.self) { data in
            completion(data)
        }
    }
    
    func getNewsList(completion: @escaping getNewsListCompletion){
        dataRequest(endPoint: "/news/0/20", type: [NewsListItem].self) { data in
            completion(data)
        }
    }
    
    func getBookmakerByID(id: Int, completion: @escaping getBookmakerByIDCompletion){
        dataRequest(endPoint: "/bookmakers/\(id)", type: BookmakerById.self) { data in
            completion(data)
        }
    }
    
    func getBookmakersList(completion: @escaping getRaitingsListCompletion){
        dataRequest(endPoint: "bookmakers/list/?legal=0&rating=&russian_language=0&russian_support=0&currencies=&live=0&bonus=0&has_professional=0&has_demo=0&has_betting=0&has_mobile_mode=0", type: [BookmakersListItem2].self) { data in
            completion(data)
        }
    }
    
    func getForecastList(category: ForecastCategories, offset: Int, limit: Int, completion: @escaping getForecastListCompletion){
        dataRequest(endPoint: "/bets/\(category.getCategory())/\(offset)/\(limit)", type: [ForecastListItem].self) { data in
            completion(data)
        }
    }
    
    func getForecastById(_ id: Int, completion: @escaping getForecastByIdCompletion){
        dataRequest(endPoint: "/bets/\(id)", type: ForecastByIdItem.self) { data in
            completion(data)
        }
    }
    
    func loadImage(url: URL?, completion: @escaping loadSinglePhotoCompletion){
        guard let url = url else {
            print("Invalid URL")
            return
        }
        let queue = DispatchQueue.global(qos: .userInteractive)
        request(url: url, queue: queue) { data in
            guard let image = UIImage(data: data) else {
                print("Can't make image from data")
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}


