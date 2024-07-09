//
//  ViewController.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var ctaButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Show Care Driver Screen", for: .normal)
        button.addTarget(self, action: #selector(startCareDriverFlow), for: .touchUpInside)
        button.setTitleColor( HSDTheme.Color.primary, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(ctaButton)
        // [KL]: minimum effort in setting up the constraints (edges are not pinned)
        ctaButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
    
    @objc private func startCareDriverFlow() {
        // [KL]: Apple doesn't make it easy to inject dependencies in this default VC. This would typically be injected into this VC via its init func
        let router = CareDriverRouter()
        router.routeToCareDriverList(from: self)
    }
}

