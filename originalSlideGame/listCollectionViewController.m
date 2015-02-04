//
//  listCollectionViewController.m
//  originalSlideGame
//
//  Created by 中島 知秀 on 2015/01/30.
//  Copyright (c) 2015年 Tomohide Nakahsima. All rights reserved.
//

#import "listCollectionViewController.h"
#import "gameCollectionViewCell.h"
#import "playViewController.h"
#import "pictureViewController.h"
#import "hardPlayViewController.h"
#import "headerCollectionReusableView.h"

@interface listCollectionViewController ()

@end

@implementation listCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    self.title = @"LIST";
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.normalFinalList = [userDefault arrayForKey:@"normalFinalList"];
    self.hardFinalList = [userDefault arrayForKey:@"hardFinalList"];
    
    // ナビゲーションバーに追加ボタンを設置
    self.addBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGame)];
    self.navigationItem.rightBarButtonItem = self.addBtn;

    
    // リトライした場合のリダイレクト先の判定
    if (self.playingArrayCount) {
        if (self.playingArrayCount == 10) {
            self.playingArrayCount = 0;
            [self goPlayView];
        }else if(self.playingArrayCount == 17){
            self.playingArrayCount = 0;
            [self goHardPlayView];
        }
    }
    
    
    
    
NSLog(@"%d",(int)[self.normalFinalList count]);
NSLog(@"%d",(int)[self.hardFinalList count]);
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    int count = 0;
    if(section == 0){
        count= (int)[self.normalFinalList count]; // 3*3の個数
    }
    if (section == 1) {
        count= (int)[self.hardFinalList count]; // 4*4の個数
    }
    return count;
}


// ヘッダーを作成する
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        headerCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
        
        if (indexPath.section == 0) {
            headerView.headerLabel.text = @"NORMAL (3×3)";
            headerView.backgroundColor = [UIColor colorWithRed:0.118 green:0.565 blue:1.0 alpha:1.0];
        } else {
            headerView.headerLabel.text = @"HARD (4×4)";
            headerView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
;
        }
        return headerView;
    }
    
    return nil;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    gameCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gameCell" forIndexPath:indexPath];
    
    
    NSArray *normalGameData;
    UIImage *normalGamePic;
    NSArray *hardGameData;
    UIImage *hardGamePic;
    

    if (indexPath.section == 0) {
        normalGameData = self.normalFinalList[indexPath.row];  // 3×3のゲーム配列の1つ目を取得
        normalGamePic = [UIImage imageWithData:normalGameData[0]];  // 写真のデータをdataからimageに変換
    } else if (indexPath.section == 1) {
        hardGameData = self.hardFinalList[indexPath.row];
        hardGamePic = [UIImage imageWithData:hardGameData[0]];
    }
    
    switch (indexPath.section) {
        case 0:
            cell.samplePicView.image = normalGamePic; // 3×3のセクション
            break;
            
        case 1:
            cell.samplePicView.image = hardGamePic; // 4*4のセクション
            break;
            
        default:
            break;
    }
    
    return cell;
}



// セグエする際にデータを渡す
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSArray *paths = [self.collectionView indexPathsForSelectedItems];
//    NSIndexPath * path = [paths objectAtIndex:0];
//    
//    playViewController *playView = [segue destinationViewController];
//    playView.pathNo =path.row;
//    
//    playView.divPicturesData = self.divPicDataFinal[path.row];
}


// セルがタップされたときの処理(遷移先と値渡し)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    

    playViewController *playView = [self.storyboard instantiateViewControllerWithIdentifier:@"playView"];
    hardPlayViewController *hardPlayView = [self.storyboard instantiateViewControllerWithIdentifier:@"hardPlayView"];
    
    
    if (indexPath.section == 0) {
        playView.pathNo = indexPath.row;  // 値渡し
        playView.divPicturesData = self.normalFinalList[indexPath.row];  // 値渡し
        [self.navigationController pushViewController:playView animated:YES]; // プレイ画面に遷移
    } else if (indexPath.section == 1) {
        hardPlayView.pathNo = indexPath.row;
        hardPlayView.divPicturesData = self.hardFinalList[indexPath.row];
        [self.navigationController pushViewController:hardPlayView animated:YES];
    }
    
    
}

// unwindsegueでこの画面に戻すための処理
- (IBAction)listViewReturnActionForSegue:(UIStoryboardSegue *)segue{
}

- (void)goPlayView{
    playViewController *playView = [self.storyboard instantiateViewControllerWithIdentifier:@"playView"];
    [self.navigationController pushViewController:playView animated:NO];
}

- (void)goHardPlayView{
    hardPlayViewController *hardPlayView = [self.storyboard instantiateViewControllerWithIdentifier:@"hardPlayView"];
    [self.navigationController pushViewController:hardPlayView animated:NO];
}


// addボタンが押されたらゲーム作成画面に遷移
- (void)addGame{
    pictureViewController *pictureView = [self.storyboard instantiateViewControllerWithIdentifier:@"pictureView"];
    [self.navigationController pushViewController:pictureView animated:YES];
}



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


@end
