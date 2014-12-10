//
//  ViewController.swift
//  Props
//
//  Created by Brandon Smith on 11/30/14.
//  Copyright (c) 2014 Props. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBLoginViewDelegate {
  
  @IBOutlet var fbLoginView : FBLoginView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.fbLoginView.delegate = self
    self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // Facebook Delegate Methods
  func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
    println("User Logged In")
  }
  
  func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
    var newUser = PFObject(className: "PropsUser")
    newUser["fbId"] = user.objectID;
    newUser["name"] = user.name;
    var userEmail = user.objectForKey("email") as String
    newUser["email"] = userEmail
    newUser.saveInBackgroundWithBlock { (result: Bool,error: NSError!) -> Void in
      if(result) {
        println("It worked.")
      } else {
        println("Damn, it didn't work.")
      }
    }
  }
  
  func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
    println("User Logged Out")
  }
  
  func loginView(loginView : FBLoginView!, handleError:NSError) {
    println("Error: \(handleError.localizedDescription)")
  }
}

