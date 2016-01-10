//
//  ViewController.m
//  Pillojoy_controll_iOS
//
//  Created by Vimo On 2016/1/7.
//  Copyright (c) 2016年Vimo. All rights reserved.
//

#import "ViewController.h"
#import "BLEBaseClass.h"
#import <CoreBluetooth/CoreBluetooth.h>

#define CONNECT_BUTTON 0
#define DISCONNECT_BUTTON 1
#define Pomp1_ON_BUTTON 2
#define Pomp1_OFF_BUTTON 3
#define Pomp1_Release_BUTTON 4
#define Pomp2_ON_BUTTON 5
#define Pomp2_OFF_BUTTON 6
#define Pomp2_Release_BUTTON 7
#define Pomp3_ON_BUTTON 8
#define Pomp3_OFF_BUTTON 9
#define Pomp3_Release_BUTTON 10

//BLESerial
//#define UUID_VSP_SERVICE					@"569a1101-b87f-490c-92cb-11ba5ea5167c" //VSP
//#define UUID_RX                             @"569a2001-b87f-490c-92cb-11ba5ea5167c" //RX
//#define UUID_TX								@"569a2000-b87f-490c-92cb-11ba5ea5167c" //TX

//BLESerial2
#define UUID_VSP_SERVICE					@"bd011f22-7d3c-0db6-e441-55873d44ef40" //VSP
#define UUID_TX                             @"2a750d7d-bd9a-928f-b744-7d5a70cef1f9" //RX
#define UUID_RX								@"0503b819-c75b-ba9b-3641-6a7f338dd9bd" //TX

