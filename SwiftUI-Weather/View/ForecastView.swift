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
    //    @State var weathers = [Weather]()
    @ObservedObject var viewModel: ForecastViewModel
    
    init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ASCollectionView(data: viewModel.detachedWeathers) { (weather, context) in
            return WeatherView(weather: weather)
        }.layout {
            .grid(
                layoutMode: .fixedNumberOfColumns(2),
                itemSpacing: 0,
                lineSpacing: 16)
        }
        .onAppear(perform: viewModel.fetchForecast)
        .navigationBarTitle(viewModel.city.name)
    }
}

struct WeatherView: View {
    let weather: Weather
    
    init(weather: Weather) {
        self.weather = weather
    }
    
    var body: some View {
        return GeometryReader { proxy in
            VStack {
                Text(String(format: "%.0f℃", self.weather.temperature))
                KFImage(self.weather.iconUrl)
                    .cancelOnDisappear(true)
                Text(DateFormatter.forecastFormat(for: self.weather.date))
                    .frame(width: proxy.size.width)
            }
        }
    }
}
