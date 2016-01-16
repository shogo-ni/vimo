//
//  ViewController.h
//  Pillojoy_controll_iOS
//
//  Created by Vimo On 2016/1/7.
//  Copyright (c) 2016年Vimo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController{
    UIButton* _connectButton;
    UIButton* _disconnectButton;
    UITextField* _textField1;
    UITextField* _textField2;
    UIButton* _Pomp1OnButton;
    UIButton* _Pomp1OffButton;
    UIButton* _Pomp1ReleaseButton;
    UIButton* _Pomp2OnButton;
    UIButton* _Pomp2OffButton;
    UIButton* _Pomp2ReleaseButton;
    UIButton* _Pomp3OnButton;
    UIButton* _Pomp3OffButton;
    UIButton* _Pomp3ReleaseButton;
    UIButton* _Record;
    UIButton* _Stop;
    
}

// 加速度センシング
//@interface ViewController : UIViewControlle <UIAccelerometerDelegate>{
//    [[UIAccelerometer sharedAccelerometer]setUpdateInterval:0.1];
//    [[UIAccelerometer sharedAccelerometer]setDelegate:self];
//}

@end

