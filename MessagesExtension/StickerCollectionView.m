//
//  StickerCollectionView.m
//  iMessageExtension
//
//  Created by Tom on 16/8/1.
//  Copyright © 2016年 RookieTomWu. All rights reserved.
//
#import "StickerCollectionView.h"
#import "StickerCell.h"
#import "CommonCell.h"

static NSString * const STICKERCELL = @"StickerCell";
static NSString * const COMMONCELL = @"CommonCell";

@interface StickerCollectionView ()

@property(strong, nonatomic)NSMutableArray *stickerArray;//数据

@end

@implementation StickerCollectionView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self registerNib:[UINib nibWithNibName:STICKERCELL bundle:nil] forCellWithReuseIdentifier:STICKERCELL];//注册单元格
        [self registerNib:[UINib nibWithNibName:COMMONCELL bundle:nil] forCellWithReuseIdentifier:COMMONCELL];
    }
    return self;
}


- (void)awakeFromNib{
    
    [super awakeFromNib];
    self.delegate = self;
    self.dataSource = self;
    
}

- (NSMutableArray *)stickerArray {
    
    if (!_stickerArray) {
        
        _stickerArray = [NSMutableArray array];
        NSArray *dataArray = @[@"001",@"002",@"003",@"004",@"005",@"006",@"007",@"008",@"009",@"010",@"011",@"012",@"013",@"014",@"015"];
        
        [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSURL *urlStr = [[NSBundle mainBundle]URLForResource:obj withExtension:@"png"];
            MSSticker *placeSticker = [[MSSticker alloc] initWithContentsOfFileURL:urlStr localizedDescription:obj error:nil];
            [_stickerArray addObject:placeSticker];
        }];
    }
    
    return _stickerArray;
}

#pragma mark - UICollectionDelegate && DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.stickerArray.count + 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < 4) {
        CommonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:COMMONCELL forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"other_%lu",indexPath.row + 1]];
        return cell;
        
    }else{
        
        StickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:STICKERCELL forIndexPath:indexPath];
        //把mssticker类型的数据赋予msstickerview里面的sticker属性
        cell.sticker.sticker = self.stickerArray[indexPath.row - 4];
        return cell;
    }

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //文字发送
        if (self.event1Block) {
            self.event1Block();
        }
    }else if (indexPath.row == 1){
         //音频发送
        if (self.event2Block) {
            self.event2Block();
        }
       
    }else if (indexPath.row == 2){
        //详细图
        if (self.event3Block) {
            self.event3Block();
        }
        
    }else if (indexPath.row == 3){
         //多图-gif
        if (self.event4Block) {
            self.event4Block();
        }
    }
    
}

@end
