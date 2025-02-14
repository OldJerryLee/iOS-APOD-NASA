//
//  ViewController.swift
//  APOD
//
//  Created by Fabricio Pujol on 13/02/25.
//

import UIKit

class APODViewController: UIViewController {
    
    private let viewModel: APODViewModel = APODViewModel()

    private lazy var myView: APODScreenView = {
        let view = APODScreenView()
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
        self.viewModel.delegate(delegate: self)
        viewModel.fetchAPOD()
    }
}

extension APODViewController: ViewDelegate {
    func didTapButton() {
        print("DATA TROCADA")
    }
}

extension APODViewController: APODViewModelProtocol {
    func error(message: String) {
        let alertController: UIAlertController = UIAlertController(title: "Ops, tivemos um problema", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
    
    func success() {
        DispatchQueue.main.async { [weak self] in
            print(self?.viewModel.APODfetched)
        }
    }
}