@interface ViewController () <BLEDeviceClassDelegate>
@property (strong)		BLEBaseClass*	BaseClass;
@property (readwrite)	BLEDeviceClass*	Device;
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //---センサー値結果のテキストフィールド生成---
    _textField=[[UITextField alloc] init];
    [_textField setFrame:CGRectMake(110,50,100,40)];  //位置と大きさ設定
    [_textField setText:@"---"];
    [_textField setBackgroundColor:[UIColor whiteColor]];
    [_textField setBorderStyle:UITextBorderStyleRoundedRect];
    _textField.font = [UIFont fontWithName:@"Helvetica" size:30];
    [self.view addSubview:_textField];
    
    //---CONNECTボタン生成---
    _connectButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_connectButton setFrame:CGRectMake(30,120,250,25)];  //位置と大きさ設定
    [_connectButton setTitle:@"CONNECT" forState:UIControlStateNormal];
    [_connectButton setTag:CONNECT_BUTTON];           //ボタン識別タグ
    [_connectButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];             //ボタンクリックイベント登録
    _connectButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [self.view addSubview:_connectButton];
    
    //---DISCONNECTボタン生成---
    _disconnectButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_disconnectButton setFrame:CGRectMake(30,170,250,25)];  //位置と大きさ設定
    [_disconnectButton setTitle:@"DIS CONNECT" forState:UIControlStateNormal];
    [_disconnectButton setTag:DISCONNECT_BUTTON];           //ボタン識別タグ
    [_disconnectButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];             //ボタンクリックイベント登録
    _disconnectButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [self.view addSubview:_disconnectButton];
    
    
    // ________ ---------  ________ --------- __________ ----------
    //---Pomp1 ONボタン生成--- ________ --------- __________ ----------
    _Pomp1OnButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_Pomp1OnButton setFrame:CGRectMake(30,220,250,25)];  //位置と大きさ設定
    [_Pomp1OnButton setTitle:@"Pomp1 ON" forState:UIControlStateNormal];
    [_Pomp1OnButton setTag:Pomp1_ON_BUTTON];           //ボタン識別タグ
    [_Pomp1OnButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];             //ボタンクリックイベント登録
    _Pomp1OnButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [self.view addSubview:_Pomp1OnButton];
    
    //---Pomp1 OFFボタン生成---
    _Pomp1OffButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_Pomp1OffButton setFrame:CGRectMake(30,270,250,25)];  //位置と大きさ設定
    [_Pomp1OffButton setTitle:@"Pomp1 OFF" forState:UIControlStateNormal];
    [_Pomp1OffButton setTag:Pomp1_OFF_BUTTON];           //ボタン識別タグ
    [_Pomp1OffButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];             //ボタンクリックイベント登録
    _Pomp1OffButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [self.view addSubview:_Pomp1OffButton];

    //---Pomp1 Releaseボタン生成---
    _Pomp1ReleaseButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_Pomp1ReleaseButton setFrame:CGRectMake(30,320,250,25)];  //位置と大きさ設定
    [_Pomp1ReleaseButton setTitle:@"Pomp1 Release" forState:UIControlStateNormal];
    [_Pomp1ReleaseButton setTag:Pomp1_Release_BUTTON];           //ボタン識別タグ
    [_Pomp1ReleaseButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];             //ボタンクリックイベント登録
    _Pomp1ReleaseButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [self.view addSubview:_Pomp1ReleaseButton];
    
    
    // ________ ---------  ________ --------- __________ ----------
    //---Pomp2 ONボタン生成--- ________ --------- __________ ----------
    _Pomp2OnButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_Pomp2OnButton setFrame:CGRectMake(30,370,250,25)];  //位置と大きさ設定
    [_Pomp2OnButton setTitle:@"Pomp2 ON" forState:UIControlStateNormal];
    [_Pomp2OnButton setTag:Pomp2_ON_BUTTON];           //ボタン識別タグ
    [_Pomp2OnButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];             //ボタンクリックイベント登録
    _Pomp2OnButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [self.view addSubview:_Pomp2OnButton];
    
    //---Pomp2 OFFボタン生成---
    _Pomp2OffButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_Pomp2OffButton setFrame:CGRectMake(30,420,250,25)];  //位置と大きさ設定
    [_Pomp2OffButton setTitle:@"Pomp2 OFF" forState:UIControlStateNormal];
    [_Pomp2OffButton setTag:Pomp2_OFF_BUTTON];           //ボタン識別タグ
    [_Pomp2OffButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];             //ボタンクリックイベント登録
    _Pomp2OffButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [self.view addSubview:_Pomp2OffButton];
 
    //---Pomp2 Releaseボタン生成---
    _Pomp2ReleaseButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_Pomp2ReleaseButton setFrame:CGRectMake(30,470,250,25)];  //位置と大きさ設定
    [_Pomp2ReleaseButton setTitle:@"Pomp2 Release" forState:UIControlStateNormal];
    [_Pomp2ReleaseButton setTag:Pomp2_Release_BUTTON];           //ボタン識別タグ
    [_Pomp2ReleaseButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];             //ボタンクリックイベント登録
    _Pomp2ReleaseButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [self.view addSubview:_Pomp2ReleaseButton];
    
    
    // ________ ---------  ________ --------- __________ ----------
    //---Pomp3 ONボタン生成--- ________ --------- __________ ----------
    _Pomp3OnButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_Pomp3OnButton setFrame:CGRectMake(30,520,250,25)];  //位置と大きさ設定
    [_Pomp3OnButton setTitle:@"Pomp3 ON" forState:UIControlStateNormal];
    [_Pomp3OnButton setTag:Pomp3_ON_BUTTON];           //ボタン識別タグ
    [_Pomp3OnButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];             //ボタンクリックイベント登録
    _Pomp3OnButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [self.view addSubview:_Pomp3OnButton];
    
    //---Pomp3 OFFボタン生成---
    _Pomp3OffButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_Pomp3OffButton setFrame:CGRectMake(30,570,250,25)];  //位置と大きさ設定
    [_Pomp3OffButton setTitle:@"Pomp3 OFF" forState:UIControlStateNormal];
    [_Pomp3OffButton setTag:Pomp3_OFF_BUTTON];           //ボタン識別タグ
    [_Pomp3OffButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];             //ボタンクリックイベント登録
    _Pomp3OffButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [self.view addSubview:_Pomp3OffButton];
    
    //---Pomp3 Releaseボタン生成---
    _Pomp3ReleaseButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_Pomp3ReleaseButton setFrame:CGRectMake(30,620,250,25)];  //位置と大きさ設定
    [_Pomp3ReleaseButton setTitle:@"Pomp3 Release" forState:UIControlStateNormal];
    [_Pomp3ReleaseButton setTag:Pomp3_Release_BUTTON];           //ボタン識別タグ
    [_Pomp3ReleaseButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];             //ボタンクリックイベント登録
    _Pomp3ReleaseButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [self.view addSubview:_Pomp3ReleaseButton];
    
    
    //---ボタンの状態設定---
    _connectButton.enabled = TRUE;
    _disconnectButton.enabled = FALSE;
    _Pomp1OnButton.enabled = FALSE;
    _Pomp1OffButton.enabled = FALSE;
    _Pomp1ReleaseButton.enabled = FALSE;
    _Pomp2OnButton.enabled = FALSE;
    _Pomp2OffButton.enabled = FALSE;
    _Pomp2ReleaseButton.enabled = FALSE;
    _Pomp3OnButton.enabled = FALSE;
    _Pomp3OffButton.enabled = FALSE;
    _Pomp3ReleaseButton.enabled = FALSE;
    
    
    //	BLEBaseClassの初期化
	_BaseClass = [[BLEBaseClass alloc] init];
	//	周りのBLEデバイスからのadvertise情報のスキャンを開始する
	[_BaseClass scanDevices:nil];
	_Device = 0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//------------------------------------------------------------------------------------------
