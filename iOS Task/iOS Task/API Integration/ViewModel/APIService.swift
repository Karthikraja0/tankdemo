//
//  Apiservice.swift
//  iOS Task
//
//  Created by Karthik Raja on 02/07/24.
//

import Combine
import Foundation

class APIService: ObservableObject {
    
    static let shared = APIService()
    @Published var data: [APImodel] = []
    @Published var error: Error?

    private var cancellables = Set<AnyCancellable>()
    private let url = "https://jsonplaceholder.typicode.com/posts"

    init(){
        fetchDataAndPublish()
    }
    
    func fetchData() -> AnyPublisher<[APImodel], Error> {
        guard let url = URL(string: url) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [APImodel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    
    func fetchDataAndPublish() {
       
            fetchData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
               
                switch completion {
                
                case .finished:
                
                    print("Finished fetching data")
                
                case .failure(let error):
                
                    self.error = error
                    print("Failed to fetch data: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] data in
                self?.data = data
            })
            .store(in: &cancellables)
    }
}
