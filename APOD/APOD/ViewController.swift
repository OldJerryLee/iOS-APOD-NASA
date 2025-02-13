//
//  ViewController.swift
//  APOD
//
//  Created by Fabricio Pujol on 13/02/25.
//

import UIKit

class ViewController: UIViewController {

    private lazy var myView: View = {
        let view = View()
        view.delegate = self
        return view
    }()

    override func loadView() {
        super.loadView()
        self.view = myView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myView.setup(labelText: "APOD", buttonTitle: "TROCAR DATA")
    }
}

extension ViewController: ViewDelegate {
    func didTapButton() {
        print("DATA TROCADA")
    }
}
