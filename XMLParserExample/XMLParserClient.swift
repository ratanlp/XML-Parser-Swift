//
//  XMLParserClient.swift
//  XMLParserExample
//
//  Created by Lal Prasad, Ratan on 6/15/17.
//  Copyright © 2017 Nusoma. All rights reserved.
//

import Foundation

class XMLParserClient: NSObject, XMLParserDelegate {
    var parser = XMLParser()
    var newsData = [NewsModel]()
    var newsModel: NewsModel?
    var foundElementName: String?
    var title: String?
    var date: String?
    var desc: String?
    var error: Error? = nil
    
    static var client: XMLParserClient?
    
    static func sharedInstance() -> XMLParserClient {
        if client == nil {
            client = XMLParserClient()
        }
        
        return client!
    }
    
    func fetchXMLData(for url: String, withCallback completionHandler: @escaping (_ result: [NewsModel]?, _ error: Error?) -> Void) {
        parser = XMLParser.init(contentsOf: URL(string: url)!)!
        parser.delegate = self
        
        if parser.parse() {
            if error != nil {
                completionHandler(nil, error)
            }
            else {                
                completionHandler(newsData, nil)
            }
        }
        else {
            let newError = NSError(domain:"", code: 400, userInfo: [NSLocalizedDescriptionKey: "Error while parsing"])
            completionHandler(nil, newError)
        }
    }
    
    // MARK: - XMLParserDelegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        foundElementName = elementName
        if elementName == "item" {
            newsModel = NewsModel()
            title = ""
            date = ""
            desc = ""
            foundElementName = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if foundElementName == "title" {
            title?.append(string)
        } else if foundElementName == "pubDate" {
            date?.append(string)
        }
        else if foundElementName == "description" {
            desc?.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if title != nil {
                newsModel?.title =  title!
            }
            if date != nil {
                newsModel?.pubDate = date!
            }
            newsData.append(newsModel!)
            newsModel = nil
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("failure error: ", parseError)
        error = parseError
    }
}
