//
//  ViewController.swift
//  MyWeather
//
//  Created by Rail on 30.05.2022.
//

import UIKit
import SnapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //    Скролл
    var scrollView = UIScrollView()
    //    Основная вьюшка на весь экран
    var imageView = UIImageView()
    //    Картинка отображения погодных условий
    var weatherIconImageView = UIImageView()
    //    Главный стек
    var mainStackView = UIStackView()
    //    Стек для температуры
    var tempStackView = UIStackView()
    //    Лейбл температуры
    var tempLable = UILabel()
    //    Текущая температура
    var tempCurrentLable = UILabel()
    //    Стек для ощущаемой температуры
    var feelsStackView = UIStackView()
    //    Ощущаемая температура
    var feelsTempLable = UILabel()
    //    Текущая ощущаемая температура
    var feelsCurrentTempLable = UILabel()
    //    Стек для давления
    var pressureStackView = UIStackView()
    //    Атмосферное давление
    var pressureLable = UILabel()
    //    Текущее давление
    var pressureCurrentLable = UILabel()
    //    Стек для ветра
    var windStackView = UIStackView()
    //    Скорость ветра
    var windLable = UILabel()
    //    Текущая скорость ветра
    var windCurrentLable = UILabel()
    //    Погодное описание
    var condition = UILabel()
    //    Полное описание погоды
    var phenomCondition = UILabel()
    //    Поле для ввода города
    var cityTextField = UITextField()
    //    Кнопка поиска погоды
    var searchWeatherButton = UIButton(type: .system)
    
    //    Инициализируем Вью
    var myView: MyView? {
        didSet {
            guard let myView = myView else { return }
            self.scrollView = myView.scrollView
            self.imageView = myView.imageView
            self.weatherIconImageView = myView.weatherIconImageView
            self.mainStackView = myView.mainStackView
            self.tempStackView = myView.tempStackView
            self.tempLable = myView.tempLable
            self.tempCurrentLable = myView.tempCurrentLable
            self.feelsStackView = myView.feelsStackView
            self.feelsTempLable = myView.feelsTempLable
            self.feelsCurrentTempLable = myView.feelsCurrentTempLable
            self.pressureStackView = myView.pressureStackView
            self.pressureLable = myView.pressureLable
            self.pressureCurrentLable = myView.pressureCurrentLable
            self.windStackView = myView.windStackView
            self.windLable = myView.windLable
            self.windCurrentLable = myView.windCurrentLable
            self.condition = myView.condition
            self.phenomCondition = myView.phenomCondition
            self.cityTextField = myView.cityTextField
            self.searchWeatherButton = myView.searchWeatherButton
        }
    }
    
    //    Создаём экземпляр класса
    let networkWeatherManager = NetworkWeatherManager()
    
    //    Создаём менеджера, который будет с приставкой lazy. Если пользователь откажет в предоставлении месторасположения, методы не будут находиться в памяти
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        //        Необходимо указать точность с которой мы хотим получать информацию. kCLLocationAccuracyKilometer укзывает на точность в километр
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        //        Запрашиваем пользователя к доступу его геопозиции
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        myView = MyView()
        addObjectView()
        configureView()
        tapGester()
        connectToNotificationCenter()
        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }
        
        //        Создаём метод по нажатию на кнопку
        searchWeatherButton.addTarget(self, action: #selector(myButtonPressed(_:)), for: .touchUpInside)
        
        //        У networkWeatherManager вызываем метод по получение данных погоды. У пользователя может быть отключено настройки геопозиции (общая настройка в телефоне), для этого проверяем locationServicesEnabled
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
    
    //    Поиск погоды по нажатию на кнопку
    @objc func myButtonPressed(_ sender: UIButton) {
        broadcastText { [unowned self] (city) in
            self.networkWeatherManager.fetchCurrentWeather(forRequstType: .cityName(city: city))
        }
    }
    
    //    Обновление интерфейса после получения данных из сети через асинхронную очередь
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.tempLable.text = weather.currentTemperature
            self.feelsTempLable.text = weather.currentFeelsTemperature
            self.pressureLable.text = weather.currentPressure
            self.windLable.text = weather.currentSpeedWind
            self.condition.text = weather.condition
            self.phenomCondition.text = weather.phenomCondition
        }
    }
}

