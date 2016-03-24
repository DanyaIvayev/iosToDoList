//
//  SwipeableCell.m
//  FirstAPP
//
//  Created by Admin on 17.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "SwipeableCell.h"
#import "MasterViewController.h"
//для жестов расширяем
@interface SwipeableCell() <UIGestureRecognizerDelegate>
@end

@implementation SwipeableCell
static CGFloat const kBounceValue = 20.0f;

- (void)awakeFromNib {
    // для жестов устанавливаем саму ячейку для разрешения движения
    // в качестве обрабтчика служит метод panThisCell
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panThisCell:)];
    // в качестве делеагата устанавливаем саму ячейку
    self.panRecognizer.delegate = self;
    // верхнему слою добавляем распознавание жестов
    [self.myContentView addGestureRecognizer:self.panRecognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
 Тип (IBAction), это аналогично (void), но при этом мы сообщаем Interface Builder, что этот метод будет вызван из интерфейса.
 
 Данный метод - слушатель нажатия кнопок
 Он присоединен с помощью аутлетов в сторибоард - Touch up inside
 
 Вызовет выполнение подходящего делегата в зависимости от кнопки
 */
- (IBAction)buttonClicked:(id)sender {
    if (sender == self.buttonDelete) {
        [self.delegate buttonOneActionForItemText:self.itemText indexPath:self.indexPath];
    } else if (sender == self.buttonEdit) {
        [self.delegate buttonTwoActionForItemText:self.itemText];
    } else if(sender ==self.buttonDetail){
        [self.delegate buttonThreeActionForItemText:self.itemText];
        
    } else {
        NSLog(@"Clicked unknown button!");
    }
    
}

// закрывает ячейку
-(void)resetConstraintContstantsToZero:(BOOL)animated notifyDelegateDidClose:(BOOL)notifyDelegate
{
    if (notifyDelegate) {
        [((MasterViewController *)self.delegate) cellDidClose:self];
    }
    
    if (self.startingRightLayoutConstraintConstant == 0 &&
        self.contentViewRightConstraint.constant == 0) {
        //Already all the way closed, no bounce necessary
        return;
    }
    
    self.contentViewRightConstraint.constant = -kBounceValue;
    self.contentViewLeftConstraint.constant = kBounceValue;
    
    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
        self.contentViewRightConstraint.constant = 0;
        self.contentViewLeftConstraint.constant = 0;
        
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
        }];
    }];
}



// открывает полностью всю ячейку
- (void)setConstraintsToShowAllButtons:(BOOL)animated notifyDelegateDidOpen:(BOOL)notifyDelegate
{//1 если ячейка открыта так, что видны кнопки
    
    if (notifyDelegate) {
        [(MasterViewController *)self.delegate cellDidOpen:self];
    }
    
    if (self.startingRightLayoutConstraintConstant == [self buttonTotalWidth] &&
        self.contentViewRightConstraint.constant == [self buttonTotalWidth]) {
        return;
    }
    //2 иначе ячейка будет отскакивать.
    // изначально были поставлены границы по общей ширине двух кнопок, и значение дребезга из-за которого может произойти мгновенный сброс
    self.contentViewLeftConstraint.constant = -[self buttonTotalWidth] - kBounceValue;
    self.contentViewRightConstraint.constant = [self buttonTotalWidth] + kBounceValue;
    
    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
        //3 после предудущей анимации запускается установка
        // вьюшки прямиком на границу кнопок
        self.contentViewLeftConstraint.constant = -[self buttonTotalWidth];
        self.contentViewRightConstraint.constant = [self buttonTotalWidth];
        
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
            //4 сбрасываем начальное ограничение в текущюю правую границу
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
        }];
    }];
}


