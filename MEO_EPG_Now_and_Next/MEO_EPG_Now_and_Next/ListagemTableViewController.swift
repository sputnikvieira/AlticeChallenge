//
//  ListagemTableViewController.swift
//  MEO_EPG_Now_and_Next
//
//  Created by Albertino Vieira on 07/11/2019.
//  Copyright © 2019 alticeLabs. All rights reserved.
//

import UIKit

class ListagemTableViewController: UITableViewController {
    
    let request = CommonHandler()
    private var channelList: Array<Channel> = []
    private var epgNowAndNext: Array<EpgNowAndNext> = []
    private var currentPage = 0
    private var numberOfPages = 0
    private var imgChannel : UIImage?
    var epgElement : EpgNowAndNext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadChannels()
    }
    
    private func loadChannels(){
        if currentPage == 0{
            request.fetchChannelList(url: ConstantsStruct.firstPage){ channelArray in
                DispatchQueue.main.async {
                    for channel in channelArray{
                        let channelTotal = Double(channel.numberOfChannels)/10.0
                        self.numberOfPages = Int(channelTotal)
                        self.channelList.append(channel)
                    }
                    self.tableView.reloadData()
                }
            }
        }else if currentPage > 0 && currentPage <= numberOfPages{
            let urlPage = ConstantsStruct.nextPage + String(currentPage) + "0"
            request.fetchChannelList(url: urlPage){ channelArray in
                DispatchQueue.main.async {
                    self.channelList = channelArray
                    self.tableView.reloadData()
                }
            }
            
        }
        
        
        
    }
    
    private func fecthNextPage(){
        currentPage += 1
        loadChannels()
    }
    
    private func fetchEpg(callLetter : String){
        if callLetter != ""{
            let urlPage = ConstantsStruct.epgChannel + callLetter + ConstantsStruct.epgChannel2
            
            request.fetchEpg(url: urlPage) { (epg) in
                self.epgNowAndNext.insert(epg, at: self.epgNowAndNext.count)
            }
        }
    }
    /*
     private func fetchImg(formattedString: String, callLetter: String){
     
     let urlPage = ConstantsStruct.imgUrl +
     formattedString + ConstantsStruct.imgUrl2 + callLetter + ConstantsStruct.imgUrl3
     request.fetchImg(url: urlPage) { (img) in
     self.imgChannel = UIImage(data: img as Data)
     }
     }
     */
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.row == channelList.count - 1
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return channelList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstantsStruct.reuseIdentifier, for: indexPath) as! ChannelTableViewCell
        
        fetchEpg(callLetter: self.channelList[indexPath.row].callLetter)
//        var formattedString: String
        for epgNowAndNextElement in epgNowAndNext{
            if epgNowAndNextElement.callLetter == self.channelList[indexPath.row].callLetter{
                epgElement = epgNowAndNextElement
            }
        }
        
        //formattedString = epgElement!.nowShow.replacingOccurrences(of: " ", with: "+")
        //let urlFinal = ConstantsStruct.imgUrl + formattedString + ConstantsStruct.imgUrl2 + self.channelList[indexPath.row].callLetter + ConstantsStruct.imgUrl3
        //fetchImg(formattedString: urlFinal, callLetter: self.channelList[indexPath.row].callLetter)
        
        
        cell.channelTitle.text = self.channelList[indexPath.row].name
        cell.nowProgramChannel.text = epgElement?.nowShow
        cell.nextProgramChannel.text = epgElement?.nextShow
        
        // cell.channelImg.image = self.imgChannel
        
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else {return}
        fecthNextPage()
    }
    
    
}

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "+")
    }
}
