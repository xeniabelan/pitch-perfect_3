//
//  RecordedAudio.swift
//  pitch perfect
//
//  Created by Ksenia Belan on 11/06/15.
//  Copyright (c) 2015 Ksenia Belan. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String){
    self.filePathUrl = filePathUrl
    self.title = title
    
}
}

