//
//  CurrentWeatherData.swift
//  MyWeather
//
//  Created by Rail on 31.05.2022.
//

import Foundation

//   Модель ответа с сервера
struct CurrrentWeatherData: Codable {
    
    let fact: Fact
    
    enum CodingKeys: CodingKey {
        case fact
    }
}

struct Fact: Codable {
    let temp: Int
    let feelsLike: Int
    let condition: String
    let windSpeed: Int
    let pressureMm: Int
    let phenomCondition: String
    
    enum CodingKeys: String, CodingKey {
        case temp
        //    Если мы хотим изменить имя ключа н/п feels_like, то можем использовать enum. таким образом показываем замену со snake case на camel case
        case feelsLike = "feels_like"
        case condition
        case windSpeed = "wind_speed"
        case pressureMm = "pressure_mm"
        case phenomCondition = "phenom-condition"
    }
}


