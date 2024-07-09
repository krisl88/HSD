//
//  CareDriverStateProviding.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import Foundation
import Combine
import UIKit

struct CareDriverState {
    let tripData: TripData
}

protocol CareDriverStateProviding: StateProviding where State == CareDriverState {
    func showAlert(for trip: Trip, from presenter: UIViewController)
}

final class CareDriverStateProvider {
    
    private lazy var tripSubject: PassthroughSubject<TripData, Never> = .init()
    private let networkServiceProvider: NetworkServiceProviding
    
    private enum Constants {
        static var apiURL: URL {
            // [KL] in production, we wouldn't define url inside this class and definitely won't force uwrap
            URL(string: "https://hopskipdrive-static-files.s3.us-east-2.amazonaws.com/interview-resources/Trip.json")!
            
        }
    }
    
    init(networkServiceProvider: NetworkServiceProviding) {
        self.networkServiceProvider = networkServiceProvider
    }
    
    func load() {
        fetchFromNetwork { [weak self] result in
            switch result {
            case .success(let data):
                self?.tripSubject.send(data)
            case .failure(let error):
                print(error)
                // [KL]: handle error
               break
            }
        }
    }
    
    private func fetchFromNetwork(
        _ paginationToken: Any? = nil, // [KL]: not used in this API
        completion: @escaping APICallback<TripData>
    ) {
        let request = URLRequest(url: Constants.apiURL)
        networkServiceProvider.request(request, params: nil) { result in
            completion(result)
        }
    }
}

extension CareDriverStateProvider: CareDriverStateProviding {
    
    var statePublisher: AnyPublisher<CareDriverState, Never> {
        tripSubject
            .map {
                CareDriverState(tripData: $0)
            }
            .eraseToAnyPublisher()
    }
    
    func showAlert(for trip: Trip, from presenter: UIViewController) {
        let state: AlertViewState = .init(
            title: .text("Are you sure?"),
            subtitle: .text("Are you sure you want to cancel this claim? This cannot be undone"),
            ctaButtons: [
                .init(text: .text("Never mind"), action: {
                    presenter.dismiss(animated: true)
                }, style: .primary),
                .init(text: .text("Yes"), action: {
                    presenter.dismiss(animated: true)
                }, style: .secondary),
            ]
        )
        let alertViewController = AlertViewController(state: state)
        alertViewController.modalPresentationStyle = .overFullScreen
        presenter.present(alertViewController, animated: true)
    }
}
