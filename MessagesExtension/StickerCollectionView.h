//
//  StickerCollectionView.h
//  iMessageExtension
//
//  Created by meitu on 16/8/1.
//  Copyright © 2016年 RookieTomWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StickerCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,copy)void(^event1Block)();
@property(nonatomic,copy)void(^event2Block)();
@property(nonatomic,copy)void(^event3Block)();
@property(nonatomic,copy)void(^event4Block)();

@end
