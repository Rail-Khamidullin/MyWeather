//
//  ExtensionViewController.swift
//  MyWeather
//
//  Created by Rail on 31.05.2022.
//

import Foundation
import UIKit
import CoreLocation

extension ViewController {
    
    //    Добавление объектов на экран
    func addObjectView() {
        view.addSubview(scrollView)
        view.backgroundColor = .white
        scrollView.addSubview(imageView)
        scrollView.addSubview(weatherIconImageView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(tempStackView)
        mainStackView.addArrangedSubview(feelsStackView)
        mainStackView.addArrangedSubview(pressureStackView)
        mainStackView.addArrangedSubview(windStackView)
        tempStackView.addArrangedSubview(tempLable)
        tempStackView.addArrangedSubview(tempCurrentLable)
        feelsStackView.addArrangedSubview(feelsTempLable)
        feelsStackView.addArrangedSubview(feelsCurrentTempLable)
        pressureStackView.addArrangedSubview(pressureLable)
        pressureStackView.addArrangedSubview(pressureCurrentLable)
        windStackView.addArrangedSubview(windLable)
        windStackView.addArrangedSubview(windCurrentLable)
        mainStackView.addSubview(condition)
        mainStackView.addSubview(phenomCondition)
        scrollView.addSubview(cityTextField)
        scrollView.addSubview(searchWeatherButton)
    }
    
    //    Расположение объектов на экране
    func configureView() {
        //        Скролл
        scrollView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.centerX.centerY.equalToSuperview()
            maker.width.equalToSuperview()
        }
        //        Фон
        imageView.snp.makeConstraints { (maker) in
            maker.left.right.top.bottom.equalToSuperview()
            maker.centerX.centerY.equalToSuperview()
        }
        //                Иконка с погодой
        weatherIconImageView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().inset(20)
            maker.centerX.equalToSuperview()
            maker.height.width.equalTo(140)
        }
        //        Главный стек
        mainStackView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().inset(20)
            maker.top.equalTo(weatherIconImageView.snp.bottom).offset(5)
            maker.width.equalTo(280)
            maker.height.equalTo(111)
        }
        //        Температура
        tempLable.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Ощущаемая температура
        feelsTempLable.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Давление
        pressureLable.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Скорость ветра
        windLable.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Описание
        condition.snp.makeConstraints { (maker) in
            maker.top.equalTo(mainStackView.snp.bottom).offset(5)
            maker.left.equalToSuperview()
        }
        //        Полное описание
        phenomCondition.snp.makeConstraints { (maker) in
            maker.top.equalTo(condition.snp.bottom).offset(5)
            maker.left.equalToSuperview()
        }
        //        Поле для ввода города
        cityTextField.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.left.right.equalToSuperview().inset(20)
            maker.top.equalTo(phenomCondition.snp.bottom).offset(20)
        }
        //        Кнопка поиска погоды
        searchWeatherButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(cityTextField.snp.bottom).offset(20)
            maker.width.equalTo(100)
            maker.height.equalTo(28)
            maker.centerX.equalToSuperview()
        }
    }
}

extension ViewController {
    
    //    Скрытие клавиатуры по нажатию на экран вне площади клавиатуры
    func tapGester() {
        
        let tapGesterRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        
        view.addGestureRecognizer(tapGesterRecognizer)
        
        cityTextField.addTarget(self, action: #selector(keyboardWillHide), for: .primaryActionTriggered)
        
    }
    //    Центр обновлений для открытия или скрытия клавиатуры по нажатию на кнопку готово на клавиатуре
    func connectToNotificationCenter() {
        //        Открытие клавиатуры
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow(_:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        //        Скрытие клавиатуры
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    //    Открытие клавиатуры с поднятием контента на высоту клавиатуры
    @objc func keyboardDidShow(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
              let keyboardHeihgt = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        scrollView.contentInset.bottom = keyboardHeihgt.height + 10
    }
    //    Скрытие клавиатуры
    @objc func keyboardWillHide() {
        
        scrollView.contentInset.bottom = 0
        view.endEditing(true)
    }
    
    //    Достаём текст из текстового поля, если оно есть и передаём его
    func broadcastText(completion: @escaping (String) -> ()) {
        
        guard let cityName = cityTextField.text else { return }
        
        if cityName != "" {
            print(cityName)
            //            Метод который соединяет слова в одно, для понимания поиска городов состоящих из более чем 1 слово
            let city = cityName.split(separator: " ").joined(separator: "%20")
            return completion(city)
        }
    }
}

extension ViewController {
    
    ///    Достаём расположение девайса
    
    //            Реализуем метод, где отрабатываем различные ситуации с локацией, а именно с отключенной настройкой в девайсе и включенной
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //        Получаем последнее месторасположение из массива CLLocation. Геопозиция по широте и долготе
        guard let location = locations.last else { return }
        //        Координата широты
        let latitude = location.coordinate.latitude
        //        Координата долготы
        let longitude = location.coordinate.longitude
        
        //        Метод чтобы получить погоду по текущему расположению
        networkWeatherManager.fetchCurrentWeather(forRequstType: .coordinate(latitude: latitude, longitude: longitude))
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
