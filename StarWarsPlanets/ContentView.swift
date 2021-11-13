//
//  ContentView.swift
//  StarWarsPlanets
//
//  Created by Sachintha on 2021-11-14.
//

import SwiftUI

struct ContentView: View {
    
    // Create API Service instance
    @ObservedObject var apiService = APIService()
    
    init() {
        // Load Planets from server
        self.apiService.loadPlanets();
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(apiService.response) { planet in
                    NavigationLink(
                        destination: DetailPane(planet: planet),
                        label: {
                            HStack {
                                ImageView(url: planet.imageUrl, width: 100, height: 100, cornerRadius: 10)
                                VStack(alignment: .leading) {
                                    Text(planet.name)
                                        .font(.title)
                                    Text(planet.climate)
                                        .foregroundColor(.gray)
                                        .padding(8)
                                }
                            }
                        })
                }
            }
            .navigationBarTitle("Star Wars Planets") // Set a main screen title
        }
    }
}

// Detail Pane UI Design
struct DetailPane:View {
    var planet: Planet
    
    var body: some View {
        VStack {
            ImageView(url: planet.imageUrl, width: 320, height: 160, cornerRadius: 16)
            Text(planet.name)
                .font(.largeTitle)
                .bold()
                .padding(40)
            VStack {
                Text("Gavity")
                    .font(.title2)
                Text(planet.gravity)
                    .foregroundColor(.gray)
            }.padding(20)
            VStack {
                Text("Orbital Period")
                    .font(.title2)
                Text(planet.orbital_period)
                    .foregroundColor(.gray)
            }.padding(20)
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
