//
//  ViewController.m
//  UICollection
//
//  Created by czbk on 16/8/23.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "ViewController.h"
#import "CustemCollectionViewLayout.h"

static NSString * const CellID = @"CellID";
static NSString * const HeadID = @"HeadID"; //头
static NSString * const FootID = @"FootID"; //脚



@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic) CustemCollectionViewLayout *customLayout;
@property (strong,nonatomic) UICollectionView *collectionView;

@property (strong,nonatomic) NSMutableArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //collectionView
    [self loadCollectionView];
 
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addItemBtnClick:)];
    self.navigationItem.rightBarButtonItem = addButton;
}
//添加的点击事件
-(void)addItemBtnClick: (UIBarButtonItem *)btnItem {
    //
    [self.collectionView performBatchUpdates:^{
        //创建indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.array.count inSection:0];
        
        //然后在此indexPath处插入给collectionView插入一个item
        [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
        
        //保持collectionView的item和数据源一致
        [self.array addObject:@"x"];
    } completion:nil];
    
}

//创建collectionView
-(void)loadCollectionView {
    //创建layout
    self.customLayout = [[CustemCollectionViewLayout alloc]init];
    
    //创建collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.customLayout];
    
    //背景颜色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //设置代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //添加到父控件
    [self.view addSubview:self.collectionView];
    
    //注册
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellID];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadID];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FootID];
}

//数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor purpleColor];
    
    return cell;
}

//断头段位
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    //判断是否头
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //从缓存池中加载
        UICollectionReusableView *headView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeadID forIndexPath:indexPath];
        //如果缓存池中没有,创建
        if (headView == nil) {
            headView = [[UICollectionReusableView alloc]init];
        }
        //设置背景颜色
        headView.backgroundColor = [UIColor grayColor];
        
        return  headView;
        
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        //从缓存池中加载
        UICollectionReusableView *footView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FootID forIndexPath:indexPath];
        
        //如果缓存池中没有,创建
        if (footView == nil) {
            footView = [[UICollectionReusableView alloc]init];
        }
        //设置背景颜色
        footView.backgroundColor = [UIColor lightGrayColor];
        
        return footView;
    }
    return nil;
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
}




//
//itemSize
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeMake(80, 80);
    return itemSize;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//水平,垂直间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}

//段头
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize footSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
    return footSize;
}
//断尾
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize footSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 22);
    return footSize;
}

//代理方法
-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//点击高亮
-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //获取当前点击的cell
    UICollectionViewCell * cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    //给cell设置背景颜色
    cell.backgroundColor = [UIColor greenColor];
}


//选中item
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zd",indexPath.item);
}

//长按item,弹出copy和paste的菜单
-(BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//让剪切,粘贴可用
-(BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    //判断是点击的复制,还是粘贴
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"] || [NSStringFromSelector(action) isEqualToString:@"paste:"]) {
        return YES;
    }
    return NO;
}

-(void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    //复制
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"]) {
        NSLog(@"执行复制");
        
        
        [self.collectionView performBatchUpdates:^{
            //这块是删除操作
            [self.array removeObjectAtIndex:indexPath.row];
            
            //
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        } completion:nil];
        
    }else if ([NSStringFromSelector(action) isEqualToString:@"paste:"]) {
        NSLog(@"粘贴");
    }
}


//





-(NSMutableArray *)array {
    if (_array == nil) {
        _array = [[NSMutableArray alloc]init];
        
        [_array addObject:@"1"];
        [_array addObject:@"2"];
        [_array addObject:@"3"];
        [_array addObject:@"4"];
        [_array addObject:@"5"];
    }
    return _array;
}

@end
