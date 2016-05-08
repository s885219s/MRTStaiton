//
//  MRTStationsData.swift
//  Homework2
//
//  Created by 陳宥丞 on 2016/5/6.
//  Copyright © 2016年 陳宥丞. All rights reserved.
//

import Foundation
import ObjectMapper

struct MRTStation{
    var name: String!
    var coordinate: [Double]!
    var lines: [String : String] = [:]
    init?(dictionary dict: NSDictionary) {}
}

extension MRTStation: Mappable{
    init?(_ map: Map){
    }
    
    mutating func mapping(map: Map){
        self.name <- map["name"]
        self.coordinate <- map["coordinate"]
        self.lines <- map["lines"]
    }
}

struct Line{
    let name: String
    let mrtStation : [MRTStation]
}

struct MRTStationsData{
    let lines: [Line]
    
    init?(contentsOfFile Path: String) throws {
        let jsonContent = try! String(contentsOfFile: Path)
        let MRTStationArray = Mapper<MRTStation>().mapArray(jsonContent)!
        
        var linesMap = [String: [MRTStation]]()
        for rawMRTStation in MRTStationArray{
            for(linesName,_) in rawMRTStation.lines{
                if(linesMap[linesName] == nil){
                    linesMap[linesName] = []
                }
                linesMap[linesName]!.append(rawMRTStation)
            }
        }
        
        var lines = [Line]()
        for (lineName, mrtStationsList) in linesMap{
            let line = Line(name: lineName, mrtStation:  mrtStationsList)
            lines.append(line)
        }
        self.lines = lines.sort { (lineA: Line, lineB: Line) -> Bool in
            return lineA.name < lineB.name
        }
    }
}
