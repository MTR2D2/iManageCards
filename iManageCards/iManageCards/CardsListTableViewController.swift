//
//  CardsListTableViewController.swift
//  iManageCards
//
//  Created by david on 4/7/16.
//  Copyright © 2016 david. All rights reserved.
//

import UIKit

class CardsListTableViewController: UITableViewController {
  
  var cards: NSMutableArray! = [1, 2, 3, 4, 5, 6, 7, 8]
  var selectedIndex: NSIndexPath = NSIndexPath()
  var deselectedIndex: NSIndexPath = NSIndexPath()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if cards == nil {
      cards = NSMutableArray()
    }
  }

  // MARK: - Table view data source

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cards.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("CardCell", forIndexPath: indexPath) as! CardCell

    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    if indexPath != selectedIndex {
      selectedIndex = indexPath
    } else {
      selectedIndex = NSIndexPath()
    }
    
    
    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    
    
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
    switch indexPath {
    case selectedIndex: return 176
    default: return 88
    }
  }

}

class CardCell: UITableViewCell {
  
  private let cornerRadius: CGFloat = 4
  
  @IBOutlet weak var cardView: UIView!
  
  override func awakeFromNib() {
    cardView.layer.cornerRadius = cornerRadius
    selectionStyle = .None
  }
  
  override func layoutIfNeeded() {
    animateLayout()
    
    cardView.animateOpacity(.FadeOut) { 
      self.cardView.animateOpacity(.FadeIn, completionHandler: nil)
    }
  }
  
  
}

extension UIView {

  public enum AnimationType {
    case FadeIn
    case FadeOut
    case Whatever
  }
  
  func animateOpacity(animationType: AnimationType, completionHandler:(() -> Void)?) {
    
    var alpha: CGFloat!
    
    switch animationType {
    case .FadeIn: alpha = 1
    case .FadeOut: alpha = 0
    default: break;
    }
    
    UIView.animateWithDuration(0.25) {
      self.alpha = alpha
    }
  }
  
  func animateLayout() {
    UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .CurveEaseIn, animations: { 
      self.layoutIfNeeded()
      }, completion: nil)
  }
}
