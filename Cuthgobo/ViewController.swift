//
//  ViewController.swift
//  Cuthgobo
//
//  Created by Andrei Freeman on 8/23/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nextTurnButton: UIButton!
    @IBOutlet weak var drawView: DrawView!
    var wothcocu: Wothcocu?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        wothcocu = Wothcocu()
        drawView.wothcocu = wothcocu
        if wothcocu != nil {
            wothcocu!.beBorn()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func doNextTurn(_ sender: Any) {
    }
}
