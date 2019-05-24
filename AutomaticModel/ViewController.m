//
//  AppDelegate.m
//  AutomaticModel
//
//  Created by 刘梓轩 on 2018/11/27.
//  Copyright © 2018年 刘梓轩. All rights reserved.
//
#define ScreenWidth             [UIScreen mainScreen].bounds.size.width
#define ScreenHeight            [UIScreen mainScreen].bounds.size.height

@import iOSDFULibrary;

#import "ViewController.h"
#import "TopCell.h"
#import "NetManager.h"
#import <Foundation/Foundation.h>
#import "EasyBlueToothManager.h"


@interface ViewController ()<LoggerDelegate, DFUServiceDelegate, DFUProgressDelegate>
@property (nonatomic) NSMutableArray<MJData *> *dataList;
//每次的请求返回值
@property (nonatomic) MJRootClass *top;
@property(nonatomic,strong) UIButton *linkBtn;
@property(nonatomic,strong) UIButton *linkBtn2;
@property (nonatomic,strong) UIProgressView *progress;
@property (nonatomic,strong)EasyCenterManager  *centerManager;
@property (nonatomic,strong)EasyPeripheral *peri;
@property (nonatomic, strong ) CBCentralManager *centalManager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic,strong)UILabel *dislabel;
@end

@implementation ViewController

- (void)viewDidLoad {
     self.title = @"固件升级测试";
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.centerManager scanDeviceWithTimeInterval:NSIntegerMax services:nil options:@{ CBCentralManagerScanOptionAllowDuplicatesKey: @YES }  callBack:^(EasyPeripheral *peripheral, searchFlagType searchType) {
        if (peripheral) {
            if (searchType&searchFlagTypeChanged) {
                //NSInteger perpheralIndex = [weakself.dataArray indexOfObject:peripheral];
                //[weakself.dataArray replaceObjectAtIndex:perpheralIndex withObject:peripheral];
                NSLog(@"%@状态已经改变",peripheral.name);
                [self changeInfoLable:peripheral];
            }
            else if(searchType&searchFlagTypeAdded){
                //[weakself.dataArray addObject:peripheral];
                NSLog(@"%@是新设备",peripheral.name);
                
                [self changeInfoLable:peripheral];
            }
            else if (searchType&searchFlagTypeDisconnect || searchType&searchFlagTypeDelete){
                //[weakself.dataArray removeObject:peripheral];
                NSLog(@"%@已经断开",peripheral.name);
                [self changeInfoLable:peripheral];
            }
            queueMainStart
            //[weakself.tableView reloadData];
            queueEnd
        }
    }];
    
    self.centerManager.stateChangeCallback = ^(EasyCenterManager *manager, CBManagerState state) {
        [self managerStateChanged:state];
    };
    
    
    
    _linkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _linkBtn.frame = CGRectMake((ScreenWidth - 150)/2, 200, 150, 25);
    [_linkBtn setTitle:@"点击升级" forState:UIControlStateNormal];
    [_linkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_linkBtn setBackgroundColor:[UIColor greenColor]];
    [_linkBtn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_linkBtn];
    
    _dislabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth - 150)/2, 150, 150, 25)];
    _dislabel.text = @"";
    _dislabel.textAlignment = 0 ;
    _dislabel.numberOfLines = 1;
    _dislabel.textColor = [UIColor blackColor];
    _dislabel.font = [UIFont systemFontOfSize:18];
    _dislabel.layer.borderColor = [UIColor blackColor].CGColor;
    _dislabel.layer.borderWidth = 1;
    [self.view addSubview:_dislabel];
    
    _linkBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _linkBtn2.frame = CGRectMake((ScreenWidth - 150)/2, 100, 150, 25);
    [_linkBtn2 setTitle:@"连接" forState:UIControlStateNormal];
    [_linkBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_linkBtn2 setBackgroundColor:[UIColor greenColor]];
    [_linkBtn2 addTarget:self action:@selector(btnclickdddd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_linkBtn2];
    
    [self.view addSubview:self.progress];
    
}
-(void)btnclickdddd
{
    [self connectactionActionSucces];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.centerManager startScanDevice];
    
}
-(void)changeInfoLable:(EasyPeripheral *)peripheral
{
    if ([peripheral.name isEqualToString:@"Nordic_UART"]) {
        NSArray *serviceArray = [peripheral.advertisementData objectForKey:CBAdvertisementDataServiceUUIDsKey];
        NSString *connectStr=@"未连接";
        if (peripheral.state == CBPeripheralStateConnected) {
            connectStr = @"已连接";
            queueMainStart
            self.centalManager=self.centerManager.manager;
            self.peripheral=peripheral.peripheral;
            self.dislabel.text = peripheral.name;
            
            
            queueEnd
        }else{
            connectStr=@"未连接";
        }
        self.peri=peripheral;
        
    }
}
- (void)managerStateChanged:(CBManagerState)state
{
    queueMainStart
    if (state == CBManagerStatePoweredOn) {
        UIView *coverView = [[UIApplication sharedApplication].keyWindow viewWithTag:1011];
        if (coverView) {
            [coverView removeFromSuperview];
            coverView = nil ;
        }
        
        UIViewController *vc = [EasyUtils topViewController];
        if ([vc isKindOfClass:[self class]]) {
            [self.centerManager startScanDevice];
        }
        
    }
    else if (state == CBManagerStatePoweredOff){
        UILabel *coverLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        coverLabel.font = [UIFont systemFontOfSize:20];
        coverLabel.tag = 1011 ;
        coverLabel.textAlignment = NSTextAlignmentCenter ;
        coverLabel.text = @"系统蓝牙已关闭，请打开系统蓝牙";
        coverLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [[UIApplication sharedApplication].keyWindow addSubview:coverLabel];
    }
    queueEnd
}
- (EasyCenterManager *)centerManager
{
    if (nil == _centerManager) {
        
        dispatch_queue_t queue = dispatch_queue_create("com.easyBluetootth.demo", 0);
        _centerManager = [[EasyCenterManager alloc]initWithQueue:queue options:nil];
    }
    return _centerManager ;
}

