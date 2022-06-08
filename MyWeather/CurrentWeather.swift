//
//  CurrentWeather.swift
//  MyWeather
//
//  Created by Rail on 31.05.2022.
//

import Foundation

class CurrentWeather {
    
    //    Текущая температура
    let temp: Int
    var currentTemperature: String {
        //        Поскольку наш Лейбл принимает только значения Стринг, преобразуем значение температуры в Стринг. Возвращаем форматированную строку
        return String(temp)
    }
    //    Ощущаемая температура
    let feelsLike: Int
    var currentFeelsTemperature: String {
        return String(feelsLike)
    }
    //    Давление
    let pressureMm: Int
    var currentPressure: String {
        return String(pressureMm)
    }
    //    Скорость ветра
    let windSpeed: Int
    var currentSpeedWind: String {
        return String(windSpeed)
    }
    //    Погодные условия
    let condition: String
    //    Полные погодные условия
    let phenomCondition: String
    
    init?(currentWeatherData: CurrrentWeatherData) {
        temp = currentWeatherData.fact.temp
        feelsLike = currentWeatherData.fact.feelsLike
        pressureMm = currentWeatherData.fact.pressureMm
        windSpeed = currentWeatherData.fact.windSpeed
        condition = currentWeatherData.fact.condition
        phenomCondition = currentWeatherData.fact.phenomCondition
    }
}
