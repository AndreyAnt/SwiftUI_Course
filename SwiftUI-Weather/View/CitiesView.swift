//
//  CitiesView.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 04.01.2020.
//  Copyright © 2020 Antropov. All rights reserved.
//

import SwiftUI

struct CitiesView: View {
//    @Binding var shouldShowMainView: Bool
    @State private var timer: Timer?
    @State private var cities: [City] = [
        City(name: "Kazan", imageName: "kazan"),
        City(name: "Cheboksary", imageName: "cheboksary"),
        City(name: "Vladivostok", imageName: "vladivostok"),
        City(name: "Yaroslavl", imageName: "yaroslavl")
    ]
    
    var body: some View {
        List(cities.sorted(by: { $0.name < $1.name })) { city in
            NavigationLink(destination: ForecastView(city: city)) {
                CityView(city: city)
            }
        }
        .onAppear(perform: addOrDeleteCity)
        .onDisappear(perform: invalidateTimer)
        .navigationBarTitle("Cities", displayMode: .inline)
            // workaround
//            .navigationBarItems(leading: MyBackButton(label: "Back") {
//                print(self.shouldShowMainView)
//                self.shouldShowMainView = false
//            })
    }
    
    private func addOrDeleteCity() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            self.timer = timer
            Bool.random() ? self.addCity() : self.deleteCity()
        }
    }
    
    private func addCity() {
        guard let city = [
            City(name: "Kazan", imageName: "kazan"),
            City(name: "Cheboksary", imageName: "cheboksary"),
            City(name: "Vladivostok", imageName: "vladivostok"),
            City(name: "Yaroslavl", imageName: "yaroslavl")
        ].randomElement() else { return }
        cities.append(city)
    }
    
    private func deleteCity() {
        guard let city = cities.randomElement() else { return }
        cities.removeAll { $0 == city }
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
    }
}

struct MyBackButton: View {
    let label: String
    let buttonAction: () -> Void
    
    var body: some View {
        Button(action: buttonAction) {
            HStack {
                Image(systemName: "chevron.left")
                Text(label)
            }
        }
    }
}

struct CityView: View {
    let city: City
    
    var body: some View {
        HStack {
            Image(city.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100, alignment: .leading)
                .padding()
            Text(city.name)
        }
    }
}
