//
//  HeroesViewController.swift
//  DotaLobby
//
//  Created by Kamal Dandamudi on 5/16/16.
//  Copyright © 2016 SillyApps. All rights reserved.
//

import UIKit
import Alamofire

class HeroesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var heroes = [Hero]()
    @IBOutlet var heroesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadHeroesFromAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("heroCell") as! HeroTableViewCell
        let hero = heroes[indexPath.row]
        cell.hero = hero
        cell.heroNameLabel.text = hero.heroLocalizedName
        if let heroSmallImageURL = hero.smallImageURL{
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)){
                if let heroImage = ImageCache.fetchImageWithURL(heroSmallImageURL){
                    dispatch_async(dispatch_get_main_queue()){
                        cell.heroImageView.image = heroImage
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as! HeroDetailViewController
        if let cell = sender as? HeroTableViewCell{
            destVC.hero = cell.hero
        }
    }
    
    
    func downloadHeroesFromAPI(){
        Alamofire.request(.GET, "http://api.steampowered.com/IEconDOTA2_570/GetHeroes/v0001/?key=29F8F26D275F5540E7BB0A6A3FC02D06",parameters: ["language":"en-us"],encoding: .URL).validate().responseJSON(){
            response in
            guard response.result.isSuccess else{
                print("Error while fetching Heroes list : \(response.result.error)")
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
                print("Error no heroes found")
                return
            }
            for hero in apiHeroes{
                guard let id = hero["id"] as? Int, let localizedName = hero["localized_name"] as? String,let name = hero["name"] as? String else{
                    return
                }
                let imageHeroName = name.stringByReplacingOccurrencesOfString("npc_dota_hero_", withString: "")
                let largeURL = "http://media.steampowered.com/apps/dota2/images/heroes/\(imageHeroName)_sb.png"
                let smallURL = "http://media.steampowered.com/apps/dota2/images/heroes/\(imageHeroName)_sb.png"
                let portraitURL = "http://cdn.dota2.com/apps/dota2/images/heroes/\(imageHeroName)_vert.jpg"
                self.heroes.append(Hero(heroDotaName: name.stringByReplacingOccurrencesOfString("npc_dota_hero_", withString: ""), heroLocalizedName: localizedName, heroID: id,largeImageURL: largeURL,smallImageURL: smallURL,portraitImageURL: portraitURL))
            }
            self.heroes.sortInPlace(){
                $0.heroLocalizedName < $1.heroLocalizedName
            }
            self.heroesTableView.reloadData()
        }
    }

}

