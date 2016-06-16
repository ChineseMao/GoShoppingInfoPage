//
//  ViewController.m
//  goShoppingInfoPage
//
//  Created by 毛韶谦 on 16/6/15.
//  Copyright © 2016年 毛韶谦. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

#define kWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *headScrollView; //图片  左右
//@property (nonatomic, strong) UIScrollView *firstScrollView; //上下；
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation ViewController

#pragma mark ------懒加载----------

- (UIScrollView *)headScrollView {
    
    if (!_headScrollView) {
        _headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kWidth/2+64)];
    }
    return _headScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.headScrollView.pagingEnabled = YES;
    self.headScrollView.bounces = NO;
    self.headScrollView.contentSize = CGSizeMake(kWidth*3, kWidth/2);
    
    for (int i = 0; i < self.headScrollView.contentSize.width/kWidth; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth*i, 64, kWidth, kWidth/2)];
        imageView.image = [UIImage imageNamed:@"1.jpeg"];
        [self.headScrollView addSubview:imageView];
    }
    self.myTableView = [[UITableView alloc]  initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.myTableView];
    self.myTableView.tableHeaderView = self.headScrollView;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.textLabel.text = @"333333333333";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.myTableView && scrollView.contentOffset.y > 0) {
        
        CGPoint point = scrollView.contentOffset;
        point.y = - point.y/1.5;
        NSLog(@"====%f",point.y);
        self.headScrollView.contentOffset = point;
    }
    if (scrollView == self.myTableView && scrollView.contentOffset.y < 0 && scrollView.contentOffset.y > -128) {
        
        CGPoint point = scrollView.contentOffset;
        NSLog(@"+++++%f",point.y);
        point.y = - point.y/2;
        NSLog(@"====%f",point.y);
        self.headScrollView.contentOffset = point;
    }
    if (scrollView == self.myTableView && scrollView.contentOffset.y < -128) {
        
        CGPoint point = scrollView.contentOffset;
        NSLog(@"+++++%f",point.y);
        point.y = 64;
        NSLog(@"====%f",point.y);
        self.headScrollView.contentOffset = point;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
