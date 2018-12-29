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
    
    func setConnectionsPerHost(_ value: Int) {
        session.configuration.httpMaximumConnectionsPerHost = value
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
    
    func getBookmakersList(filters: [[Int]], completion: @escaping getRaitingsListCompletion){
        var rating: String{
            let firstStar = filters[1][0] == 1 ? "1," : ""
            let secondStar = filters[1][1] == 1 ? "2," : ""
            let thirdStar = filters[1][2] == 1 ? "3," : ""
            let fourthStar = filters[1][3] == 1 ? "4," : ""
            let fifthStar = filters[1][4] == 1 ? "5," : ""
            var str =  firstStar  + secondStar  + thirdStar  + fourthStar + fifthStar
            if str != ""{
                str.removeLast()
            }
            return str
        }
        var currencies: String{
            let rub = filters[4][0] == 1 ? "RUB," : ""
            let usd = filters[4][1] == 1 ? "USD," : ""
            let eur = filters[4][2] == 1 ? "EUR," : ""
            
            var str = rub + usd + eur
            if str != ""{
                str.removeLast()
            }
            return str
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "betrating.ru"
        urlComponents.path = "/mobileapi/bookmakers/list/"
        urlComponents.queryItems = [
            URLQueryItem(name: "legal", value: filters[0][0] == 1 ? "1" : "0"),
            URLQueryItem(name: "rating", value: rating),
            URLQueryItem(name: "russian_language", value: filters[2][0] == 1 ? "1" : "0"),
            URLQueryItem(name: "russian_support", value: filters[3][0] == 1 ? "1" : "0"),
            URLQueryItem(name: "currencies", value: currencies),
            URLQueryItem(name: "live", value: filters[5][0] == 1 ? "1" : "0"),
            URLQueryItem(name: "bonus", value: filters[6][0] == 1 ? "1" : "0"),
            URLQueryItem(name: "has_professional", value: filters[7][0] == 1 ? "1" : "0"),
            URLQueryItem(name: "has_demo", value: filters[8][0] == 1 ? "1" : "0"),
            URLQueryItem(name: "has_betting", value: filters[9][0] == 1 ? "1" : "0"),
            URLQueryItem(name: "has_mobile_mode", value: filters[10][0] == 1 ? "1" : "0")
        ]
        guard let url = urlComponents.url else {
            print("invalid url")
            return
        }
        
        print(url.absoluteString)
        let request = URLRequest(url: url)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        DispatchQueue.global(qos: .userInteractive).async {
            let task = session.dataTask(with: request){ (data, response, error) in
                if error != nil{
                    let err = error as NSError?
                    if err?.code == NSURLErrorNotConnectedToInternet || err?.domain == NSURLErrorDomain{
                        print("\(err?.localizedDescription ?? "no error data")")
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                    return
                }
                guard let data = data, let decoded = try? self.decoder.decode([BookmakersListItem2].self, from: data) else {
                    print("Invalid JSON")
                    return
                }
                DispatchQueue.main.async {
                    completion(decoded)
                }
            }
            task.resume()
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
    
    func loadImageInBackground(url: URL?, completion: @escaping loadSinglePhotoCompletion){
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


