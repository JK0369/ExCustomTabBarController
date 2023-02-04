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
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tabBarController = CustomTabBarController().then {
            $0.modalPresentationStyle = .fullScreen
        }
        
        present(tabBarController, animated: true)
    }
}
