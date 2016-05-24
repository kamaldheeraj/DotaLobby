//
//  MatchesViewController.swift
//  DotaLobby
//
//  Created by Kamal Dandamudi on 5/16/16.
//  Copyright © 2016 SillyApps. All rights reserved.
//

import UIKit

class MatchesViewController: UIViewController {
    
    let authorizationEndpoint =
    NSURL(string:"https://accounts.google.com/o/oauth2/v2/auth")
    
    let tokenEndpoint =
    NSURL(string:"https://www.googleapis.com/oauth2/v4/token")
    
    var authState:OIDAuthState?
    
    var configuration:OIDServiceConfiguration?

    override func viewDidLoad() {
        super.viewDidLoad()

        configuration = OIDServiceConfiguration(authorizationEndpoint: authorizationEndpoint!, tokenEndpoint: tokenEndpoint!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func steamButtonPressed(sender: AnyObject) {
        let request = OIDAuthorizationRequest(configuration: configuration!, clientId: "", scopes: [OIDScopeOpenID,OIDScopeProfile], redirectURL: NSURL(string:"com.sillyapps.DotaLobby:/oauthredirect")!, responseType: OIDResponseTypeCode, additionalParameters: nil)
    }
    

}