//	readもしくはindicateもしくはnotifyにてキャラクタリスティックの値を読み込んだ時に呼ばれる
//------------------------------------------------------------------------------------------
- (void)didUpdateValueForCharacteristic:(BLEDeviceClass *)device Characteristic:(CBCharacteristic *)characteristic
{
	if (device == _Device)	{
		//	キャラクタリスティックを扱う為のクラスを取得し
		//	通知されたキャラクタリスティックと比較し同じであれば
		//	bufに結果を格納
        //iPhone->Device
		CBCharacteristic*	rx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_RX];
		if (characteristic == rx)	{
            //			uint8_t*	buf = (uint8_t*)[characteristic.value bytes]; //bufに結果が入る
            //            NSLog(@"value=%@",characteristic.value);
			return;
		}
        
        //Device->iPhone
		CBCharacteristic*	tx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_TX];
		if (characteristic == tx)	{
//            NSLog(@"Receive value=%@",characteristic.value);
            uint8_t*	buf = (uint8_t*)[characteristic.value bytes]; //bufに結果が入る
            _textField.text = [NSString stringWithFormat:@"%d", buf[0]];
			return;
		}
        
	}
}

//////////////////////////////////////////////////////////////
//  ボタンクリックイベント
//////////////////////////////////////////////////////////////
-(IBAction)onButtonClick:(UIButton*)sender{
    if(sender.tag==CONNECT_BUTTON){
        [self connect];
    }else if(sender.tag==DISCONNECT_BUTTON){
        [self disconnect];
    }else if(sender.tag==Pomp1_ON_BUTTON){
        [self sendOn1];
    }else if(sender.tag==Pomp1_OFF_BUTTON){
        [self sendOff1];
    }else if(sender.tag==Pomp1_Release_BUTTON){
        [self sendRelease1];
    }else if(sender.tag==Pomp2_ON_BUTTON){
        [self sendOn2];
    }else if(sender.tag==Pomp2_OFF_BUTTON){
        [self sendOff2];
    }else if(sender.tag==Pomp2_Release_BUTTON){
        [self sendRelease2];
//    }else if(sender.tag==Pomp3_ON_BUTTON){
//        [self sendOn3];
//    }else if(sender.tag==Pomp3_OFF_BUTTON){
//        [self sendOff3];
//    }else if(sender.tag==Pomp3_Release_BUTTON){
//        [self sendRelease3];
    }
    
}


//////////////////////////////////////////////////////////////
//  connect
//////////////////////////////////////////////////////////////
-(void)connect{
    //	UUID_DEMO_SERVICEサービスを持っているデバイスに接続する
	_Device = [_BaseClass connectService:UUID_VSP_SERVICE];
	if (_Device)	{
		//	接続されたのでスキャンを停止する
		[_BaseClass scanStop];
        //	キャラクタリスティックの値を読み込んだときに自身をデリゲートに指定
		_Device.delegate = self;
        
        //        [_BaseClass printDevices];
        
        //ボタンの状態変更
		_connectButton.enabled = FALSE;
		_disconnectButton.enabled = TRUE;
        _Pomp1OnButton.enabled = TRUE;
        _Pomp1OffButton.enabled = TRUE;
        _Pomp1ReleaseButton.enabled = TRUE;
        _Pomp2OnButton.enabled = TRUE;
        _Pomp2OffButton.enabled = TRUE;
        _Pomp2ReleaseButton.enabled = TRUE;
//        _Pomp3OnButton.enabled = TRUE;
//        _Pomp3OffButton.enabled = TRUE;
//        _Pomp3ReleaseButton.enabled = TRUE;
        
        
		//	tx(Device->iPhone)のnotifyをセット
		CBCharacteristic*	tx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_TX];
		if (tx)	{
            //            [_Device readRequest:tx];
			[_Device notifyRequest:tx];
		}
	}
}

//------------------------------------------------------------------------------------------
//	disconnectボタンを押したとき
//------------------------------------------------------------------------------------------
- (void)disconnect {
	if (_Device)	{
		//	UUID_DEMO_SERVICEサービスを持っているデバイスから切断する
		[_BaseClass disconnectService:UUID_VSP_SERVICE];
		_Device = 0;
        //ボタンの状態変更
		_connectButton.enabled = TRUE;
		_disconnectButton.enabled = FALSE;
        _Pomp1OnButton.enabled = FALSE;
        _Pomp1OffButton.enabled = FALSE;
        _Pomp1ReleaseButton.enabled = FALSE;
        _Pomp2OnButton.enabled = FALSE;
        _Pomp2OffButton.enabled = FALSE;
        _Pomp2ReleaseButton.enabled = FALSE;
//        _Pomp3OnButton.enabled = FALSE;
//        _Pomp3OffButton.enabled = FALSE;
//        _Pomp3ReleaseButton.enabled = FALSE;
        
		_textField.text = @"---";
		//	周りのBLEデバイスからのadvertise情報のスキャンを開始する
		[_BaseClass scanDevices:nil];
	}
}


