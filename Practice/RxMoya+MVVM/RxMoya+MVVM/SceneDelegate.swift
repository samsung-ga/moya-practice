//
//  SceneDelegate.swift
//  RxMoya+MVVM
//
//  Created by Wody on 2022/01/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "ViewController", creator: { coder -> ViewController in
            let viewModel = ViewModel()
            return .init(coder, viewModel) ?? ViewController(ViewModel())
        })
        window?.rootViewController = viewController

    }
    
    
}