- (void)panThisCell:(UIPanGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            /*перевод жеста в систему координат указанного представления
             Сохранение начальной точки*/
            self.panStartPoint = [recognizer translationInView:self.myContentView];
            /*Сохраняем начальную координату правой границы */
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
        }
            break;
        case UIGestureRecognizerStateChanged: {
            /* текущая точка*/
            CGPoint currentPoint = [recognizer translationInView:self.myContentView];
            
            CGFloat deltaX = currentPoint.x - self.panStartPoint.x;
            
            BOOL panningLeft = NO;
            // узнаем в какую сторону движемся
            if (currentPoint.x < self.panStartPoint.x) {  //1
                panningLeft = YES;
            }
            
            if (self.startingRightLayoutConstraintConstant == 0) { //2
                //The cell was closed and is now opening
                /* если ограничение равно 0
                 это означает что верхний слой полностью над нижним
                 */
                if (!panningLeft) {
                    /* свайп слева направо
                     обрабатываем случай когда сначала пользователь приоткрывает нижний слой и возвращает назад. 
                     Поэтому берется максимум от дельта х и 0
                     т.е. верхний слой не может пойти вправо дальше границы                     */
                    CGFloat constant = MAX(-deltaX, 0); //3
                    
                    if (constant == 0) { //4
                        //если константа равна нулю - ячейка полностью закрыта. Запускается метод который обрабатывает закрытие
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO];
                    } else { //5
                        // иначе, устанавливаем ее в правое ограничение
                        self.contentViewRightConstraint.constant = constant;
                    }
                } else {
                    /*
                     свайп справа налево
                     здесь обработка аналогична только в левую сторону, вместо нуля ставится величина ширины двух кнопок
                     */
                    CGFloat constant = MIN(-deltaX, [self buttonTotalWidth]); //6
                    if (constant == [self buttonTotalWidth]) { //7
                        /*
                         Если равно ширине, то ячейка открывается до пересечения - открываем ячейку
                         */
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:NO];
                    } else { //8
                        // иначе устанавливаем в правое ограничение
                        self.contentViewRightConstraint.constant = constant;
                    }
                }
            }
            else {
                //The cell was at least partially open.
                // Ячейка открыта хотя бы частично
                // вычитаем дельта Х из правой границы, чтобы понять на сколько было смещено
                CGFloat adjustment = self.startingRightLayoutConstraintConstant - deltaX; //1
                if (!panningLeft) {
                    // свайп слева направо
                    // принимаем максимум из смещения и 0, если смещение отрицательно,
                    // то мы вышли за край и ячейка закрывается
                    CGFloat constant = MAX(adjustment, 0); //2
                    
                    if (constant == 0) { //3 закрываем
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO];
                    } else { //4 иначе ставим как правую границу
                        self.contentViewRightConstraint.constant = constant;
                    }
                } else {
                    CGFloat constant = MIN(adjustment, [self buttonTotalWidth]); //5 минимум м/у смещением и шириной двух кнопок
                        // если смещение больше, то пользователь свайпнул
                    // слишком много и прошел точку пересечения
                    if (constant == [self buttonTotalWidth]) { //6
                        // если равно - ячейка открывается
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:NO];
                    } else { //7
                        // иначе в правую границу
                        self.contentViewRightConstraint.constant = constant;
                    }
                }
            }
            //устанавливаем левую границу
            self.contentViewLeftConstraint.constant = -self.contentViewRightConstraint.constant; //8
        }
            break;
        case UIGestureRecognizerStateEnded:
            if (self.startingRightLayoutConstraintConstant == 0) { //1
                //Cell was opening ячейка была закрыта и открывалась
                CGFloat halfOfButtonOne = CGRectGetWidth(self.buttonDelete.frame)+ (CGRectGetWidth(self.buttonEdit.frame) / 2); //2
                if (self.contentViewRightConstraint.constant >= halfOfButtonOne) { //3
                    //Открыть целиком
                    [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                } else {
                    //Вернуть в закрытое состояние
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                }
            } else {
                //Ячейка закрывалась
                CGFloat buttonOnePlusHalfOfButton2 = CGRectGetWidth(self.buttonDelete.frame) + (CGRectGetWidth(self.buttonEdit.frame) / 2); //4
                if (self.contentViewRightConstraint.constant >= buttonOnePlusHalfOfButton2) { //5
                    //вернуть в открытое
                    [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                } else {
                    //Закрыть
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                }
            }
            break;
        case UIGestureRecognizerStateCancelled:
            if (self.startingRightLayoutConstraintConstant == 0) {
                //Cell was closed - reset everything to 0
                [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
            } else {
                //Cell was open - reset to the open state
                [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
            }
            break;
        default:
            break;
    }
}

- (void)updateConstraintsIfNeeded:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    float duration = 0;
    if (animated) {
        duration = 0.1;
    }
    // указываем длительность анимации  duration
    // во время анимации выполняет изменения у слоя и всех его подвьюшек
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];
    } completion:completion];
}

/* получаем полную ширину трех кнопок вычитая из всей ширины
 ячейки левую кооринату Х от третьей кнопки*/
-(CGFloat) buttonTotalWidth{
    return CGRectGetWidth(self.frame)-CGRectGetMinX(self.buttonDetail.frame);
}

// разрешаем другие жесты
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self resetConstraintContstantsToZero:NO notifyDelegateDidClose:NO];
}

- (void)openCell {
    [self setConstraintsToShowAllButtons:NO notifyDelegateDidOpen:NO];
}


@end
