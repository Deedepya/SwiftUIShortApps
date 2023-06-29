//
//  WeatherViewModel.swift
//  AppleTutorialSwiftUI
//
//  Created by dedeepya reddy salla on 17/06/23.
//

import Foundation
import Combine

struct City : Identifiable, Hashable {
    let id = UUID()
    let name: String
}


class WeatherViewModel: ObservableObject {
    var originalList: [City] = []
    @Published var weather = CurrentWeatherInfo()
    @Published var citiesList: [City] = []
    @Published var showLoader: Bool = false
    private var allCancellables = Set<AnyCancellable>()
    private var cancelableSub: AnyCancellable?
    private var cancelableSub2: AnyCancellable?
    
    init() {
        getCitiesAPI()
        getCurrenLocationWeather(coordinates: AppUtility.shared.currentLocation)
    }
    
    func getCitiesAPI() {
        let cityService = GetCitiesService()
        //.assign(to: \.citiesList, on: self)
      combineRestService.getAPICall(service: cityService)
            .sink { status in
            print("cities status")
            print(Thread.current)
            print(status)
            switch status {
            case .finished:
                print("success")
            case .failure(let error):
                print(error)
            }
        } receiveValue: { [weak self] cities in
                            print(cities.data.count)
                            self?.originalList = []
                            self?.citiesList = []
                            self?.citiesList = cities.data.map({ city in
                                return City(name: city)
                            })
        }.store(in: &allCancellables)
    }
    
    func getCurrenLocationWeather(city: String? = nil, coordinates: Coordinates? = nil) {
        resetWeather()
        showLoader = true
        var weatherService = WeatherService()
        if (city==nil && coordinates==nil) {
            return
        }
        if let city = city {
            weatherService.addQueryItem(withCityName: city)
        } else if let coordinates = coordinates {
            weatherService.addQueryItem(withCoordinates: coordinates)
        }
    
        combineRestService.getAPICall(service: weatherService)
            .sink { status in
                
                print("weather status")
                print(Thread.current)
                print(status)
            } receiveValue: { [weak self] weatherModel in
                print(weatherModel)
                self?.showLoader = false
                self?.saveWeatherInfo(weatherInfo: weatherModel)
            }.store(in: &allCancellables)
    }
    
    func getImageOfWEathr(icon: String) {
        let imageservice = ImageIconService(imageIcon: icon)
        weather.skyImageUrl = imageservice.urlStr
    }
    
    func resetWeather() {
        weather = CurrentWeatherInfo()
    }
    
    // MARK: - Saving weather data
    func saveWeatherInfo(weatherInfo: WeatherModel?) {
        var model = CurrentWeatherInfo()
        model.temperature = weatherInfo?.main.temp ?? 0.0
        model.feelsLike = weatherInfo?.main.temp ?? 0.0
        model.visibility = weatherInfo?.main.temp ?? 0.0
        model.pressure = weatherInfo?.main.temp ?? 0.0
        model.humidity = weatherInfo?.main.temp ?? 0.0
        model.temperature = weatherInfo?.main.temp ?? 0.0
        model.minTemp = weatherInfo?.main.temp ?? 0.0
        model.maxTemp = weatherInfo?.main.temp ?? 0.0
        model.skyImageUrl = ""
        model.cityName = weatherInfo?.name ?? ""
        if (weatherInfo?.weather.count ?? 0) > 0 {
            model.description = weatherInfo?.weather[0].description ?? ""
        }
        weather = model
        AppUtility.shared.currentWeatherInfo = model
    }
}


