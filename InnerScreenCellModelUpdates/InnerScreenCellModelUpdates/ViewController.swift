//
//  ViewController.swift
//  InnerScreenCellModelUpdates
//
//  Created by Glenn Posadas on 12/9/21.
//

import UIKit

class Contact: NSObject {
  var name: String!
  var isFave: Bool = false
  
  init(name: String) {
    self.name = name

    super.init()
    
  }
  override var description: String {
    return "Contact---- \(String(describing: name)) is fave? \(isFave)"
  }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

 var contacts = [Contact]()
  @IBOutlet weak var tbv: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    contacts = [
      .init(name: "aaaaaa"),
      .init(name: "bbbbb"),
      .init(name: "ccccc"),
      .init(name: "ddddd")
    ]
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tbv.reloadData()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let d = segue.destination as! ViewController2
    d.contact = sender as? Contact
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let c = contacts[indexPath.row]
    performSegue(withIdentifier: "showContact", sender: c)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let c = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
    c.contact = contacts[indexPath.row]
    return c
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  
}


class ViewController2: UIViewController {

  @IBOutlet weak var isFave: UISwitch!
  @IBOutlet weak var nameLabel: UILabel!
  var contact: Contact!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    isFave.isOn = contact.isFave
    nameLabel.text = contact.name
  }


  @IBAction func togglez(_ sender: Any) {
    contact.isFave = (sender as! UISwitch).isOn
    print("contact -outervc- \(contact!)")
  }
  
}

class Cell: UITableViewCell {
  var contact: Contact! {
    didSet {
      isFave.isOn = contact.isFave
      name.text = contact.name
    }
  }
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var isFave: UISwitch!
  
  override func awakeFromNib() {
    super.awakeFromNib()

    
  }
  
//
//  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//    super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//    isFave.isOn = contact.isFave
//    name.text = contact.name
//  }
//
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
}
