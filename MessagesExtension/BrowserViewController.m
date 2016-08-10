//
//  BrowserViewController.m
//  iMessageExtension
//
//  Created by Tom on 16/8/1.
//  Copyright © 2016年 RookieTomWu. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()

@property (strong, nonatomic)NSMutableArray *browArray;

@end

@implementation BrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//数据加载
- (NSMutableArray *)browArray{
    
    if (!_browArray) {
        _browArray = [NSMutableArray array];
        NSArray *dataArray = @[@"dt_1",@"dt_2",@"dt_3",@"dt_4",@"dt_5",@"dt_6",@"dt_7",@"dt_8",@"dt_9",@"dt_10",@"dt_11",@"dt_12",@"dt_13"];
        
        //把图片转换为mssticker类的形式，用于显示
        [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSURL *urlStr = [[NSBundle mainBundle]URLForResource:obj withExtension:@"gif"];
            MSSticker *placeSticker = [[MSSticker alloc] initWithContentsOfFileURL:urlStr localizedDescription:obj error:nil];
            [_browArray addObject:placeSticker];
        }];
    }
    return _browArray;
}

#pragma mark - MSStickerBrowserViewDataSource

- (NSInteger)numberOfStickersInStickerBrowserView:(MSStickerBrowserView *)stickerBrowserView {
    
    return self.browArray.count;
}

- (MSSticker *)stickerBrowserView:(MSStickerBrowserView *)stickerBrowserView stickerAtIndex:(NSInteger)index {
    
    return self.browArray[index];
}


@end
