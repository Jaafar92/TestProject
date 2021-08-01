//
//  ForthViewHostingViewController.swift
//  TestProject
//
//  Created by Jaafar on 31/07/2021.
//

import SwiftUI
import UIKit

class ForthViewHostingViewController : UIViewController {
    
    var forthView: UIHostingController<ForthView>
    
    init(viewModel: ForthViewModel) {
        self.forthView = UIHostingController(rootView: ForthView(viewModel: viewModel))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChild(forthView)
        self.view.addSubview(forthView.view)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        Layout.addTopConstraint(on: forthView.view, to: self.view.topAnchor, by: 0)
        Layout.addLeadingConstraint(on: forthView.view, to: self.view.leadingAnchor, by: 0)
        Layout.addTrailingConstraint(on: forthView.view, to: self.view.trailingAnchor, by: 0)
        Layout.addBottomConstraint(on: forthView.view, to: self.view.bottomAnchor, by: 0)
    }
}
