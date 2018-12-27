//
//  NetworkService.swift
//  betrating
//
//  Created by Yuriy borisov on 17.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit


typealias getForecastListCompletion = ([ForecastSmall]?) -> Void
typealias loadSinglePhotoCompletion = (UIImage?, Bool) -> Void
typealias getForecastByIdCompletion = (ForecastDetailed?) -> Void
typealias getRaitingsListCompletion = ([RaitingsList]?, Bool) -> Void
typealias getBookmakerByIDCompletion = (RatingByID?) -> Void
typealias getNewsListCompletion = ([NewsListItem]?) -> Void
typealias getNewsByIdCompletion = (NewsItem?) -> Void
//typealias getMatchesCompletion  = ([MatchesQueryQuery.Data.Match?]) -> Void


enum forecastCategories: String{
    case all = "Все"
    case soccer = "Футбол"
    case hockey = "Хоккей"
    case tennis = "Теннис"
    case basketball = "Баскетбол"
    
    func getCategory() -> String{
        switch self {
        case .all:
            return "all"
        case .soccer:
            return "soccer"
        case .hockey:
            return "hockey"
        case .tennis:
            return "tennis"
        case .basketball:
            return "basketball"
        }
        
    }
}
enum statisticsCategoryes: String{
    case soccer = "Футбол"
    case hockey = "Хоккей"
    case tennis = "Теннис"
    case basketball = "Баскетбол"
    
    func getCategory() -> String{
        switch self {
        case .soccer:
            return "soccer"
        case .hockey:
            return "ice-hockey"
        case .tennis:
            return "tennis"
        case .basketball:
            return "basketball"
        }
    }
}

class NetworkService{
    
    private let baseUrl = URL(string: "http://betrating.ru/mobileapi")
    let dateFormatter = DateFormatter()
    var session: URLSession{
        let conf = URLSessionConfiguration.default
        let sess = URLSession(configuration: conf)
        return sess
    }
    
    private func request(endPoint: String, completion: @escaping (Data) -> Void ) {
        guard let url = baseUrl?.appendingPathComponent(endPoint) else {
            print("Wrong url")
            return
        }
        let request = URLRequest(url: url)
        
        DispatchQueue.global(qos: .userInteractive).async {
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
    
    func getNewsById(id: Int, completion: @escaping getNewsByIdCompletion) {
        request(endPoint: "/news/\(id)") { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            let list = json as! [String : Any]
            let currentNews = NewsItem(json: list)
            DispatchQueue.main.async {
                completion(currentNews)
            }
        }
    }
    
    func getNewsList(completion: @escaping getNewsListCompletion){
        request(endPoint: "/news/0/50") { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            
            guard let list = json as? [[String : Any]] else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            let news = list.compactMap({NewsListItem(json: $0)})
            
            DispatchQueue.main.async {
                completion(news)
            }
        }
    }
    
    func getBookmakerByID(id: Int, completion: @escaping getBookmakerByIDCompletion){
        request(endPoint: "/bookmakers/\(id)") { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            let bookmaker = json as! [String: Any]
            
            let rate = RatingByID(json: bookmaker)
            DispatchQueue.main.async {
                completion(rate)
            }
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
                            completion(nil, true)
                        }                    }
                    return
                }
                let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                guard json != nil else{
                    print("Can not get json")
                    return
                }
                let list = json as! [[String:Any]]
                var raitings = [RaitingsList]()
                for item in list{
                    let rate = RaitingsList(json: item)
                    raitings.append(rate)
                }
                DispatchQueue.main.async {
                    completion(raitings, false)
                    
                }
            }
            task.resume()
        }
    }
    
    
    func getForecastList(category: forecastCategories, offset: Int, limit: Int, completion: @escaping getForecastListCompletion){
        request(endPoint: "/bets/\(category.getCategory())/\(offset)/\(limit)") { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            guard json != nil else{
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            guard let decodedJson = try? JSONDecoder().decode([ForecastSmall].self, from: data) else { return }
            
            DispatchQueue.main.async {
                completion(decodedJson)
            }
        }
    }
    
    func getForecastById2(_ id: Int, completion: @escaping getForecastByIdCompletion){
        request(endPoint: "/bets/\(id)") { data in
            
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            guard json != nil else{
                print("Invalid json")
                return
            }
            let list = json as! [String:Any]
            let forecast = ForecastDetailed(json: list)
            
            DispatchQueue.main.async {
                completion(forecast)
            }
        }
    }
    
    
    
    func loadImage(url: String?, completion: @escaping loadSinglePhotoCompletion){
        guard let str = url, let url = URL(string: str) else {
            completion(nil, false)
            return
        }
        let request = URLRequest(url: url)
        let queue = DispatchQueue.global(qos: .userInteractive)
        
        queue.async {
            let task = self.session.dataTask(with: request) { (data, response, error) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        completion(nil, true)
                    }
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        completion(nil, false)
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(image, false)
                }
            }
            task.resume()
        }
    }
}


