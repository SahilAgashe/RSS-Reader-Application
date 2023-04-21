//
//  RssItemTableViewCell.h
//  RSS-Reader
//
//  Created by Sahil Agashe on 07/03/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RssItemTableViewCell : UITableViewCell
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *descriptionLabel;
@property (nonatomic) UIImageView * itemImageView;
@end

NS_ASSUME_NONNULL_END
