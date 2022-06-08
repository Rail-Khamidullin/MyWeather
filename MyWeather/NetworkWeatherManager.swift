//
//  NetworkWeatherManager.swift
//  MyWeather
//
//  Created by Rail on 31.05.2022.
//

import Foundation
import UIKit
import CoreLocation

class NetworkWeatherManager {
    
    //    Создаём клоужер, который принимает структуру CurrentWeather
    var onCompletion: ((CurrentWeather) -> ())?
    
    //    Запрос погоды в зависимости от локации или запроса города
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
        
    }
    //    Определяем запрос по городу или расположению устройства
    func fetchCurrentWeather(forRequstType requestType: RequestType) {
        
        var urlString = ""
        
        switch requestType {
        case .cityName(city: let city):
            
            urlString = "https://api.weather.yandex.ru/v2/forecast?\(city)&lang=ru_RU"
            
            
        case .coordinate(let latitude, let longitude):
            
            urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)&lang=ru_RU"
            
        }
        //        Полученную строку вставляем в метод и получаем данные
        requestWeather(withURLString: urlString)
    }
    
    //     GET запрос для получения погоды по АПИ
    func requestWeather(withURLString urlString: String) {
        //        Проверяем на валидность
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        //        API яндекс погоды требует запроса погоды с помощью Header
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = ["X-Yandex-API-Key": "\(apiKey)", "Content-Type": "application/json"]
        
        //        Создаём сессию
        let session = URLSession(configuration: .default)
        //        Достаём информацию по url
        session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            
//            Принт показывает что информация от сервера пришла, а вот дальше не понимаю, почему она не обновляется в интерфейсе!!!!
            let dataString = String(data: data, encoding: .utf8)
            print(dataString ?? "NO")

            //            Полученные данные парсим и передаём в готовую таблицу
            if let currentWeather = self.parseJSON(data: data) {
                
                self.onCompletion?(currentWeather)
            }
        }.resume()
    }
    //    Парсим данные
    func parseJSON(data: Data) -> CurrentWeather? {
        
        let jsonDecoder = JSONDecoder()
        
        do {
            let currentWeatherData = try jsonDecoder.decode(CurrrentWeatherData.self, from: data)
            
            
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            
            print(currentWeather.feelsLike)
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
