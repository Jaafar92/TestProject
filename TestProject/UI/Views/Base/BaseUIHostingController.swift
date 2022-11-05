//
//  BaseUIHostingController.swift
//  TestProject
//
//  Created by Jaafar on 03/08/2021.
//

import UIKit
import SwiftUI

class BaseUIHostingController<T: View> : BaseView {

    var swiftUIView : UIHostingController<T>
    
    init(view: T) {
        swiftUIView = UIHostingController(rootView: view)
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("\(String(describing: self)) was de-initialized")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChild(swiftUIView)
        self.view.addSubview(swiftUIView.view)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        Layout.addTopConstraint(on: swiftUIView.view, to: self.view.topAnchor, by: 0)
        Layout.addLeadingConstraint(on: swiftUIView.view, to: self.view.leadingAnchor, by: 0)
        Layout.addTrailingConstraint(on: swiftUIView.view, to: self.view.trailingAnchor, by: 0)
        Layout.addBottomConstraint(on: swiftUIView.view, to: self.view.bottomAnchor, by: 0)
    }
}
