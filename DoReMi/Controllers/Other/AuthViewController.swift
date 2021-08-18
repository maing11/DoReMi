//
//  AuthViewController.swift
//  DoReMi
//
//  Created by mai ng on 8/15/21.
//

import Foundation
import WebKit


class AuthViewController: UIViewController, WKNavigationDelegate {
    
    
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true

        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs

        let webView = WKWebView(frame: .zero, configuration: config)

        return webView

    }()
    
    // Basically  tell our WelcomeController "Hey the user has successfully signed in "
    public var completionHandler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
        guard let url = AuthManager.shared.signInURL else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
//
//    func webView(_ webView:  WKWebView, didStartProvisionNavagation navigation: WKNavigation!) {
//
//        guard let url = webView.url else {
//            return
//        }
//
//        // Exchange the code for acces token
//
//        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value
//        else {return }
//        print("Code: \(code)")
//    }
//}
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else{
            return
        }
        // Exchange the code for access token
        let component = URLComponents(string: url.absoluteString)
        guard let code = component?.queryItems?.first(where: {$0.name == "code"})?.value else {
            return
        }
        webView.isHidden = true
        print("Code: \(code)")
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completionHandler?(success)
            }
        }
    }
}