//Pomp1 動作コマンド = 1　→　2
-(void)sendOn1{
    if (_Device)	{
        NSLog((@"Pomp1ON"));
		//	iPhone->Device
		CBCharacteristic*	rx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_RX];
		//	ダミーデータ
        uint8_t	buf[1];
        buf[0]=1;
        NSData*	data = [NSData dataWithBytes:&buf length:sizeof(buf)];
		[_Device writeWithoutResponse:rx value:data];
	}
}

//Pomp1 停止コマンド = 0
-(void)sendOff1{
    if (_Device)	{
        NSLog((@"Pomp1OFF"));
		//	iPhone->Device
		CBCharacteristic*	rx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_RX];
		//	ダミーデータ
        uint8_t	buf[1];
        buf[0]=0;
        NSData*	data = [NSData dataWithBytes:&buf length:sizeof(buf)];
		[_Device writeWithoutResponse:rx value:data];
	}
}


////Pomp1 解放コマンド = 2
-(void)sendRelease1{
    if (_Device)	{
        NSLog((@"Pomp1Release"));
        //	iPhone->Device
        CBCharacteristic*	rx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_RX];
        //	ダミーデータ
        uint8_t	buf[1];
        buf[0]=2;
        NSData*	data = [NSData dataWithBytes:&buf length:sizeof(buf)];
        [_Device writeWithoutResponse:rx value:data];
    }
}

////Pomp2 動作コマンド = 3
-(void)sendOn2{
    if (_Device)	{
        NSLog((@"Pomp2ON"));
        //	iPhone->Device
        CBCharacteristic*	rx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_RX];
        //	ダミーデータ
        uint8_t	buf[1];
        buf[0]=3;
        NSData*	data = [NSData dataWithBytes:&buf length:sizeof(buf)];
        [_Device writeWithoutResponse:rx value:data];
    }
}

////Pomp2 停止コマンド = 4
-(void)sendOff2{
    if (_Device)	{
        NSLog((@"Pomp2OFF"));
        //	iPhone->Device
        CBCharacteristic*	rx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_RX];
        //	ダミーデータ
        uint8_t	buf[1];
        buf[0]=4;
        NSData*	data = [NSData dataWithBytes:&buf length:sizeof(buf)];
        [_Device writeWithoutResponse:rx value:data];
    }
}

////Pomp2 解放コマンド = 5
-(void)sendRelease2{
    if (_Device)	{
        NSLog((@"Pomp2Release"));
        //	iPhone->Device
        CBCharacteristic*	rx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_RX];
        //	ダミーデータ
        uint8_t	buf[1];
        buf[0]=5;
        NSData*	data = [NSData dataWithBytes:&buf length:sizeof(buf)];
        [_Device writeWithoutResponse:rx value:data];
    }
}


////Pomp3 動作コマンド = 6
//-(void)sendOn3{
//    if (_Device)	{
//        NSLog((@"ON"));
//        //	iPhone->Device
//        CBCharacteristic*	rx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_RX];
//        //	ダミーデータ
//        uint8_t	buf[1];
//        buf[0]=6;
//        NSData*	data = [NSData dataWithBytes:&buf length:sizeof(buf)];
//        [_Device writeWithoutResponse:rx value:data];
//    }
//}
//
////Pomp3 停止コマンド = 7
//-(void)sendOff3{
//    if (_Device)	{
//        //	iPhone->Device
//        CBCharacteristic*	rx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_RX];
//        //	ダミーデータ
//        uint8_t	buf[1];
//        buf[0]=7;
//        NSData*	data = [NSData dataWithBytes:&buf length:sizeof(buf)];
//        [_Device writeWithoutResponse:rx value:data];
//    }
//}
//
////Pomp3 解放コマンド = 8
//-(void)sendRelease3{
//    if (_Device)	{
//        //	iPhone->Device
//        CBCharacteristic*	rx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_RX];
//        //	ダミーデータ
//        uint8_t	buf[1];
//        buf[0]=8;
//        NSData*	data = [NSData dataWithBytes:&buf length:sizeof(buf)];
//        [_Device writeWithoutResponse:rx value:data];
//    }
//}


@end
