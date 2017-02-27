//
//  SCPopCollectionCell.h
//  TRZX
//
//  Created by Rhino on 16/8/23.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCPopCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,assign)BOOL tradeSelected;

@end
