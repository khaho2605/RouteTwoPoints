//
//  MasterViewController.swift
//  RouteTwoPoints
//
//  Created by My Vo on 4/6/17.
//  Copyright © 2017 My Vo. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var sourceSearchBar: UISearchBar!
    
    @IBOutlet weak var destinationSearchBar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!
    
    var searchActive:Bool = false
    //var data = ["san","new york","chicago"]
    //var filtered:[String] = []
    
    var flag:Bool = false
    
    var transactiontime:String!
    var thongBaoUserDefault:String!

    let sourceData:[(id: String, name: String)] = [("09","CỔNG TRƯỜNG"),("10","NHÀ XE"),("11","A1"), ("12","A2"), ("13", "A3"), ("14", "A4"),("15", "A5"),("16","B1"), ("17","B2"), ("18", "B3"), ("19", "B4"),("20","B5"), ("21","B6"), ("22", "B8"), ("23", "B9"),("24","B10"), ("25","B11"), ("26", "B12"), ("27", "C1"),("28","C2"), ("29","C3"), ("30", "C4"),("31","C5"), ("32","C6"),("33","TRUNG TÂM ƯƠM TẠO DN")]
    
    var filteredSource:[(id:String,name:String)]=[]
    var filteredDestination:[(id:String,name:String)]=[]
    var userid:String!
    var source:String!
    var destination:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MasterViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        tap.delegate = self
        
        sourceSearchBar.delegate = self
        destinationSearchBar.delegate = self
        
        sourceSearchBar.tag = 1
        destinationSearchBar.tag = 2
        
        let email = UserDefaults.standard
        if(email.value(forKey: "email") != nil){
            let yourEmail = email.value(forKey: "email") as! String
            userid = yourEmail
            print(userid)
        }
    }
    
    
    @IBAction func Send(_ sender: Any) {
        
        // get datetime
        
        let date = NSDate()
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy-HH:mm"
        
        transactiontime = formatter.string(from: date as Date)
        print(transactiontime)
        
        // source vs destination
        source = sourceSearchBar.text?.replacingOccurrences(of: " ", with: "")
        destination = destinationSearchBar.text?.replacingOccurrences(of: " ", with: "")
        //http://saleiad.com/cw/insertdata.php?userid=myvanuit@gmail.com&transactiontime=10-04-2017&source=Nhaxe&destination=B4
        
        let s = "http://saleiad.com/cw/insertdata.php?userid=" + String(userid) + "&transactiontime=" + String(transactiontime) + "&source=" + String(source) + "&destination=" + String(destination)
        print(s)
        let sTemp:NSString = s as NSString
        
//        let sTemp:NSString = "http://saleiad.com/cw/insertdata.php?userid=myvanuit@gmail.com&transactiontime=11-04-2017-07:42&source=nhàxe&destination=A1"
        
        
        
        let s1 = sTemp.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        print(s1)
        
        let url:NSURL = NSURL(string: s1 as String)!
        
        print(url)
        
        var strThongBao:String = ""
        
        do{
            strThongBao = try NSString(contentsOf: url as URL, encoding:String.Encoding.utf8.rawValue) as String
            
            print(strThongBao)
        }catch{
            print("error")
        }
        
        
        // UserDefault gui thong bao
        if(strThongBao == "Successful"){
           thongBaoUserDefault = "Bạn đã gửi dữ liệu thành công từ vị trí " + source + " đến vị trí " + destination
        }else{
            thongBaoUserDefault = "Có lỗi xảy ra, bạn vui lòng kiểm tra kết nối internet !"
        }
        let thongbao = UserDefaults.standard
        thongbao.setValue(thongBaoUserDefault, forKey: "thongbao")

    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view!.isDescendant(of: tableView)) {
            return false
        }
        return true
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        var substring:String!
        
        if(searchBar == self.sourceSearchBar){
            
            substring = (sourceSearchBar.text! as NSString).replacingCharacters(in: range, with: text)
            sourceSearchBarEntriesWithSubstring(substring.uppercased())
            
            flag = false
            
        }else{
            
            substring = (destinationSearchBar.text! as NSString).replacingCharacters(in: range, with: text)
            destinationsearchBarEntriesWithSubstring(substring.uppercased())
            flag = true
            
        }

        //searchBarEntriesWithSubstring(substring.lowercased())
        
        return true
    }
    
    
    func sourceSearchBarEntriesWithSubstring(_ substring: String){
        filteredSource.removeAll(keepingCapacity: false)
        
        for (id,name) in sourceData {
            
            let myString:NSString! = name as NSString
            
            let substringRange :NSRange! = myString.range(of: substring)
            
            if (substringRange.location  == 0) {
            
                filteredSource.append((id:id,name:name))
                print(filteredSource)
            }
        }
        
        if(filteredSource.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
        tableView.reloadData()
    }

    func destinationsearchBarEntriesWithSubstring(_ substring: String){
        filteredDestination.removeAll(keepingCapacity: false)
        
        for (id,name) in sourceData {
            
            let myString:NSString! = name as NSString
            
            let substringRange :NSRange! = myString.range(of: substring)
            
            if (substringRange.location  == 0) {
                
                filteredDestination.append((id:id,name:name))
                print(filteredDestination)
            }
        }
        
        if(filteredDestination.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive && flag == false){
            return filteredSource.count
        }else if(searchActive && flag == true){
            return filteredDestination.count
        }else{
            return sourceData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        if(searchActive && flag == false){
            cell.textLabel?.text = filteredSource[indexPath.row].name
            
        }else if(searchActive && flag == true){
         
            cell.textLabel?.text = filteredDestination[indexPath.row].name
        }else{
           
            cell.textLabel?.text = sourceData[indexPath.row].name
        }*/
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        if(searchActive && flag == false && sourceSearchBar.text != ""){
            cell.cellName.text = filteredSource[indexPath.row].name
            cell.cellImages.image = UIImage(named: "Building2")
            
            
        }else if(searchActive && flag == true && destinationSearchBar.text != ""){
            
            cell.cellName.text = filteredDestination[indexPath.row].name
            cell.cellImages.image = UIImage(named: "Building2")
        }else{
            
            cell.cellName.text = sourceData[indexPath.row].name
            cell.cellImages.image = UIImage(named: "Building2")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        let selectedCell:CustomCell = tableView.cellForRow(at: indexPath) as! CustomCell
        
        
        if(flag==false){
            sourceSearchBar.text = selectedCell.cellName.text
            print("sourcebar")
            flag = true
        }else{
            destinationSearchBar.text = selectedCell.cellName.text
            flag = false
            print("des")
            
        }
        
        /*
        selectedCell.textLabel?.text
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        if(flag==false){
            sourceSearchBar.text = cell.cellName.text
            flag = true
            print("sourcebar")
        }else{
            destinationSearchBar.text = cell.cellName.text
            flag = false
            print("des")
            
        }*/
        
        dismissKeyboard()
        tableView.deselectRow(at: indexPath, animated:false)
    }
    
    

}
