//
//  MRTStationsListViewController.swift
//  Homework2
//
//  Created by 陳宥丞 on 2016/5/4.
//  Copyright © 2016年 陳宥丞. All rights reserved.
//

import UIKit

class MRTStationsListViewController: UITableViewController {
    var MRTStationData : MRTStationsData!
    let lineColorDict : [String : UIColor] =
        ["文湖線" : UIColor(red: 158/255.0, green: 101/255.0, blue: 46/255.0, alpha: 1.0), "淡水信義線" : UIColor(red: 203/255.0, green: 44/255.0, blue: 48/255.0, alpha: 1.0), "新北投支線" : UIColor(red: 248/255.0, green: 144/255.0, blue: 165/255.0, alpha: 1.0), "松山新店線" : UIColor(red: 0/255.0, green: 119/255.0, blue: 73/255.0, alpha: 1.0), "小碧潭支線" : UIColor(red: 206/255.0, green: 220/255.0, blue: 0/255.0, alpha: 1.0), "中和新蘆線" : UIColor(red: 255/255.0, green: 163/255.0, blue: 0/255.0, alpha: 1.0), "板南線" : UIColor(red: 0/255.0, green: 94/255.0, blue: 184/255.0, alpha: 1.0), "貓空纜車" : UIColor(red: 119/255.0, green: 185/255.0, blue: 51/255.0, alpha: 1.0)]
    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("MRT", ofType: "json")!
        guard let data = try? MRTStationsData(contentsOfFile: path) else{
            fatalError()
        }
        self.MRTStationData = data
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return self.MRTStationData.lines.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.MRTStationData.lines[section].mrtStation.count
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.MRTStationData.lines[section].name
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let mrtLine = self.MRTStationData.lines[indexPath.section]
        let mrtStation = self.MRTStationData.lines[indexPath.section].mrtStation[indexPath.row]
        let lineKeyArray = Array(mrtStation.lines.keys)
        let lineValueArray = Array(mrtStation.lines.values)
        
        print(mrtLine.name)
        if(mrtStation.lines.count==1){
            let cell = tableView.dequeueReusableCellWithIdentifier("CellTwo", forIndexPath: indexPath) as! MRTStationTableViewCellTwo
            cell.MRTStationName?.text = mrtStation.name
            cell.MRTLineNum1?.text = lineValueArray[0]
            for (lineName,lineColor) in lineColorDict{
                if(lineKeyArray[0]==lineName){
                    cell.MRTLineNum1?.backgroundColor = lineColor
                }
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MRTStationTableViewCell
            cell.MRTStationName?.text = mrtStation.name
            for (lineKey,lineValue) in mrtStation.lines{
                if(lineKey==mrtLine.name){
                    cell.MRTLineNum1?.text = lineValue
                }
                else{
                    cell.MRTLineNum2?.text = lineValue
                }
            }
            for (lineKey,_) in mrtStation.lines{
                if(lineKey==mrtLine.name){
                    for (lineName,lineColor) in lineColorDict{
                        if(lineKey==lineName){
                            cell.MRTLineNum1?.backgroundColor = lineColor
                        }
                    }
                }
                else{
                    for (lineName,lineColor) in lineColorDict{
                        if(lineKey==lineName){
                            cell.MRTLineNum2?.backgroundColor = lineColor
                        }
                    }
                }
            }
            return cell
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailOne" {
            guard let cell = sender as? MRTStationTableViewCell else { return }
            let indexPath = self.tableView.indexPathForCell(cell)!
            let mrtLine = self.MRTStationData.lines[indexPath.section]
            let mrtStation = self.MRTStationData.lines[indexPath.section].mrtStation[indexPath.row]
            let mrtLineNames = Array(mrtStation.lines.keys)
            guard let detailViewController = segue.destinationViewController as? MRTStationDetailViewController else {
                return
            }
            detailViewController.mrtStation = mrtStation
            detailViewController.mrtLineName = mrtLineNames
            for mrtLineName in mrtLineNames{
                if(mrtLineName==mrtLine.name){
                    for (lineName,lineColor) in lineColorDict{
                        if(mrtLineName==lineName){
                            detailViewController.mrtLineColor2 = lineColor
                        }
                    }
                }
                    else{
                    for (lineName,lineColor) in lineColorDict{
                        if(mrtLineName==lineName){
                            detailViewController.mrtLineColor1 = lineColor
                        }
                    }
                }
            }
        }
        else if segue.identifier == "showDetailTwo" {
            guard let cellTwo = sender as? MRTStationTableViewCellTwo else { return }
            let indexPath = self.tableView.indexPathForCell(cellTwo)!
            let mrtStation = self.MRTStationData.lines[indexPath.section].mrtStation[indexPath.row]
            let mrtLineName = Array(mrtStation.lines.keys)
            guard let detailViewController = segue.destinationViewController as? MRTStationDetailViewControllerTwo else {
                return
            }
            detailViewController.mrtStation = mrtStation
            detailViewController.mrtLineName = mrtLineName
            for (lineName,lineColor) in lineColorDict{
                if(mrtLineName[0]==lineName){
                    detailViewController.mrtLineColor = lineColor
                }
            }
        }
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
