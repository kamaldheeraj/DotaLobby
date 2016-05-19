//
//  HeroDetailViewController.swift
//  DotaLobby
//
//  Created by Kamal Dandamudi on 5/19/16.
//  Copyright © 2016 SillyApps. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController {
    
    var hero:Hero?
    
    var heroDetail:HeroDetail?
    
    @IBOutlet var heroImageView: UIImageView!
    
    @IBOutlet var intLabel: UILabel!
    
    @IBOutlet var agilityLabel: UILabel!
    
    @IBOutlet var strengthLabel: UILabel!
    
    @IBOutlet var attackLabel: UILabel!
    
    @IBOutlet var speedLabel: UILabel!
    
    @IBOutlet var armorLabel: UILabel!
    
    @IBOutlet var bioLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if hero != nil {
            self.navigationItem.title = hero?.heroLocalizedName
            downloadHeroPortrait()
            parseHeroWithName(hero!.heroLocalizedName.stringByReplacingOccurrencesOfString(" ", withString: "_"))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func parseHeroWithName(name:String){
        var heroDetailPrimaryAttribute:PrimaryAttribute = .Strength
        var heroDetailAttackType:AttackType = .Melee
        var heroDetailRoles:[String] = [String]()
        var heroDetailBaseStrength:Double = 0
        var heroDetailStrengthIncrease:Double = 0
        var heroDetailBaseAgility:Double = 0
        var heroDetailAgilityIncrease:Double = 0
        var heroDetailBaseIntelligence:Double = 0
        var heroDetailIntelligenceIncrease:Double = 0
        var heroDetailMovementSpeed:Double = 0
        var heroDetailBaseArmor:Double = 0
        var heroDetailBaseAttackLow:Double = 0
        var heroDetailBaseAttackHigh:Double = 0
        var heroDetailDayVision:Double = 0
        var heroDetailNightVision:Double = 0
        var heroDetailAttackRange:Double = 0
        var heroDetailAbilities = [Ability]()
        //print("Parse Start")
        //guard let url = NSURL(string: "http://dota2.gamepedia.com/Abaddon") else{
        guard let url = NSURL(string: "http://www.dota2.com/hero/\(name.capitalizedString)/") else{
            print("Hero URL error")
            return
        }
        print(url)
        guard let urlData = NSData(contentsOfURL: url) else{
            print("Hero Data Error")
            return
        }
        guard let heroDataParser = TFHpple(HTMLData: urlData) else{
            print("Parser Initializing Error")
            return
        }
        //let start = NSDate();
        //let heroBaseStrengthXPath = "//table[@class='infobox']//th[a/@title='Strength']"
        let heroBaseStrengthXPath = "//div[@id='overview_StrVal']"
        guard let heroBaseStrength = heroDataParser.searchWithXPathQuery(heroBaseStrengthXPath) as? [TFHppleElement] else{
            print("Error finding Base Stength")
            return
        }
        if var heroStrengthData = heroBaseStrength.first?.content{
            heroStrengthData = heroStrengthData.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " \n"))
            let heroStrengthDataComponents = heroStrengthData.componentsSeparatedByString(" + ")
            if let baseStength = Double(heroStrengthDataComponents[0]){
                heroDetailBaseStrength = baseStength
                //print(heroDetailBaseStrength)
            }
            if let strengthIncrease = Double(heroStrengthDataComponents[1]){
                heroDetailStrengthIncrease = strengthIncrease
                //print(heroDetailStrengthIncrease)
            }
        }
        
        let heroBaseIntelligenceXPath = "//div[@id='overview_IntVal']"
        guard let heroBaseIntelligence = heroDataParser.searchWithXPathQuery(heroBaseIntelligenceXPath) as? [TFHppleElement] else{
            print("Error finding Base Intelligence")
            return
        }
        if var heroIntelligenceData = heroBaseIntelligence.first?.content{
            heroIntelligenceData = heroIntelligenceData.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " \n"))
            let heroIntelligenceDataComponents = heroIntelligenceData.componentsSeparatedByString(" + ")
            if let baseIntelligence = Double(heroIntelligenceDataComponents[0]){
                heroDetailBaseIntelligence = baseIntelligence
                //print(heroDetailBaseIntelligence)
            }
            if let intelligenceIncrease = Double(heroIntelligenceDataComponents[1]){
                heroDetailIntelligenceIncrease = intelligenceIncrease
                //print(heroDetailIntelligenceIncrease)
            }
        }
        
        let heroBaseAgilityXPath = "//div[@id='overview_AgiVal']"
        guard let heroBaseAgility = heroDataParser.searchWithXPathQuery(heroBaseAgilityXPath) as? [TFHppleElement] else{
            print("Error finding Base Agility")
            return
        }
        if var heroAgilityData = heroBaseAgility.first?.content{
            heroAgilityData = heroAgilityData.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " \n"))
            let heroAgilityDataComponents = heroAgilityData.componentsSeparatedByString(" + ")
            if let baseAgility = Double(heroAgilityDataComponents[0]){
                heroDetailBaseAgility = baseAgility
                //print(heroDetailBaseAgility)
            }
            if let agilityIncrease = Double(heroAgilityDataComponents[1]){
                heroDetailAgilityIncrease = agilityIncrease
                //print(heroDetailAgilityIncrease)
            }
        }
        
        
        let heroSpeedXPath = "//div[@id='overview_SpeedVal']"
        guard let heroSpeed = heroDataParser.searchWithXPathQuery(heroSpeedXPath) as? [TFHppleElement] else{
            print("Error finding Speed")
            return
        }
        if let heroSpeedData = heroSpeed.first?.content{
            if let speed = Double(heroSpeedData){
                heroDetailMovementSpeed = speed
                //print(heroDetailMovementSpeed)
            }
        }
        
        let heroPrimaryXPath = "//img[@id='overviewIcon_Primary']"
        guard let heroPrimary = heroDataParser.searchWithXPathQuery(heroPrimaryXPath) as? [TFHppleElement] else{
            print("Error finding Primary Attribute")
            return
        }
        if let heroPrimaryData = heroPrimary.first?.objectForKey("style") {
            if heroPrimaryData == "top:43px"{
                heroDetailPrimaryAttribute = .Agility
            }
            else if heroPrimaryData == "top:83px"{
                heroDetailPrimaryAttribute = .Strength
            }
            else{
                heroDetailPrimaryAttribute = .Intelligence
            }
            //print(heroDetailPrimaryAttribute)
        }
        
        let heroArmorXPath = "//div[@id='overview_DefenseVal']"
        guard let heroArmor = heroDataParser.searchWithXPathQuery(heroArmorXPath) as? [TFHppleElement] else{
            print("Error finding Armor")
            return
        }
        if let heroArmorData = heroArmor.first?.content{
            if let armor = Double(heroArmorData){
                heroDetailBaseArmor = armor
                //print(heroDetailBaseArmor)
            }
        }
        
        let heroRolesXPath = "//p[@id='heroBioRoles']"
        guard let heroRoles = heroDataParser.searchWithXPathQuery(heroRolesXPath) as? [TFHppleElement] else{
            print("Error finding Attack Type")
            return
        }
        if let heroRolesData = heroRoles.first?.content{
            self.bioLabel.text = heroRolesData
            heroDetailRoles = heroRolesData.componentsSeparatedByString(" - ")
            heroDetailRoles.removeAtIndex(0)
            //print(heroDetailRoles)
        }
        
        let heroAttackTypeXPath = "//span[@class='bioTextAttack']"
        guard let heroAttackType = heroDataParser.searchWithXPathQuery(heroAttackTypeXPath) as? [TFHppleElement] else{
            print("Error finding Attack Type")
            return
        }
        if let heroAttackTypeData = heroAttackType.first?.content{
            if heroAttackTypeData == "Melee"{
                heroDetailAttackType = .Melee
            }
            else{
                heroDetailAttackType = .Ranged
            }
            //print(heroDetailAttackType)
        }
        
        let heroAttackXPath = "//div[@id='overview_AttackVal']"
        guard let heroBaseAttack = heroDataParser.searchWithXPathQuery(heroAttackXPath) as? [TFHppleElement] else{
            print("Error finding Base Attack Values")
            return
        }
        if let heroBaseAttackData = heroBaseAttack.first?.content{
            let heroBaseAttackComponents = heroBaseAttackData.componentsSeparatedByString(" - ")
            if let baseAttackLow = Double(heroBaseAttackComponents[0]){
                heroDetailBaseAttackLow = baseAttackLow
                //print(heroDetailBaseAttackLow)
            }
            if let baseAttackHigh = Double(heroBaseAttackComponents[1]){
                heroDetailBaseAttackHigh = baseAttackHigh
                //print(heroDetailBaseAttackHigh)
            }
        }
        
        let heroAdditionalStatsXPath = "//div[@class='statRowCol2W']"
        guard let heroAdditionalStats = heroDataParser.searchWithXPathQuery(heroAdditionalStatsXPath) as? [TFHppleElement] else{
            print("Error finding Hero Additional Stats")
            return
        }
        if heroAdditionalStats.count > 0{
            if let heroVisionData = heroAdditionalStats.first?.content{
                let heroVisionComponents = heroVisionData.componentsSeparatedByString(" / ")
                if let dayVisionRange = Double(heroVisionComponents[0]){
                    heroDetailDayVision = dayVisionRange
                    //print(heroDetailDayVision)
                }
                if let nightVisionRange = Double(heroVisionComponents[1]){
                    heroDetailNightVision = nightVisionRange
                    //print(heroDetailNightVision)
                }
            }
            
            if let heroRangeData = heroAdditionalStats[1].content{
                if let attackRange = Double(heroRangeData){
                    heroDetailAttackRange = attackRange
                    //print(heroDetailAttackRange)
                }
            }
        }
        
        let heroAbilitiesXPath = "//div[@class='overviewAbilityRow']"
        guard let heroAbilities = heroDataParser.searchWithXPathQuery(heroAbilitiesXPath) as? [TFHppleElement] else{
            print("Error finding Abilities")
            return
        }
        for element in heroAbilities{
            let abilityNodes = element.children as! [TFHppleElement]
            let abilityImageDiv = abilityNodes[1]
            if let abilityDescriptionDiv = abilityNodes[3].children as? [TFHppleElement]{
                var abilityDotaName:String=""
                var abilityCommonName:String = ""
                var abilityDescription:String = ""
                var abilitySmallImageURL:String = ""
                var abilityLargeImageURL:String = ""
                for node in abilityDescriptionDiv{
                    if node.tagName == "h2"{
                        abilityCommonName = node.content
                    }
                    if node.tagName == "p"{
                        abilityDescription = node.content
                    }
                }
                if let abilityImageDivNodes = abilityImageDiv.children as? [TFHppleElement]{
                    for node in abilityImageDivNodes{
                        if node.tagName == "img"{
                            abilityDotaName = node.objectForKey("abilityname")
                            abilitySmallImageURL = "http://media.steampowered.com/apps/dota2/images/abilities/\(abilityDotaName)_hp1.png"
                            abilityLargeImageURL = "http://media.steampowered.com/apps/dota2/images/abilities/\(abilityDotaName)_hp2.png"
                            //print(abilityDotaName)
                        }
                    }
                }
                //print(abilityCommonName)
                //print(abilityDescription)
                if abilityCommonName != ""{
                    heroDetailAbilities.append(Ability(name: abilityCommonName, description: abilityDescription, dotaName: abilityDotaName, urlSmall: abilitySmallImageURL, urlLarge: abilityLargeImageURL))
                }
            }
        }
        heroDetail = HeroDetail(hero: self.hero!, primaryAttribute: heroDetailPrimaryAttribute, roles: heroDetailRoles, attackType: heroDetailAttackType, baseStrength: heroDetailBaseStrength, baseAgility: heroDetailBaseAgility, baseIntelligence: heroDetailBaseIntelligence, strengthIncrease: heroDetailStrengthIncrease, agilityIncrease: heroDetailAgilityIncrease, intelligenceIncrease: heroDetailIntelligenceIncrease, movementSpeed: heroDetailMovementSpeed, turnRate: 0, sightRangeDay: heroDetailDayVision, sightRangeNight: heroDetailNightVision, attackRange: heroDetailAttackRange, baseArmor: heroDetailBaseArmor, baseAttackLow: heroDetailBaseAttackLow, baseAttackHigh: heroDetailBaseAttackHigh, abilities: heroDetailAbilities)
        intLabel.text = String(Int(heroDetail!.baseIntelligence)) + " + " + String(heroDetail!.intelligenceIncrease)
        agilityLabel.text = String(Int(heroDetail!.baseAgility)) + " + " + String(heroDetail!.agilityIncrease)
        strengthLabel.text = String(Int(heroDetail!.baseStrength)) + " + " + String(heroDetail!.strengthIncrease)
        attackLabel.text = String(Int(heroDetail!.baseAttackLow)) + " - " + String(Int(heroDetail!.baseAttackHigh))
        speedLabel.text = String(Int(heroDetail!.movementSpeed))
        armorLabel.text = String(heroDetail!.baseArmor)
        //let end = NSDate();
        //let timeInterval: Double = end.timeIntervalSinceDate(start);
        //print(timeInterval)
    }
    
    func downloadHeroPortrait(){
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)){
            guard let url = NSURL(string:self.hero!.portraitImageURL!) else{
                return
            }
            guard let data = NSData(contentsOfURL: url) else{
                return
            }
            dispatch_async(dispatch_get_main_queue()){
                self.heroImageView.image = UIImage(data: data)
            }
        }
    }

}
