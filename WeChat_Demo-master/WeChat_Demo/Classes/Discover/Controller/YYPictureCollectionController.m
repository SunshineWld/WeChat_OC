

#import "YYPictureCollectionController.h"
#import "YYPictureCell.h"
#import "YYPictureModel.h"
#import "YYEditPicTableController.h"
#import "YYBaseNavController.h"

@interface YYPictureCollectionController ()<YYPictureCellDelegate>

@property (strong, nonatomic) NSMutableArray<UIButton *> *selectedBtn;

@property (strong, nonatomic) NSArray *dataArray;

@property (weak, nonatomic) UIView *footerView;

@property (weak, nonatomic) UIButton *doneBtn;

@property (weak, nonatomic) UIButton *previewBtn;

@property (strong, nonatomic) NSMutableArray<YYPictureModel *> *selImageArray;

@end

@implementation YYPictureCollectionController

static NSString * const reuseIdentifier = @"Cell";

- (NSMutableArray<YYPictureModel *> *)selImageArray{

    if (!_selImageArray) {
        
        _selImageArray = [NSMutableArray array];
    }
    return _selImageArray;
}


- (NSArray *)dataArray{

    if (!_dataArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PictureCell" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            YYPictureModel *model = [YYPictureModel pictureWithDict:dict];
            
            [tempArray addObject:model];
        }
        _dataArray = tempArray;
    }
    return _dataArray;

}

- (NSMutableArray<UIButton *> *)selectedBtn{

    if (!_selectedBtn) {
        
        _selectedBtn = [NSMutableArray array];
    }
    
    return _selectedBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backItem)];

    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"YYPictureCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(canclePicture)];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *doneBtn = [[UIButton alloc]init];
    doneBtn.enabled = NO;
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [doneBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    doneBtn.frame = CGRectMake(kScreenWidth - 60, 0, 60, 44);
    [doneBtn addTarget:self action:@selector(clickDoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.doneBtn = doneBtn;
    
    UIButton *previewBtn = [[UIButton alloc]init];
    previewBtn.enabled = NO;
    [previewBtn setTitle:@"预览" forState:UIControlStateNormal];
    [previewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [previewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    previewBtn.frame = CGRectMake(0, 0, 60, 44);
    [previewBtn addTarget:self action:@selector(clickPreviewBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.previewBtn = previewBtn;
    
    [footerView addSubview:doneBtn];
    [footerView addSubview:previewBtn];
    
    self.footerView = footerView;
    
    [self.navigationController.view addSubview:footerView];
}

- (void)clickPreviewBtn:(UIButton *)sender{
    NSLog(@"clickPreviewBtn");
}

- (void)clickDoneBtn:(UIButton *)sender{
    
    YYEditPicTableController *editPicVc = [[YYEditPicTableController alloc]init];
    YYBaseNavController *navEditVc = [[YYBaseNavController alloc]initWithRootViewController:editPicVc];
    
    editPicVc.imageArray = self.selImageArray;
    
    [self presentViewController:navEditVc animated:YES completion:nil];
}


#pragma mark - 监听返回按钮
- (void)backItem{

    [self.footerView removeFromSuperview];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)canclePicture{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YYPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    cell.model = self.dataArray[indexPath.row];
    
    
    return cell;
}

#pragma mark - YYPictureCell 代理方法实现
- (void)pictureCell:(YYPictureCell *)cell withDidClickBtn:(UIButton *)btn{
    
    if ((self.selectedBtn.count == 9) && (!btn.isSelected)) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"最多选取9张照片哦,亲!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
        return;
    }
    
    btn.selected = !btn.isSelected;
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    YYPictureModel *model = self.dataArray[indexPath.row];
    
    if (btn.isSelected) {
        
        model.clickedBtn = YES;
        
        [self.selectedBtn addObject:btn];
        [self.selImageArray addObject:model];
        
    } else{
        
        model.clickedBtn = NO;
        [self.selectedBtn removeObject:btn];
        [self.selImageArray removeObject:model];
    }
    
    if (self.selectedBtn.count > 0) {
        
        self.doneBtn.enabled = YES;
        self.doneBtn.selected = YES;
        self.previewBtn.enabled = YES;
        self.previewBtn.selected = YES;
    }else {
    
        self.doneBtn.enabled = NO;
        self.doneBtn.selected = NO;
        self.previewBtn.enabled = NO;
        self.previewBtn.selected = NO;
    }

    
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"collectionView");

    
    
}




@end
