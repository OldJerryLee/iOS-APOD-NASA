//
//  FavoriteAPODViewController.swift
//  APOD
//
//  Created by Fabricio Pujol on 17/02/25.
//

import UIKit

class FavoriteAPODViewController: UIViewController {
    
    private var favoriteAPODScreen: FavoriteAPODScreen?
    private let viewModel: FavoriteAPODViewModel
    
    init(viewModel: FavoriteAPODViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.favoriteAPODScreen = FavoriteAPODScreen()
        self.view = self.favoriteAPODScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let favoriteItem = viewModel.getFavoriteAPODItem()
        
        let videoId = viewModel.extractYouTubeVideoID(from: favoriteItem.videoURL ?? "")
        
        self.favoriteAPODScreen?.setup(titleText: favoriteItem.title ?? "",
                                       dateText: favoriteItem.date ?? "",
                                       descriptionText: favoriteItem.explanation ?? "",
                                       mediaType: favoriteItem.mediaType ?? "",
                                       videoId: videoId,
                                       imageData: favoriteItem.imageData)
    }
}
