//
//  CSVLogging.m
//  bleserial_test_iphone5
//
//  Created by tasukakeru on 2016/01/11.
//  Copyright © 2016年 石井 孝佳. All rights reserved.
//

//#import <Foundation/Foundation.h>
//
//
//#import "CSVLogging.h"
//
//@interface RecordViewController ()
//
//@end
//
//- CSVLogging.m
//@implementation RecordViewController
//
//@synthesize session;
//@synthesize recorder;
//@synthesize player;
//
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark - Helpers
//-(NSMutableDictionary *)setAudioRecorder
//{
//    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
//    [settings setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
//    [settings setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
//    [settings setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
//    [settings setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
//    [settings setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
//    [settings setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
//    
//    return settings;
//}
//
//-(void)recordFile
//{
//    // Prepare recording(Audio session)
//    NSError *error = nil;
//    self.session = [AVAudioSession sharedInstance];
//    
//    if ( session.inputAvailable )   // for iOS6 [session inputIsAvailable]  iOS5
//    {
//        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
//    }
//    
//    if ( error != nil )
//    {
//        NSLog(@"Error when preparing audio session :%@", [error localizedDescription]);
//        return;
//    }
//    [session setActive:YES error:&error];
//    if ( error != nil )
//    {
//        NSLog(@"Error when enabling audio session :%@", [error localizedDescription]);
//        return;
//    }
//    
//    // File Path
//    NSString *dir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    NSString *filePath = [dir stringByAppendingPathComponent:@"test.caf"];
//    NSURL *url = [NSURL fileURLWithPath:filePath];
//    
//    // recorder = [[AVAudioRecorder alloc] initWithURL:url settings:nil error:&error];
//    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:[self setAudioRecorder] error:&error];
//    
//    //recorder.meteringEnabled = YES;
//    if ( error != nil )
//    {
//        NSLog(@"Error when preparing audio recorder :%@", [error localizedDescription]);
//        return;
//    }
//    [recorder record];
//}
//
//- (void)stopRecord
//{
//    if ( self.recorder != nil && self.recorder.isRecording )
//    {
//        [recorder stop];
//        self.recorder = nil;
//    }
//}
//
//-(void)playRecord
//{
//    NSError *error = nil;
//    
//    // File Path
//    NSString *dir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    NSString *filePath = [dir stringByAppendingPathComponent:@"test.caf"];
//    NSURL *url = [NSURL fileURLWithPath:filePath];
//    
//    if ( [[NSFileManager defaultManager] fileExistsAtPath:[url path]] )
//    {
//        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
//        
//        if ( error != nil )
//        {
//            NSLog(@"Error %@", [error localizedDescription]);
//        }
//        [self.player prepareToPlay];
//        [self.player play];
//    }
//}
//
//- (IBAction)recordClick:(id)sender
//{
//    if ( self.recorder != nil && self.recorder.isRecording )
//    {
//        [self stopRecord];
//        [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
//    }
//    else
//    {
//        [self recordFile];
//        [self.recordButton setTitle:@"..." forState:UIControlStateNormal];
//    }
//}
//- (IBAction)playClick:(id)sender
//{
//    [self playRecord];
//}
//@end
