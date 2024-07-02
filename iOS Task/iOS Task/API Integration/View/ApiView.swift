//
//  ApiDataView.swift
//  iOS Task
//
//  Created by Karthik Raja on 02/07/24.
//

import Foundation
import SwiftUI

struct DataView: View {
    @ObservedObject var viewModel = APIService.shared

    var body: some View {
        VStack {
        
            if let errorMessage = viewModel.error {
                
                Text("Error: \(errorMessage.localizedDescription)")
                    .foregroundColor(.red)
                    .onAppear(){
                        APIService.shared.fetchDataAndPublish()
                    }
                
            } else {
                
                ScrollView(.vertical) {
                   
                    VStack(spacing: 10){
                   
                        ForEach(viewModel.data, id: \.id) { item in
                            HStack{
                                
                                Text("\(item.id ?? 0)")
                                    .padding(5)
                                    .frame(width: 40,height: 40)
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                    .foregroundColor(Color.white)
                                
                                Text(item.title ?? "")
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(5)
                                    .background(Color.gray.opacity(0.3).cornerRadius(8))
                                
                                Spacer()
                                
                            }.frame(maxWidth: .infinity,alignment: .leading)
                            
                        }
                    }
                }.padding(.horizontal)
                 .padding(.vertical,5)
                
            }
            
        }.padding(.horizontal,5)
         .navigationTitle("API Data")
        
    }
}
