//
//  ContainerView.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 04.01.2020.
//  Copyright © 2020 Antropov Personal. All rights reserved.
//

import SwiftUI

struct ContainerView: View {
    @State private var shouldShowMainView: Bool = false
    
    var body: some View {
        NavigationView {
            HStack {
                LoginView(isUserLoggedIn: $shouldShowMainView)
                //MARK: - NAVIGATION LINKS
                NavigationLink(destination: CitiesView(),
                               isActive: $shouldShowMainView) {
                    EmptyView()
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
