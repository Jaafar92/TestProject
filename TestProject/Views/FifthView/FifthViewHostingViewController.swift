//
//  FifthViewHostingViewController.swift
//  TestProject
//
//  Created by Jaafar on 01/08/2021.
//

import UIKit
import SwiftUI

class FifthViewHostingController : UIViewController {
    
    var fifthView : UIHostingController<FifthView>
    
    init(viewModel: FifthViewModel) {
        fifthView = UIHostingController(rootView: FifthView(viewModel: viewModel))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChild(fifthView)
        self.view.addSubview(fifthView.view)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        Layout.addTopConstraint(on: fifthView.view, to: self.view.topAnchor, by: 0)
        Layout.addLeadingConstraint(on: fifthView.view, to: self.view.leadingAnchor, by: 0)
        Layout.addTrailingConstraint(on: fifthView.view, to: self.view.trailingAnchor, by: 0)
        Layout.addBottomConstraint(on: fifthView.view, to: self.view.bottomAnchor, by: 0)
    }
}
