//
//  UrlWebView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-15.
//

import Foundation
import SwiftUI
import WebKit

struct UrlWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    var urlToDisplay : String
    


    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: URL(string: urlToDisplay)!))
        return webView
    }
    
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
     
    }
    
}

