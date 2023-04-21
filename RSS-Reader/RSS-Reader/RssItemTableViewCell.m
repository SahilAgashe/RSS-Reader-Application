//
//  RssItemTableViewCell.m
//  RSS-Reader
//
//  Created by Sahil Agashe on 07/03/23.
//

#import "RssItemTableViewCell.h"

@implementation RssItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor blackColor];
        [_titleLabel setFont:[UIFont systemFontOfSize:18]];        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_titleLabel];
        
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_descriptionLabel setNumberOfLines:3];
        [_descriptionLabel setFont:[UIFont systemFontOfSize:15]];
        _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_descriptionLabel];
        
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _itemImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_itemImageView];
        
        [self addConstraints];
    }
    return self;
}

-(void)addConstraints {
    [NSLayoutConstraint activateConstraints:@[
        
        [self.itemImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10],
        [self.itemImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10],
        [self.itemImageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-10],
        [self.itemImageView.widthAnchor constraintEqualToConstant:40],
        
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.itemImageView.trailingAnchor constant:30],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.descriptionLabel.topAnchor constant:-1],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10],
        
        [self.descriptionLabel.leadingAnchor constraintEqualToAnchor:self.itemImageView.trailingAnchor constant:30],
        [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:1],
        [self.descriptionLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
        [self.descriptionLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10]
    ]];
}

@end
