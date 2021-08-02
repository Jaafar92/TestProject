//
//  BaseUIViewController.swift
//  TestProject
//
//  Created by Jaafar on 02/08/2021.
//

import UIKit
import Combine

class BaseUIViewController: UIViewController {
    var bindings = Set<AnyCancellable>()
    
    override func viewDidAppear(_ animated: Bool) {
        setUpBindings()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        bindings.forEach { $0.cancel() }
        bindings.removeAll()
    }
    
    func setUpBindings() {
    }
}
