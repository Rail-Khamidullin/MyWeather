//
//  View.swift
//  MyWeather
//
//  Created by Rail on 30.05.2022.
//

import Foundation
import UIKit
import SnapKit

class MyView {
    
    //    Скролл Вью
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    //    Фон экрана
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "Afternoon")
        return imageView
    }()
    //    Лейбл с рисунком обозначающую погоду
    var weatherIconImageView: UIImageView = {
        let weatherIconImageView = UIImageView()
        weatherIconImageView.image = UIImage.init(systemName: "nosign")
        weatherIconImageView.tintColor = UIColor.init(named: "Color")
        return weatherIconImageView
    }()
    
    var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    
    //    Стек для температуры
    var tempStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    //    Температура
    var tempLable: UILabel = {
        let tempLable = UILabel()
        tempLable.text = "Температура, °C"
        tempLable.font = UIFont.systemFont(ofSize: 20)
        tempLable.textColor = UIColor.init(named: "Color")
        return tempLable
    }()
    
    //    Текущая температура
    var tempCurrentLable: UILabel = {
        let tempLable = UILabel()
        tempLable.text = "23"
        tempLable.font = UIFont.systemFont(ofSize: 20)
        tempLable.textColor = UIColor.init(named: "Color")
        return tempLable
    }()
    
    //    Стек для ощущаемой температуры
    var feelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    //    Ощущаемая температура
    var feelsTempLable: UILabel = {
        let feelsTempLable = UILabel()
        feelsTempLable.text = "Ощущается, °C"
        feelsTempLable.font = UIFont.systemFont(ofSize: 20)
        feelsTempLable.textColor = UIColor.init(named: "Color")
        return feelsTempLable
    }()
    
    //    Текущая щущаемая температура
    var feelsCurrentTempLable: UILabel = {
        let feelsTempLable = UILabel()
        feelsTempLable.text = "25"
        feelsTempLable.font = UIFont.systemFont(ofSize: 20)
        feelsTempLable.textColor = UIColor.init(named: "Color")
        return feelsTempLable
    }()
    
    //    Стек для давления
    var pressureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    //    Атмосферное давление
    var pressureLable: UILabel = {
        let pressureLable = UILabel()
        pressureLable.text = "Давление, гПа"
        pressureLable.font = UIFont.systemFont(ofSize: 20)
        pressureLable.textColor = UIColor.init(named: "Color")
        return pressureLable
    }()
    
    //    Текущее атмосферное давление
    var pressureCurrentLable: UILabel = {
        let pressureLable = UILabel()
        pressureLable.text = "746"
        pressureLable.font = UIFont.systemFont(ofSize: 20)
        pressureLable.textColor = UIColor.init(named: "Color")
        return pressureLable
    }()
    
    //    Стек для ветра
    var windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    //    Скорость ветра
    var windLable: UILabel = {
        let windLable = UILabel()
        windLable.text = "Скорость ветра, м/с"
        windLable.font = UIFont.systemFont(ofSize: 20)
        windLable.textColor = UIColor.init(named: "Color")
        return windLable
    }()
    
    //    Текущая скорость ветра
    var windCurrentLable: UILabel = {
        let windLable = UILabel()
        windLable.text = "5"
        windLable.font = UIFont.systemFont(ofSize: 20)
        windLable.textColor = UIColor.init(named: "Color")
        return windLable
    }()
    
    //    Описание погоды
    var condition: UILabel = {
        let condition = UILabel()
        condition.text = "Описание"
        condition.font = UIFont.systemFont(ofSize: 20)
        condition.textColor = UIColor.init(named: "Color")
        return condition
    }()
    //    Полное описание погоды
    var phenomCondition: UILabel = {
        let phenomCondition = UILabel()
        phenomCondition.text = "Полное описание "
        phenomCondition.numberOfLines = 0
        phenomCondition.font = UIFont.systemFont(ofSize: 20)
        phenomCondition.textColor = UIColor.init(named: "Color")
        return phenomCondition
    }()
    //    Поле для ввода города
    var cityTextField: UITextField = {
        let cityTextField = UITextField()
        cityTextField.placeholder = "Введите город"
        cityTextField.textAlignment = .center
        cityTextField.font = UIFont.systemFont(ofSize: 20)
        cityTextField.backgroundColor = .white
        cityTextField.textColor = .init(red: 0.3, green: 0.4, blue: 0.5, alpha: 1)
        cityTextField.layer.borderWidth = 2
        cityTextField.layer.borderColor = UIColor.systemGray6.cgColor
        cityTextField.layer.cornerRadius = 10
        return cityTextField
    }()
    //    Кнопка поиска погоды
    var searchWeatherButton: UIButton = {
        let searchWeatherButton = UIButton(type: .system)
        searchWeatherButton.setTitle("Поиск", for: [])
        searchWeatherButton.titleLabel?.font = .systemFont(ofSize: 20)
//        searchWeatherButton.setTitleColor(.placeholderText, for: .normal)
        searchWeatherButton.backgroundColor = .white
        searchWeatherButton.tintColor = .init(red: 0.3, green: 0.4, blue: 0.5, alpha: 1)
        searchWeatherButton.layer.borderWidth = 1
        searchWeatherButton.layer.borderColor = UIColor.blue.cgColor
        searchWeatherButton.layer.cornerRadius = 10
        return searchWeatherButton
    }()
}

