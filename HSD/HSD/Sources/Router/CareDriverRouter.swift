//
//  CareDriverRouter.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import UIKit

protocol CareDriverRouting {
    func routeToCareDriverList(from presenter: UIViewController)
}


final class CareDriverRouter: CareDriverRouting {
    
    func routeToCareDriverList(from presenter: UIViewController) {
        // [KL]: could expose other params like animated and navigation type (push or present)
        let networkProvider = NetworkServiceProvider()
        let stateProvider = CareDriverStateProvider(networkServiceProvider: networkProvider)
        let vc = CareDriverViewController(stateProvider: stateProvider)
        let navc = UINavigationController(rootViewController: vc)
        navc.modalPresentationStyle = .fullScreen
        presenter.present(navc, animated: true)
    }

}
