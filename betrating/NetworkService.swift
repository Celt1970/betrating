//
//  NetworkService.swift
//  betrating
//
//  Created by Yuriy borisov on 17.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit
import Apollo


typealias getForecastListCompletion = ([ForecastSmall]?, Bool) -> Void
typealias loadSinglePhotoCompletion = (UIImage?, Bool) -> Void
typealias getForecastByIdCompletion = (ForecastDetailed?, Bool) -> Void
typealias getRaitingsListCompletion = ([RaitingsList]?, Bool) -> Void
typealias getBookmakerByIDCompletion = (RatingByID?, Bool) -> Void
typealias getNewsListCompletion = ([NewsListItem]?, Bool) -> Void
typealias getNewsByIdCompletion = (NewsItem?, Bool) -> Void
typealias getMatchesCompletion  = ([MatchesQueryQuery.Data.Match?]) -> Void


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
    private let urlSession: URLSession
    let dateFormatter = DateFormatter()
    var session1: URLSession{
        let conf = URLSessionConfiguration.default
        let sess = URLSession(configuration: conf)
        return sess
    }
    
    init(session: URLSession) {
        self.urlSession = session
    }
    
    func fetchMatches(category: statisticsCategoryes, completion: @escaping getMatchesCompletion){

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let startWeek = Date().startOfWeek
        let endWeek = Date().endOfWeek
        

        let matchesQuery = MatchesQueryQuery(sport_slug: "\(category.getCategory())", this_week: dateFormatter.string(from: startWeek!), next_week: dateFormatter.string(from: endWeek! - 1) , limit: 100, offset: 0)
        
        DispatchQueue.global(qos: .userInteractive).async {
            apollo.fetch(query: matchesQuery){ result, error in
                if let error = error {
                    print("error: \(error)")
                    return
                }
                guard let matches = result?.data?.match else{
                    print("error 2 ")
                    return
                }
                completion(matches)
                
            }
        }
        
    }
    
    func getNewsByID(id: Int, completion: @escaping getNewsByIdCompletion){
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "betrating.ru"
        urlComponents.path = "/mobileapi/news/\(id)"
        guard let url = urlComponents.url else {
            print("invalid url")
            return
        }
        
        let request = URLRequest(url:url )
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        DispatchQueue.global(qos: .userInteractive).async {
            let task = session.dataTask(with: request) { (data, response, error) in
               if error != nil{
                    let err = error as NSError?
                    if err?.code == NSURLErrorNotConnectedToInternet || err?.domain == NSURLErrorDomain{
                        print("\(err?.localizedDescription ?? "no error data")")
                        DispatchQueue.main.async {
                            completion(nil, true)
                        }
                    }
                    return
                }
                guard data != nil else { return }
                
                let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                
                
                
                let list = json as! [String : Any]
                let currentNews = NewsItem(json: list)
                DispatchQueue.main.async {
                    completion(currentNews, false)
                }
            }
            task.resume()
        }
    }
    
    func getNewsList(completion: @escaping getNewsListCompletion){
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "betrating.ru"
        urlComponents.path = "/mobileapi/news/0/50"
        guard let url = urlComponents.url else {
            print("invalid url")
            return
        }
        
        let request = URLRequest(url:url )
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
                        }
                    }
                    return
                }
                guard data != nil else { return }
                
                let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)

                guard let list = json as? [[String : Any]] else {
                    DispatchQueue.main.async {
                        completion(nil, true)
                    }
                    return
                }
                let news = list.flatMap({NewsListItem(json: $0)})
                
                DispatchQueue.main.async {
                    completion(news, false)
                }
            }
            task.resume()
        }
    }
    
    func getBookmakerByID(id: Int, completion: @escaping getBookmakerByIDCompletion){
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "betrating.ru"
        urlComponents.path = "/mobileapi/bookmakers/\(id)/"
        
        guard let url = urlComponents.url else {
            print("invalid url")
            return
        }
        
        let request = URLRequest(url:url )
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        DispatchQueue.global(qos: .userInteractive).async {
            let task = session.dataTask(with: request) { (data, response, error) in
                if error != nil{
                    let err = error as NSError?
                    if err?.code == NSURLErrorNotConnectedToInternet || err?.domain == NSURLErrorDomain{
                        print("\(err?.localizedDescription ?? "no error data")")
                        DispatchQueue.main.async {
                            completion(nil, true)
                        }                    }
                    return
                }
                guard data != nil else { return }
                
                let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                let bookmaker = json as! [String: Any]
                
                let rate = RatingByID(json: bookmaker)
                DispatchQueue.main.async {
                    completion(rate, false)
                }
                
            }
            task.resume()
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
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "betrating.ru"
        urlComponents.path = "/mobileapi/bets/\(category.getCategory())/\(offset)/\(limit)"
        
        
        guard let url = urlComponents.url else {
            print("invalid url")
            return
        }
        let request = URLRequest(url: url)
        
//        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration)
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async {
            let task = self.urlSession.dataTask(with: request) { (data, response, error) in
                
                if error != nil{
                    let err = error as NSError?
                    if err?.code == NSURLErrorNotConnectedToInternet || err?.domain == NSURLErrorDomain{
                        print("\(err?.localizedDescription ?? "no error data")")
                        DispatchQueue.main.async {
                            completion(nil, true)
                        }
                    }
                    return
                }
                let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                guard json != nil else{
                    DispatchQueue.main.async {
                        completion(nil, false)
                    }
                    return
                }
                let list = json as! [[String:Any]]
                var forecasts = [ForecastSmall]()
                for item in list{
                    let forecast = ForecastSmall(json: item)
                    forecasts.append(forecast)
                }
                DispatchQueue.main.async {
                    completion(forecasts, false)
                }
            }
            task.resume()
        }
    }
    
    func getForecastById(_ id: Int, completion: @escaping getForecastByIdCompletion){
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "betrating.ru"
        urlComponents.path = "/mobileapi/bets/\(id)"
        
        guard let url = urlComponents.url else {
            print("invalid url")
            return
        }
        let request = URLRequest(url: url)
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        DispatchQueue.global(qos: .userInteractive).async {
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil{
                    let err = error as NSError?
                    if err?.code == NSURLErrorNotConnectedToInternet || err?.domain == NSURLErrorDomain{
                        print("\(err?.localizedDescription ?? "no error data")")
                        DispatchQueue.main.async {
                            completion(nil, true)
                        }                    }
                    //                    print("Error occured, response code: \(response), error: \(err.localizedDescription)")
                    return
                }
                let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                guard json != nil else{
                    print("Can not get json")
                    return
                }
                let list = json as![String:Any]
                let forecast = ForecastDetailed(json: list)
                
                DispatchQueue.main.async {
                    completion(forecast, false)
                }
            }
            task.resume()
        }
        
        
    }
    
    func loadImage(url: String?, completion: @escaping loadSinglePhotoCompletion){
        if url == nil{
            completion(nil, false)
            return
        }
        let remoteURL = URL(string: "\(url!)")
        guard  remoteURL != nil else {
            completion(nil, false)
            print("not this time, url: \(url ?? "")")
            return
            
        }
        
        let request = URLRequest(url: remoteURL!)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let queue = DispatchQueue.global(qos: .userInteractive)
        
        queue.async {
            let task = session.dataTask(with: request) { (data, response, error) -> Void in
                if error != nil{
                    let err = error as NSError?
                    if err?.code == NSURLErrorNotConnectedToInternet || err?.domain == NSURLErrorDomain{
                        print("\(err?.localizedDescription ?? "no error data")")
                        DispatchQueue.main.async {
                            completion(nil, true)
                        }
                    }
                    return
                }
                let image = UIImage(data: data!)
                if image != nil{
                    DispatchQueue.main.async {
                        completion(image, false)
                    }
                }else{
                    DispatchQueue.main.async {
                        completion(nil, false)
                    }
                }
            }
            task.resume()
        }
    }
}

