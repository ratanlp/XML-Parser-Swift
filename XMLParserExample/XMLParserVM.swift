//
//  XMLParserVM.swift
//  XMLParserExample
//
//  Created by Lal Prasad, Ratan on 6/15/17.
//  Copyright © 2017 Nusoma. All rights reserved.
//

import UIKit

class XMLParserFactory {
    static func fetchData(url: String, withCallback completionHandler: @escaping (_ listOfModels: [XMLParserVM]?, _ error: Error?) -> Void) {
        XMLParserClient.sharedInstance().fetchXMLData(for: url) { (newsModelList, error) in
            
            print("Fetch data  Factory ", newsModelList?.count ?? "0")
            if error == nil {
                var listOfNewsVM = [XMLParserVM]()
                newsModelList?.forEach { model in
                    let parserVM = XMLParserVM.init(model)
                    listOfNewsVM.append(parserVM)
                }
//                for item in listOfNewsVM {
//                    print("\(item.title) - \(item.pubDate)")
//                }
                completionHandler(listOfNewsVM, nil)
            }
            else {
                completionHandler(nil, error)
            }
        }
    }
}

class XMLParserVM {
    
    var model:NewsModel?
    
    init(_ model:NewsModel) {
        self.model = model
    }
    
    var title: String {
        if let _ = model {
            return (model?.title)!
        }
        return ""
    }
    
    var pubDate: String {
        if let _ = model {
            return (model?.pubDate)!
        }
        return ""
    }

}