- (void)deviceConnect:(EasyPeripheral *)peripheral error:(NSError *)error
{
    queueMainStart
    //    [EFShowView HideHud];
    //    if (error) {
    //        [EFShowView showErrorText:error.domain];
    //    }
    //    else{
    //        ToolDetailViewController *tooD = [[ToolDetailViewController alloc]init];
    //        tooD.peripheral = peripheral ;
    //        [self.navigationController  pushViewController:tooD animated:YES];
    //    }
    
    queueEnd
}
- (void)connectactionActionSucces{
    
    if (self.peri.state==CBPeripheralStateConnected) {
        [self changeInfoLable:self.peri];
        return;
    }
    kWeakSelf(self);
    [self.peri connectDeviceWithCallback:^(EasyPeripheral *perpheral, NSError *error, deviceConnectType deviceConnectType) {
        if (deviceConnectType == deviceConnectTypeDisConnect) {
            [weakself changeInfoLable:perpheral];
        }
        else{
            [weakself changeInfoLable:perpheral];
        }
        queueMainStart
        //[BOEProgressHUD showWithStatus:@""];
        [self.peri discoverAllDeviceServiceWithCallback:^(EasyPeripheral *peripheral, NSArray<EasyService *> *serviceArray, NSError *error) {
            
            //        NSLog(@"%@  == %@",serviceArray,error);
            
            
            for (EasyService *tempS in serviceArray) {
                //            NSLog(@" %@  = %@",tempS.UUID ,tempS.description);
                
                [tempS discoverCharacteristicWithCallback:^(NSArray<EasyCharacteristic *> *characteristics, NSError *error) {
                    //                NSLog(@" %@  = %@",characteristics , error );
                    
                    for (EasyCharacteristic *tempC in characteristics) {
                        [tempC discoverDescriptorWithCallback:^(NSArray<EasyDescriptor *> *descriptorArray, NSError *error) {
                            //                        NSLog(@"%@ ====", descriptorArray)  ;
                            //                        if (descriptorArray.count > 0) {
                            //                            for (EasyDescriptor *d in descriptorArray) {
                            //                                NSLog(@"%@ - %@ %@ ", d,d.UUID ,d.value);
                            //                            }
                            //                        }
                            for (EasyDescriptor *desc in descriptorArray) {
                                [desc readValueWithCallback:^(EasyDescriptor *descriptor, NSError *error) {
                                    //                                NSLog(@"读取descriptor的值：%@ ,%@ ",descriptor.value,error);
                                }];
                            }
                            
                            
                            //[BOEProgressHUD dismiss];
                            
                        }];
                    }
                }];
            }
        }];
        
        queueEnd
        
    }];
    
    
    
}
-(void)btnclick{
    // To start the DFU operation the DFUServiceInitiator must be used
    NSString *path = [[NSBundle mainBundle] pathForResource:@"app_dfu_package" ofType:@"zip"];
    NSURL *url = [NSURL URLWithString:path];
    DFUFirmware *selectedFirmware = [[DFUFirmware alloc] initWithUrlToZipFile:url];
    DFUServiceInitiator *initiator = [[DFUServiceInitiator alloc] initWithCentralManager: self.centalManager target:self.peripheral
                                      ];
    [initiator withFirmware:selectedFirmware];
 
    initiator.logger = self;
    initiator.delegate = self;
    initiator.progressDelegate = self;
    // initiator.peripheralSelector = ... // the default selector is used
    DFUServiceController *controller  = [initiator start];
    
    
}
-(UIProgressView *)progress {
    if (!_progress) {
        
        //进度条高度不可修改
        _progress = [[UIProgressView alloc] initWithFrame:CGRectMake((ScreenWidth - 150)/2, 250, 150, 25)];
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
        _progress.transform = transform;
        //设置进度条的颜色
        _progress.progressTintColor = [UIColor blueColor];
        
        //设置进度条的当前值，范围：0~1；
        _progress.progress = 0;
        
        /*
         typedef NS_ENUM(NSInteger, UIProgressViewStyle) {
         UIProgressViewStyleDefault,     // normal progress bar
         UIProgressViewStyleBar __TVOS_PROHIBITED,     // for use in a toolbar
         };
         */
        _progress.progressViewStyle = UIProgressViewStyleDefault;
    }
    return _progress;
}

//更新进度
- (void)dfuProgressDidChangeFor:(NSInteger)part outOf:(NSInteger)totalParts to:(NSInteger)progress currentSpeedBytesPerSecond:(double)currentSpeedBytesPerSecond avgSpeedBytesPerSecond:(double)avgSpeedBytesPerSecond{
    
    _progress.progress = ((float) progress /totalParts)/100;
}


-(void)logWith:(enum LogLevel)level message:(NSString *)message
{
    NSLog(@"%logWith ld: %@", (long) level, message);
}

//更新进度状态  升级开始..升级中断..升级完成等状态
- (void)dfuStateDidChangeTo:(enum DFUState)state{
    
    NSLog(@"DFUState state%ld",state);
    //升级完成
    if (state==DFUStateCompleted) {
        NSLog(@"升级完成");
    }
    
}


//升级error信息
- (void)dfuError:(enum DFUError)error didOccurWithMessage:(NSString * _Nonnull)message{
    
    NSLog(@"Error %ld: %@", (long) error, message);
}


@end
