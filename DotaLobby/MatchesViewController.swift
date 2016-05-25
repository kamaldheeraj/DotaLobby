//
//  MatchesViewController.swift
//  DotaLobby
//
//  Created by Kamal Dandamudi on 5/16/16.
//  Copyright © 2016 SillyApps. All rights reserved.
//

import UIKit
import Alamofire

class MatchesViewController: UIViewController , UIWebViewDelegate{
    
    @IBOutlet var webView: UIWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        let url = NSURL(string:"http://ec2-52-32-11-30.us-west-2.compute.amazonaws.com/DotaLobby.php")
        webView.loadRequest(NSURLRequest(URL: url!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print(request.URLString)
        if request.URLString.containsString("www.dotalobby.com/"){
            self.webView.hidden = true
            downloadMatchesFromAPI()
            return false
        }
        else{
            self.webView.hidden = false
        }
        return true
    }
    
    func downloadMatchesFromAPI(){
        Alamofire.request(.GET, "http://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/v0001/?key=29F8F26D275F5540E7BB0A6A3FC02D06",parameters: nil,encoding: .URL).validate().responseJSON(){
            response in
            guard response.result.isSuccess else{
                print("Error while fetching Matches list : \(response.result.error)")
                return
            }
            guard let value = response.result.value as? NSDictionary else{
                print("Error no value found")
                return
            }
            guard let result = value["result"] as? NSDictionary else{
                print("Error no result found")
                return
            }
            guard let apiHeroes = result["heroes"] as? [NSDictionary] else{
                print("Error no matches found")
                return
            }
//            for hero in apiHeroes{
//                guard let id = hero["id"] as? Int, let localizedName = hero["localized_name"] as? String,let name = hero["name"] as? String else{
//                    return
//                }
//                let imageHeroName = name.stringByReplacingOccurrencesOfString("npc_dota_hero_", withString: "")
//                let largeURL = "http://media.steampowered.com/apps/dota2/images/heroes/\(imageHeroName)_sb.png"
//                let smallURL = "http://media.steampowered.com/apps/dota2/images/heroes/\(imageHeroName)_sb.png"
//                let portraitURL = "http://cdn.dota2.com/apps/dota2/images/heroes/\(imageHeroName)_vert.jpg"
//                self.heroes.append(Hero(heroDotaName: name.stringByReplacingOccurrencesOfString("npc_dota_hero_", withString: ""), heroLocalizedName: localizedName, heroID: id,largeImageURL: largeURL,smallImageURL: smallURL,portraitImageURL: portraitURL))
//            }
//            self.heroes.sortInPlace(){
//                $0.heroLocalizedName < $1.heroLocalizedName
//            }
//            self.heroesTableView.reloadData()
        }
    }
    

}
