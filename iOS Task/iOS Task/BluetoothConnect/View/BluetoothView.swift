//
//  BluetoothView.swift
//  iOS Task
//
//  Created by Karthik Raja on 02/07/24.
//

import Foundation
import SwiftUI
import CoreBluetooth

struct BluetoothView: View {
    
    @ObservedObject var viewModel = BluetoothManager()

    var body: some View {
       
        VStack{
            
            List(viewModel.availableDevices, id: \.identifier) { device in
                
                HStack {
                    
                    Text(device.name ?? "Unknown Device")
                    
                    Spacer()
                    
                    if viewModel.connectedDevice == device {
                        
                        Text("Connected")
                        .foregroundColor(.green)
                    }
                }
                .onTapGesture {
                    if viewModel.connectedDevice == device {
                        viewModel.disconnect(from: device)
                    } else {
                        viewModel.connect(to: device)
                    }
                }
            }
        }
        .navigationTitle("Bluetooth Devices")
    }
}
