//
//  playViewController.h
//  originalSlideGame
//
//  Created by 中島 知秀 on 2015/01/24.
//  Copyright (c) 2015年 Tomohide Nakahsima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface playViewController : UIViewController
- (IBAction)playButton:(id)sender;

@property NSMutableArray *randNums;


// ハコことなるview
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;
@property (weak, nonatomic) IBOutlet UIView *view7;
@property (weak, nonatomic) IBOutlet UIView *view8;
@property (weak, nonatomic) IBOutlet UIView *view9;

// ハコに入れるimage (tag 11〜19)
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UIImageView *image5;
@property (weak, nonatomic) IBOutlet UIImageView *image6;
@property (weak, nonatomic) IBOutlet UIImageView *image7;
@property (weak, nonatomic) IBOutlet UIImageView *image8;
@property (weak, nonatomic) IBOutlet UIImageView *image9;


// 見本用 (tag 21〜29)
@property (weak, nonatomic) IBOutlet UIImageView *mihon9;


// tap判定用の透明view (tag 1〜9)


// 管理用の配列
@property NSMutableArray *viewArray1;
@property NSMutableArray *viewArray2;
@property NSMutableArray *viewArray3;
@property NSMutableArray *viewArray4;
@property NSMutableArray *viewArray5;
@property NSMutableArray *viewArray6;
@property NSMutableArray *viewArray7;
@property NSMutableArray *viewArray8;
@property NSMutableArray *viewArray9;



@end