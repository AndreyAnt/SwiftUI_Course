//
//  ForecastView.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 05.01.2020.
//  Copyright © 2020 Antropov Personal. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import ASCollectionView

struct ForecastView: View {
    let networkService = NetworkService()
    
    //    @State var weathers = [Weather]()
    @ObservedObject var viewModel: ForecastViewModel
    
    init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
//        ifLet(viewModel.weathers) { weathers in
        ASCollectionView(data: viewModel.detachedWeathers) { (weather, context) in
            return WeatherView(weather: weather)
        }.layout {
            .grid(
                layoutMode: .fixedNumberOfColumns(2),
                itemSpacing: 0,
                lineSpacing: 16)
        }.onAppear {
            print("Forecast requested")
            self.networkService.forecast(for: self.viewModel.city.name) { result in
                switch result {
                case .success(let weathers):
                    try? RealmService.save(items: weathers)
                case .failure(let error):
                    print(error)
                }
            }
        }
//        }
            .navigationBarTitle(viewModel.city.name)
    }
}

struct WeatherView: View {
    let weather: Weather
    
    init(weather: Weather) {
        self.weather = weather
        print("Init called for \(DateFormatter.forecastFormat(for: self.weather.date))")
    }
    
    var body: some View {
        VStack {
            Text(String(format: "%.0f℃", weather.temperature))
            KFImage(weather.iconUrl)
            Text(DateFormatter.forecastFormat(for: weather.date))
                .frame(minWidth: 150)
                .onAppear { print("On Appear called for \(DateFormatter.forecastFormat(for: self.weather.date))") }
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(viewModel: ForecastViewModel(city: City(name: "Kazan", imageName: "kazan")))
    }
}
