//
//  MRTStationDetailViewControllerTwo.swift
//  Homework2
//
//  Created by 陳宥丞 on 2016/5/8.
//  Copyright © 2016年 陳宥丞. All rights reserved.
//

import UIKit

class MRTStationDetailViewControllerTwo: UIViewController {
    @IBOutlet weak var MRTStationNameTitle: UINavigationItem!
    @IBOutlet weak var MRTStationNameLabel: UILabel!
    @IBOutlet weak var MRTLineNameLabel: UILabel!
    var mrtLineName : Array<String> = []
    var mrtLineColor : UIColor?
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
        
        self.MRTStationNameTitle.title = mrtStation?.name
        self.MRTStationNameLabel.text = mrtStation?.name
        self.MRTLineNameLabel.text = mrtLineName[0]
        self.MRTLineNameLabel.backgroundColor = mrtLineColor
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
