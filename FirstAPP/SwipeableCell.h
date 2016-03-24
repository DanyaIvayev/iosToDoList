//
//  SwipeableCell.h
//  FirstAPP
//
//  Created by Admin on 17.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

// Протокол делегата для кнопок
// для передачи события нажатия на кнопку обратно к контроллеру представления для обработки этого события
@protocol SwipeableCellDelegate <NSObject>
- (void)buttonOneActionForItemText:(NSString *)itemText indexPath : (NSIndexPath *) indexPath;
- (void)buttonTwoActionForItemText:(NSString *)itemText;
- (void)buttonThreeActionForItemText : (NSString *) itemText;
@end

@interface SwipeableCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIButton *buttonDelete;
@property (nonatomic, weak) IBOutlet UIButton *buttonEdit;
@property (nonatomic, weak) IBOutlet UIButton *buttonDetail;
@property (nonatomic, weak) NSIndexPath *indexPath;
@property (nonatomic, weak) IBOutlet UIView *myContentView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbImage;
@property (nonatomic, strong) NSString *itemText;
// св-во для делегата
@property (nonatomic, weak) id <SwipeableCellDelegate> delegate;
// поле для жестов
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
//Начальная точка
@property (nonatomic, assign) CGPoint panStartPoint;
//
@property (nonatomic, assign) CGFloat startingRightLayoutConstraintConstant;
// ограничение по границам ячейки
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentViewRightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentViewLeftConstraint;

- (void)openCell;

@end
