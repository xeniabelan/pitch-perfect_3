//
//  RecordSoundsViewController.swift
//  pitch perfect
//
//  Created by Ksenia Belan on 11/06/15.
//  Copyright (c) 2015 Ksenia Belan. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var tapToRecord: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
    }

    @IBAction func recordAudio(sender: UIButton) {
      
        stopButton.hidden = false
        tapToRecord.hidden = true
        recordingInProgress.hidden = false
        recordButton.enabled = false
        println("in recordAudio")
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        

    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag){
        recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
    
        
        performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else {
            println("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
            if (segue.identifier == "stopRecording"){
                let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
                
                let data = sender as! RecordedAudio
                playSoundsVC.receivedAudio = data
                
            }
        }
        
    
    
    @IBAction func stopRecording(sender: UIButton) {
    //hide "recording in progress"
        //stop recording
        stopButton.hidden = true
        recordingInProgress.hidden = true
        recordButton.enabled = true
        tapToRecord.hidden = false
        println("stop recording")
        
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    
    }
}
