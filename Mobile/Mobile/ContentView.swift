//
//  ContentView.swift
//  Mobile
//
//  Created by Juan Saldana on 8/6/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Weather and Light Sync")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            HStack{
                Text("Horizontal Stack").font(.subheadline).padding()
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
