//
//  BrowserViewModel.swift
//  DefaultBrowser
//
//  Created by Pavel Ivashkov on 2019-04-20.
//
import Foundation


class BrowserViewModel {

    init() {
        selectedBrowser = browsers.first
    }
    
    weak var delegate: BrowserViewModelDelegate?
    
    let browsers: [Browser] = Browsers.enumerate()
    let launcher = Launcher()

    var selectedBrowser: Browser?
    
    var url: URL? {
        didSet {
            notifyDidChangeUrl(url)
        }
    }
}


protocol BrowserViewModelDelegate : class {

    func viewModel(_ viewModel: BrowserViewModel, didChangeUrl url: URL?)
}


extension BrowserViewModel {
    
    func open() {
        guard let url = url,
            let browser = selectedBrowser
            else { return }
        
        launcher.openUrl(url, inBrowser: browser)
    }
}

private extension BrowserViewModel {
    
    func notifyDidChangeUrl(_ url: URL?) {
        delegate?.viewModel(self, didChangeUrl: url)
    }
}
