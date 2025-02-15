//
//  ViewController.swift
//  APOD
//
//  Created by Fabricio Pujol on 13/02/25.
//

import UIKit

class APODViewController: UIViewController {
    
    private var APODScreen: APODScreenView?
    private let viewModel: APODViewModel = APODViewModel()
    
    override func loadView() {
        super.loadView()
        self.APODScreen = APODScreenView()
        self.view = self.APODScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate(delegate: self)
        self.APODScreen?.delegate(delegate: self)
        viewModel.fetchAPOD()
        
        if let url = URL(string: "https://apod.nasa.gov/apod/image/2402/Carina_Taylor_960.jpg") {
            downloadImage(from: url.absoluteURL)
        }
    }
    
    private func downloadImage(from url: URL) {
        let request = URLRequest(url: url)

        // Verifica se a imagem já está no cache
        if let cachedResponse = URLCache.shared.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            DispatchQueue.main.async {
                self.APODScreen?.APODImageView.image = image
            }
            return
        }

        // 🔹 Garante que o placeholder esteja visível antes de iniciar o download
        DispatchQueue.main.async {
            self.APODScreen?.APODImageView.image = UIImage(systemName: "photo.artframe")
        }

        // Faz o download da imagem
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response, error == nil,
                  let image = UIImage(data: data) else { return }

            // Salva a imagem no cache
            let cachedResponse = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedResponse, for: request)

            DispatchQueue.main.async {
                self.APODScreen?.APODImageView.image = image
            }
        }.resume()
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
