//
//  File.swift
//  MEO_EPG_Now_and_Next
//
//  Created by Albertino Vieira on 11/11/2019.
//  Copyright © 2019 alticeLabs. All rights reserved.
//

import Foundation

public class CommonHandler {
    
    
    private var channelsArray: Array<Channel> = []
    
    func fetchChannelList(url: String ,completion: @escaping ([Channel]) -> Void){
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    data, options: []) as! [String : Any]
                let numberOfChannels = Int( jsonResponse["odata.count"]! as! String)
                if let arrayOfValues = jsonResponse["value"] as? [[String: Any]] {
                    for channel in arrayOfValues {
                        let channelToAppend = Channel(name: channel["Title"]! as! String, callLetter: channel["CallLetter"]! as! String, numberOfChannels: numberOfChannels!)
                        self.channelsArray.append(channelToAppend)
                    }
                    
                }
                completion(self.channelsArray)
            } catch let parsingError {
                print("Error", parsingError)
            }
            
        }
        
        task.resume()
    }
    
    func fetchEpg(url: String ,completion: @escaping (EpgNowAndNext) -> Void){
        guard let url = URL(string: url) else { return }
        var epgNowAndNext: EpgNowAndNext!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    data, options: []) as! [String : Any]
                if var arrayOfValues = jsonResponse["value"] as? [[String: Any]]{
                    if arrayOfValues.count > 0 {
                        let nowShow = arrayOfValues[0]["Title"] as! String
                        let finalShow = arrayOfValues[1]["Title"] as! String
                        if nowShow != nil && finalShow != nil{
                            epgNowAndNext = EpgNowAndNext(nowShow: nowShow, tittleForImageNowShow: "", nextShow: finalShow)
                        }
                        
                    }else{
                        epgNowAndNext = EpgNowAndNext(nowShow: "", tittleForImageNowShow: "", nextShow: "")
                        
                    }
                }
                completion(epgNowAndNext!)
            } catch let parsingError {
                print("Error", parsingError)
            }
            
        }
        
        task.resume()
    }
    
    
    func fetchImg(url: String ,completion: @escaping (NSData) -> Void){
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            do{
                print(data)
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    data, options: []) as! [String : Any]
                print(data)
                completion(data as NSData)
            } catch let parsingError {
                print("Error", parsingError)
            }
            
        }
        
        task.resume()
    }
    
}
