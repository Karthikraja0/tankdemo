//
//  ContentView.swift
//  iOS Task
//
//  Created by Karthik Raja on 02/07/24.
//

import SwiftUI

struct ContentView: View {
  
    var body: some View {
       
            VStack {
                
                NavigationLink(destination: {
                    BluetoothView()
                }, label: {
                    
                    Text("Bluetooth Devices")
                        .bold()
                        .frame(minWidth: 250)
                        .frame(height: 60)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
                .padding(.vertical)
                
                NavigationLink(destination: {
                    DataView()
                }, label: {
                    Text("API Data")
                        .bold()
                        .frame(minWidth: 250)
                        .frame(height: 60)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
                

            }.padding()
            .navigationTitle("iOS Task")
    }
}

#Preview {
    ContentView()
}
