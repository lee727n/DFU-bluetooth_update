//
//  AppDelegate.m
//  AutomaticModel
//
//  Created by 刘梓轩 on 2018/11/27.
//  Copyright © 2018年 刘梓轩. All rights reserved.
//


#import "TopCell.h"

@implementation TopCell


- (UIImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconIV];
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(80, 60));
            make.centerY.equalTo(0);
            make.left.equalTo(10);
        }];
        //图片比例是4:3, 但是为了防止出现比例非4:3的图.
        _iconIV.contentMode = UIViewContentModeScaleAspectFill;
        //不允许图片超出显示范围
  
        _iconIV.clipsToBounds = YES;
        _iconIV.layer.cornerRadius = 3;
    }
    return _iconIV;
}

- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconIV.mas_right).offset(10);
            make.right.equalTo(-10);
            make.top.equalTo(self.iconIV).offset(-2);
        }];
        _titleLb.font = [UIFont systemFontOfSize:15];
    }
    return _titleLb;
}

- (UILabel *)detailLb {
    if(_detailLb == nil) {
        _detailLb = [[UILabel alloc] init];
        [self.contentView addSubview:_detailLb];
        [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLb);
            make.centerY.equalTo(0);
        }];
        _detailLb.numberOfLines = 2; //两行
        _detailLb.font = [UIFont systemFontOfSize:12];
        _detailLb.textColor = [UIColor grayColor];
       // self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _detailLb;
}

- (UILabel *)replyLb {
    if(_replyLb == nil) {
        _replyLb = [[UILabel alloc] init];
        [self.contentView addSubview:_replyLb];
        [_replyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLb);
            make.bottom.equalTo(self.iconIV);
        }];
        _replyLb.font = [UIFont systemFontOfSize:12];
        _replyLb.textColor = [UIColor lightGrayColor];
    }
    return _replyLb;
}

- (UILabel *)dateLb {
    if(_dateLb == nil) {
        _dateLb = [[UILabel alloc] init];
        [self.contentView addSubview:_dateLb];
        [_dateLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.titleLb);
            make.bottom.equalTo(self.iconIV);
        }];
        _dateLb.font = [UIFont systemFontOfSize:12];
        _dateLb.textColor = [UIColor lightGrayColor];
    }
    return _dateLb;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
