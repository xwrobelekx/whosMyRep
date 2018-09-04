//
//  RepModelController.swift
//  whosMyRep
//
//  Created by Kamil Wrobel on 9/3/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation


class RepModelController {
    
    static let shared = RepModelController()
    
    private init() {}
    
    //url
    //https://whoismyrepresentative.com/getall_reps_bystate.php?state=NJ&output=json
    //https://whoismyrepresentative.com/getall_reps_bystate.php?state=AL&output=json
    
    private let baseURLString = "https://whoismyrepresentative.com/getall_reps_bystate.php?"
    
    func fetchRepresentatives(stateCode: String, completion: @escaping ([Representative]?) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else {
            fatalError("Unable to get the correct URL!!!!!!!!!")
        }
        
        let newURL = baseURL
        
        var components = URLComponents(url: newURL, resolvingAgainstBaseURL: true)
        //querry item = (name: "state", value: stateCode) -> state=NJ
        let queryItemOne = URLQueryItem(name: "state", value: stateCode)
        //FIXME: make sure i have "&" in url
        // hot to generate this: &output=json to make sure i have the "&" in between
        
        let queryItemTwo = URLQueryItem(name: "output", value: "json")
        
        components?.queryItems = [queryItemOne, queryItemTwo]
        
        guard let url = components?.url else {
            //completion
            return
        }
        print("URL URL URL URL URL URL: \(url)")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            //#1 handle error
            if let error = error {
                print("🍢There was an error fetchin data from dataTask: \(#function) \(error) \(error.localizedDescription)")
                completion([])
                return
            }
            //#2 handle data
            guard let dataThatCameback = data else {
                print("🌔No Data returned")
                completion([])
                return
            }
            
            //#3 decode the data
            
            /*
             whoismyrepresentative.com incorrectly encodes letters with diacrtic marks, e.g. ú using
             extended ASCII, not UTF-8. This means that trying to convert the data to a string using .utf8 will
             fail for some states, where the representatives have diacritics in their names.
             
             To workaround this, we decode into a string using ASCII, then reencode the string as data using .utf8
             before passing the fixed UTF-8 data into the JSON decoder.
             */
            
             let asciiStringFromData = String(data: dataThatCameback, encoding: .ascii)
             let dataAsUTF8 = Data(asciiStringFromData!.utf8)
            
            
            do {
                let results = try JSONDecoder().decode(ResultForGivenState.self, from: dataAsUTF8).results
                completion(results)
            }catch let error {
                print("🔥There was an error on \(#function): \(error) \(error.localizedDescription)")
                completion([])
                return
            }
        }.resume()
    }
}
