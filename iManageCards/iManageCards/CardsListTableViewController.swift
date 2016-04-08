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
    
    tableView.separatorStyle = .None
    
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

    cell.animateSelection(indexPath == selectedIndex)
    
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
    case selectedIndex: return 222
    default: return 88
    }
  }

}

class CardCell: UITableViewCell {
  
  private let cornerRadius: CGFloat = 4
  
  @IBOutlet weak var cardView: UIView!
  
  @IBOutlet weak var selectedCardView: UIView!
  @IBOutlet weak var deselectedCardView: UIView!
  
  override func awakeFromNib() {
    cardView.layer.cornerRadius = cornerRadius
    cardView.layer.masksToBounds = true
    selectionStyle = .None
  }
  
  func animateSelection(selected: Bool) {
    
//    self.animateLayout()
    
    switch selected {
    case true: showSelectedView()
    case false: showDeselectedView()
    }
  }
  
  func showSelectedView() {
    deselectedCardView.animateOpacity(.FadeOut) { 
      self.selectedCardView.animateOpacity(.FadeIn, completionHandler: nil)
    }
    
    deselectedCardView.hidden = true
    selectedCardView.hidden = false
  }
  
  func showDeselectedView() {
    selectedCardView.animateOpacity(.FadeOut) { 
      self.deselectedCardView.animateOpacity(.FadeIn, completionHandler: nil)
    }
    
    deselectedCardView.hidden = false
    selectedCardView.hidden = true
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
