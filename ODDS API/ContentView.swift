//
//  ContentView.swift
//  ODDS API
//
//  Created by Anderson Westfield  on 1/19/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GamesView()
                .tabItem {
                    Label("Games", systemImage: "trophy.fill")
                }
            
            TrendsView()
                .tabItem {
                    Label("Trends", systemImage: "flame.fill")
                }
            
            PropsView()
                .tabItem {
                    Label("Props", systemImage: "person.fill.viewfinder")
                }
            
            PredictionsView()
                .tabItem {
                    Label("Predictions", systemImage: "brain.head.profile")
                }
            
            MyPicksView()
                .tabItem {
                    Label("My Picks", systemImage: "list.bullet.clipboard")
                }
        }
        .tint(Color.accentColor)
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
