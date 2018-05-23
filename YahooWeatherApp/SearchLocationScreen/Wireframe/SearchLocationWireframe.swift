//
//  SearchLocationWireframe.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import UIKit

class SearchLocationWireframe: NSObject, SearchLocationWireFrameProtocol {
    
    func showSearchView() {
        
    }
    
    class func createSearchLocationModule(callback: @escaping CompletionBlock)-> UIViewController {
        let viewController = SearchLocationView(nibName: "SearchLocationView", bundle: nil)
        let interactor = SearchLocationInteractor()
        let presenter = SearchLocationPresenter()
        let router = SearchLocationWireframe()
        let remoteDataManager = SearchLocationDataManager()
        
        viewController.presenter = presenter
        viewController.callback = callback
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.wireFrame = router
        
        interactor.presenter = presenter
        interactor.remoteRequestHandler = remoteDataManager
        
        remoteDataManager.requestHandler = interactor
        
        return viewController
    }
    
}
