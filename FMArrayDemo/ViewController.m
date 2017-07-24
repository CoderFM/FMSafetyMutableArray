//
//  ViewController.m
//  FMArrayDemo
//
//  Created by 周发明 on 17/7/18.
//  Copyright © 2017年 周发明. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+FM.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *arrM;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrM = [NSMutableArray array];
    [self.arrM listenDidChange:^(NSIndexSet *indexes, FMSafetyMutableArrayChangeType type) {
        if (!indexes || indexes.count == 0) {
            return;
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexes.firstIndex inSection:0];
        switch (type) {
            case FMSafetyMutableArrayChangeAddType:
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                break;
            case FMSafetyMutableArrayChangeDeleteType:
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
                break;
            default:
                break;
        }
    }];
}

- (IBAction)add:(id)sender {
    [self.arrM addObject:@"1"];
}

- (IBAction)delete:(id)sender {
    [self.arrM removeLastObject];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", indexPath.row];
    return cell;
}

@end
