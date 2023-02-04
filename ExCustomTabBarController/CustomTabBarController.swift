//
//  CustomTabBarController.swift
//  ExCustomTabBarController
//
//  Created by 김종권 on 2023/02/04.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class CustomTabBarController: UIViewController {
    fileprivate let tabBar = CustomTabBar()
    private var childVCs = [UIViewController]()
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setUp() {
        setUpTabBar()
        setUpTabBarControllers()
        setUpBind()
    }
    
    private func setUpTabBar() {
        view.addSubview(tabBar)
        tabBar.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.top.equalTo(view.snp.bottom).offset(-100)
        }
    }
    
    private func setUpTabBarControllers() {
        tabBar.items
            .forEach { item in
                let vc = UIViewController().then {
                    $0.view.backgroundColor = .white
                }
                let title = String(describing: item)
                addLabel(in: vc, text: title)
                
                addChild(vc)
                view.addSubview(vc.view)
                vc.didMove(toParent: self)
                
                vc.view.snp.makeConstraints {
                    $0.top.leading.trailing.equalToSuperview()
                    $0.bottom.equalTo(tabBar.snp.top)
                }
                
                childVCs.append(vc)
            }
        
        guard let shouldFrontView = childVCs[0].view else { return }
        view.bringSubviewToFront(shouldFrontView)
    }
    
    private func setUpBind() {
        tabBar.rx.tapButton
            .bind(with: self) { ss, index in
                guard let shouldFrontView = ss.childVCs[index].view else { return }
                ss.view.bringSubviewToFront(shouldFrontView)
            }
            .disposed(by: disposeBag)
    }
    
    private func addLabel(in vc: UIViewController, text: String?) {
        let label = UILabel().then {
            $0.font = .systemFont(ofSize: 24)
            $0.textColor = .black
            $0.text = text
        }
        vc.view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension Reactive where Base: CustomTabBarController {
    var changeIndex: Binder<Int> {
        Binder(base) { base, index in
            base.tabBar.rx.changeIndex.onNext(index)
        }
    }
}
