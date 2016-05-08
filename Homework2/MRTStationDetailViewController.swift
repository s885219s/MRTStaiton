//
//  MRTStationDetailViewController.swift
//  Homework2
//
//  Created by 陳宥丞 on 2016/5/7.
//  Copyright © 2016年 陳宥丞. All rights reserved.
//

import UIKit

class MRTStationDetailViewController: UIViewController {

    @IBOutlet weak var MRTStationTitle: UINavigationItem!
    @IBOutlet weak var MRTStationNameLabel: UILabel!
    @IBOutlet weak var MRTLineNameLabel1: UILabel!
    @IBOutlet weak var MRTLineNameLabel2: UILabel!
    var mrtLineName : [String] = []
    var mrtLineColor1 : UIColor?
    var mrtLineColor2 : UIColor?
    var mrtStation: MRTStation?{
        didSet {
            self.updateValues()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.updateValues()
    }
    func updateValues() {
        guard self.isViewLoaded() else {
            return
        }
        
        self.MRTStationTitle.title = mrtStation?.name
        self.MRTStationNameLabel.text = mrtStation?.name
        self.MRTLineNameLabel1.text = mrtLineName[0]
        self.MRTLineNameLabel2.text = mrtLineName[1]
        self.MRTLineNameLabel1.backgroundColor = mrtLineColor1
        self.MRTLineNameLabel2.backgroundColor = mrtLineColor2
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
