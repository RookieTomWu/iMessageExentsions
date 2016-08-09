//
//  StickerCell.h
//  MessageProject
//
//  Created by 孙云 on 16/7/28.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Messages/Messages.h>

@interface StickerCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet MSStickerView *sticker;//可以有点击拖拽动作的view
@end
