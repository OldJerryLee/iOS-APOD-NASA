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
        self.APODScreen?.startPlaceholder()
        self.APODScreen?.showLoading()
        viewModel.fetchAPOD()
    }
    
    private func downloadImage(from url: URL) {
        let request = URLRequest(url: url)

        if let cachedResponse = URLCache.shared.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            DispatchQueue.main.async {
                self.APODScreen?.setupImage(image: image)
            }
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response, error == nil,
                  let image = UIImage(data: data) else { return }

            let cachedResponse = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedResponse, for: request)

            DispatchQueue.main.async {
                self.APODScreen?.setupImage(image: image)
            }
        }.resume()
    }
}

extension APODViewController: APODScreenViewDelegate {
    func didTapFavoriteButton() {
        print("FAVORITAR")
    }
    
    func didTapCalendarButton() {
        let alert = UIAlertController(title: "Escolha uma data", message: "\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        datePicker.frame = CGRect(x: 10, y: 30, width: alert.view.bounds.width - 20, height: 200)
        
        alert.view.addSubview(datePicker)

        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let selectedDate = formatter.string(from: datePicker.date)
            self.APODScreen?.startPlaceholder()
            self.APODScreen?.setupImageTemplate()
            self.APODScreen?.showLoading()
            self.viewModel.fetchAPODByDate(date: selectedDate)
        }

        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)

        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
}

extension APODViewController: APODViewModelProtocol {
    func error(message: String) {
        let alertController: UIAlertController = UIAlertController(title: "Ops, tivemos um problema", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(ok)
        present(alertController, animated: true)
        
        self.APODScreen?.stopPlaceholder()
        self.APODScreen?.hideLoading()
    }
    
    func success() {
        DispatchQueue.main.async { [weak self] in
            self?.APODScreen?.setup(titleText: self?.viewModel.APODfetched?.title ?? "",
                                    dateText: self?.viewModel.getFormatedDate(dateString: self?.viewModel.APODfetched?.date ?? "") ?? "",
                                    descriptionText: self?.viewModel.APODfetched?.explanation ?? "")
            
            self?.APODScreen?.stopPlaceholder()
            self?.APODScreen?.hideLoading()
            
            if let url = URL(string: self?.viewModel.APODfetched?.url ?? "") {
                self?.downloadImage(from: url.absoluteURL)
            }
        }
    }
}
