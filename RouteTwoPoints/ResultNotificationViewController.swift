//
//  ResultNotificationViewController.swift
//  RouteTwoPoints
//
//  Created by My Vo on 4/12/17.
//  Copyright © 2017 My Vo. All rights reserved.
//

import UIKit

class ResultNotificationViewController: UIViewController {

    
    @IBOutlet weak var lblResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let thongbao = UserDefaults.standard
        if(thongbao.value(forKey: "thongbao") != nil){
            let thongbao = thongbao.value(forKey: "thongbao") as! String
            lblResult.text = thongbao
            print(thongbao)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
