//
//  ViewController.swift
//  ExCustomTabBarController
//
//  Created by 김종권 on 2023/02/04.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private let tabBar = CustomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tabBar)
        tabBar.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.top.equalTo(view.snp.bottom).offset(-100)
        }
    }
}
