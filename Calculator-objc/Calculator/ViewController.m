//
//  ViewController.m
//  Calculator
//
//  Created by MacBook Noob on 22/05/21.
//

#import "ViewController.h"
@import UIKit;

@interface ViewController ()

@end

UIStackView *stackView;
UIStackView *stackView1;
UIStackView *stackView2;
UIStackView *stackView3;
UIStackView *stackView4;
UIStackView *stackView5;
UILabel *calcResult;
NSString *operator;

UIButton *divButton;
UIButton *multiplyButton;
UIButton *incrementButton;
UIButton *decrementButton;

int firstNumber = 0;
int secondNumber = 0;
int totalEnteredNum = 0;

BOOL isFirstNumberEntered = NO;
BOOL isEditingMode = NO;
BOOL isOperatorSelectionMode = NO;
BOOL isFirst = NO;
BOOL isEqualSignTapped = NO;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor blackColor];
    
    calcResult = [[UILabel alloc] init];
    calcResult.backgroundColor = [UIColor darkGrayColor];
    calcResult.textAlignment = NSTextAlignmentRight;
    [calcResult setFont:[UIFont systemFontOfSize:30]];
    calcResult.text = @"0";
    calcResult.textColor = [UIColor whiteColor];
    
    [self setMainStackView];
    
    [calcResult.leadingAnchor constraintEqualToAnchor:stackView.leadingAnchor].active = YES;
    [calcResult.trailingAnchor constraintEqualToAnchor:stackView.trailingAnchor].active = YES;
    
    [stackView1.leadingAnchor constraintEqualToAnchor:stackView.leadingAnchor].active = YES;
    [stackView1.trailingAnchor constraintEqualToAnchor:stackView.trailingAnchor].active = YES;

    [stackView2.leadingAnchor constraintEqualToAnchor:stackView.leadingAnchor].active = YES;
    [stackView2.trailingAnchor constraintEqualToAnchor:stackView.trailingAnchor].active = YES;
    
    [stackView3.leadingAnchor constraintEqualToAnchor:stackView.leadingAnchor].active = YES;
    [stackView3.trailingAnchor constraintEqualToAnchor:stackView.trailingAnchor].active = YES;
    
    [stackView4.leadingAnchor constraintEqualToAnchor:stackView.leadingAnchor].active = YES;
    [stackView4.trailingAnchor constraintEqualToAnchor:stackView.trailingAnchor].active = YES;
    
    [stackView5.leadingAnchor constraintEqualToAnchor:stackView.leadingAnchor].active = YES;
    [stackView5.trailingAnchor constraintEqualToAnchor:stackView.trailingAnchor].active = YES;
}

- (void)setMainStackView {
    //Stack View
    stackView = [[UIStackView alloc] init];
    
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.alignment = UIStackViewAlignmentTop;
    stackView.spacing = 2;
    
    [self.view addSubview:stackView];
    [stackView addArrangedSubview:calcResult];
    [stackView addArrangedSubview:[self setStackView1]];
    [stackView addArrangedSubview:[self setStackView2]];
    [stackView addArrangedSubview:[self setStackView3]];
    [stackView addArrangedSubview:[self setStackView4]];
    [stackView addArrangedSubview:[self setStackView5]];
    
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    [stackView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [stackView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [stackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    
    
}

- (UIStackView *)setStackView1 {
    UIButton *ACButton = [[UIButton alloc] init];
    ACButton.backgroundColor = [UIColor systemGrayColor];
    [ACButton setTitle:@"AC" forState:UIControlStateNormal];
    ACButton.titleLabel.textColor = [UIColor whiteColor];
    ACButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [ACButton addTarget:self action:@selector(operatorButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *plusMinButton = [[UIButton alloc] init];
    plusMinButton.backgroundColor = [UIColor systemGrayColor];
    [plusMinButton setTitle:@"+/-" forState:UIControlStateNormal];
    plusMinButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [plusMinButton addTarget:self action:@selector(operatorButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *percentButton = [[UIButton alloc] init];
    percentButton.backgroundColor = [UIColor systemGrayColor];
    [percentButton setTitle:@"%" forState:UIControlStateNormal];
    percentButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [percentButton addTarget:self action:@selector(operatorButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    divButton = [[UIButton alloc] init];
    divButton.backgroundColor = [UIColor orangeColor];
    [divButton setTitle:@"/" forState:UIControlStateNormal];
    divButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [divButton addTarget:self action:@selector(operatorButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    //Stack View
    stackView1 = [[UIStackView alloc] init];
    
    stackView1.axis = UILayoutConstraintAxisHorizontal;
    stackView1.distribution = UIStackViewDistributionFillEqually;
    stackView1.alignment = UIStackViewAlignmentTop;
    stackView1.spacing = 2;
    
    [self.view addSubview:stackView1];
    [stackView1 addArrangedSubview:ACButton];
    [stackView1 addArrangedSubview:plusMinButton];
    [stackView1 addArrangedSubview:percentButton];
    [stackView1 addArrangedSubview:divButton];
    
    [ACButton.bottomAnchor constraintEqualToAnchor:stackView1.bottomAnchor].active = YES;
    [plusMinButton.bottomAnchor constraintEqualToAnchor:stackView1.bottomAnchor].active = YES;
    [percentButton.bottomAnchor constraintEqualToAnchor:stackView1.bottomAnchor].active = YES;
    [divButton.bottomAnchor constraintEqualToAnchor:stackView1.bottomAnchor].active = YES;

    return stackView1;
}

- (UIStackView *)setStackView2 {
    UIButton *numSevenButton = [[UIButton alloc] init];
    numSevenButton.backgroundColor = [UIColor systemBlueColor];
    [numSevenButton setTitle:@"7" forState:UIControlStateNormal];
    numSevenButton.titleLabel.textColor = [UIColor whiteColor];
    numSevenButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [numSevenButton addTarget:self action:@selector(numButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *numEightButton = [[UIButton alloc] init];
    numEightButton.backgroundColor = [UIColor systemBlueColor];
    [numEightButton setTitle:@"8" forState:UIControlStateNormal];
    numEightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [numEightButton addTarget:self action:@selector(numButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *numNineButton = [[UIButton alloc] init];
    numNineButton.backgroundColor = [UIColor systemBlueColor];
    [numNineButton setTitle:@"9" forState:UIControlStateNormal];
    numNineButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [numNineButton addTarget:self action:@selector(numButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    multiplyButton = [[UIButton alloc] init];
    multiplyButton.backgroundColor = [UIColor orangeColor];
    [multiplyButton setTitle:@"x" forState:UIControlStateNormal];
    multiplyButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [multiplyButton addTarget:self action:@selector(operatorButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    //Stack View
    stackView2 = [[UIStackView alloc] init];
    
    stackView2.axis = UILayoutConstraintAxisHorizontal;
    stackView2.distribution = UIStackViewDistributionFillEqually;
    stackView2.alignment = UIStackViewAlignmentTop;
    stackView2.spacing = 2;
    
    [self.view addSubview:stackView2];
    [stackView2 addArrangedSubview:numSevenButton];
    [stackView2 addArrangedSubview:numEightButton];
    [stackView2 addArrangedSubview:numNineButton];
    [stackView2 addArrangedSubview:multiplyButton];
    
    [numSevenButton.bottomAnchor constraintEqualToAnchor:stackView2.bottomAnchor].active = YES;
    [numEightButton.bottomAnchor constraintEqualToAnchor:stackView2.bottomAnchor].active = YES;
    [numNineButton.bottomAnchor constraintEqualToAnchor:stackView2.bottomAnchor].active = YES;
    [multiplyButton.bottomAnchor constraintEqualToAnchor:stackView2.bottomAnchor].active = YES;
    
    return stackView2;
}

- (UIStackView *)setStackView3 {
    UIButton *numFourButton = [[UIButton alloc] init];
    numFourButton.backgroundColor = [UIColor systemBlueColor];
    [numFourButton setTitle:@"4" forState:UIControlStateNormal];
    numFourButton.titleLabel.textColor = [UIColor whiteColor];
    numFourButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [numFourButton addTarget:self action:@selector(numButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *numFiveButton = [[UIButton alloc] init];
    numFiveButton.backgroundColor = [UIColor systemBlueColor];
    [numFiveButton setTitle:@"5" forState:UIControlStateNormal];
    numFiveButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [numFiveButton addTarget:self action:@selector(numButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *numSixButton = [[UIButton alloc] init];
    numSixButton.backgroundColor = [UIColor systemBlueColor];
    [numSixButton setTitle:@"6" forState:UIControlStateNormal];
    numSixButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [numSixButton addTarget:self action:@selector(numButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    decrementButton = [[UIButton alloc] init];
    decrementButton.backgroundColor = [UIColor orangeColor];
    [decrementButton setTitle:@"-" forState:UIControlStateNormal];
    decrementButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [decrementButton addTarget:self action:@selector(operatorButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    //Stack View
    stackView3 = [[UIStackView alloc] init];
    
    stackView3.axis = UILayoutConstraintAxisHorizontal;
    stackView3.distribution = UIStackViewDistributionFillEqually;
    stackView3.alignment = UIStackViewAlignmentTop;
    stackView3.spacing = 2;
    
    [self.view addSubview:stackView3];
    [stackView3 addArrangedSubview:numFourButton];
    [stackView3 addArrangedSubview:numFiveButton];
    [stackView3 addArrangedSubview:numSixButton];
    [stackView3 addArrangedSubview:decrementButton];
    
    [numFourButton.bottomAnchor constraintEqualToAnchor:stackView3.bottomAnchor].active = YES;
    [numFiveButton.bottomAnchor constraintEqualToAnchor:stackView3.bottomAnchor].active = YES;
    [numSixButton.bottomAnchor constraintEqualToAnchor:stackView3.bottomAnchor].active = YES;
    [decrementButton.bottomAnchor constraintEqualToAnchor:stackView3.bottomAnchor].active = YES;
    return stackView3;
}

- (UIStackView *)setStackView4 {
    UIButton *numOneButton = [[UIButton alloc] init];
    numOneButton.backgroundColor = [UIColor systemBlueColor];
    [numOneButton setTitle:@"1" forState:UIControlStateNormal];
    numOneButton.titleLabel.textColor = [UIColor whiteColor];
    numOneButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [numOneButton addTarget:self action:@selector(numButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *numTwoButton = [[UIButton alloc] init];
    numTwoButton.backgroundColor = [UIColor systemBlueColor];
    [numTwoButton setTitle:@"2" forState:UIControlStateNormal];
    numTwoButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [numTwoButton addTarget:self action:@selector(numButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *numThreeButton = [[UIButton alloc] init];
    numThreeButton.backgroundColor = [UIColor systemBlueColor];
    [numThreeButton setTitle:@"3" forState:UIControlStateNormal];
    numThreeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [numThreeButton addTarget:self action:@selector(numButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    incrementButton = [[UIButton alloc] init];
    
    incrementButton.backgroundColor = [UIColor orangeColor];
    [incrementButton setTitle:@"+" forState:UIControlStateNormal];
    incrementButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    incrementButton.showsTouchWhenHighlighted = YES;
    [incrementButton addTarget:self action:@selector(operatorButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    //Stack View
    stackView4 = [[UIStackView alloc] init];
    
    stackView4.axis = UILayoutConstraintAxisHorizontal;
    stackView4.distribution = UIStackViewDistributionFillEqually;
    stackView4.alignment = UIStackViewAlignmentTop;
    stackView4.spacing = 2;
    
    [self.view addSubview:stackView4];
    [stackView4 addArrangedSubview:numOneButton];
    [stackView4 addArrangedSubview:numTwoButton];
    [stackView4 addArrangedSubview:numThreeButton];
    [stackView4 addArrangedSubview:incrementButton];
    
    [numOneButton.bottomAnchor constraintEqualToAnchor:stackView4.bottomAnchor].active = YES;
    [numTwoButton.bottomAnchor constraintEqualToAnchor:stackView4.bottomAnchor].active = YES;
    [numThreeButton.bottomAnchor constraintEqualToAnchor:stackView4.bottomAnchor].active = YES;
    [incrementButton.bottomAnchor constraintEqualToAnchor:stackView4.bottomAnchor].active = YES;
    
    return stackView4;
}

- (UIStackView *)setStackView5 {
    UIButton *numZeroButton = [[UIButton alloc] init];
    numZeroButton.backgroundColor = [UIColor systemBlueColor];
    [numZeroButton setTitle:@"0" forState:UIControlStateNormal];
    numZeroButton.titleLabel.textColor = [UIColor whiteColor];
    numZeroButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [numZeroButton addTarget:self action:@selector(numButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIStackView *stackView5Inside = [[UIStackView alloc]init];
    
    stackView5Inside.axis = UILayoutConstraintAxisHorizontal;
    stackView5Inside.distribution = UIStackViewDistributionFillEqually;
    stackView5Inside.alignment = UIStackViewAlignmentTop;
    stackView5Inside.spacing = 2;
    
    UIButton *pointButton = [[UIButton alloc] init];
    pointButton.backgroundColor = [UIColor systemBlueColor];
    [pointButton setTitle:@"." forState:UIControlStateNormal];
    pointButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [pointButton addTarget:self action:@selector(numButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *equalSignButton = [[UIButton alloc] init];
    equalSignButton.backgroundColor = [UIColor orangeColor];
    [equalSignButton setTitle:@"=" forState:UIControlStateNormal];
    equalSignButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [equalSignButton addTarget:self action:@selector(operatorButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [stackView5Inside addArrangedSubview:pointButton];
    [stackView5Inside addArrangedSubview:equalSignButton];
    
    //Stack View
    stackView5 = [[UIStackView alloc] init];
    
    stackView5.axis = UILayoutConstraintAxisHorizontal;
    stackView5.distribution = UIStackViewDistributionFillEqually;
    stackView5.alignment = UIStackViewAlignmentTop;
    stackView5.spacing = 2;
    
    [self.view addSubview:stackView5];
    [stackView5 addArrangedSubview:numZeroButton];
    [stackView5 addArrangedSubview:stackView5Inside];
    
    [numZeroButton.bottomAnchor constraintEqualToAnchor:stackView5.bottomAnchor].active = YES;
    [stackView5Inside.bottomAnchor constraintEqualToAnchor:stackView5.bottomAnchor].active = YES;
    [pointButton.bottomAnchor constraintEqualToAnchor:stackView5Inside.bottomAnchor].active = YES;
    [equalSignButton.bottomAnchor constraintEqualToAnchor:stackView5Inside.bottomAnchor].active = YES;
    
    return stackView5;
}

- (void)operatorButtonDidTapped:(UIButton*)sender {
    isEditingMode = NO;
    int result = 0;
    isFirst = YES;
    
    
    if ([sender.currentTitle isEqual:@"AC"]) {
        firstNumber = 0;
        secondNumber = 0;
        isFirst = NO;
        calcResult.text = [NSString stringWithFormat:@"0"];
        return;
    }
    

    if(!isFirst) firstNumber = 0;
    
    if ([sender.currentTitle isEqual: @"="]) {
        if ([operator isEqual: @"+"]) {
            result = firstNumber + secondNumber;
            calcResult.text = [NSString stringWithFormat:@"%i",result];
            firstNumber = result;
        } else if ([operator isEqual: @"-"]) {
            result = firstNumber - secondNumber;
            calcResult.text = [NSString stringWithFormat:@"%i",result];
            firstNumber = result;
        } else if ([operator isEqual: @"/"]) {
            result = firstNumber / secondNumber;
            calcResult.text = [NSString stringWithFormat:@"%i",result];
            firstNumber = result;
        } else if ([operator isEqual: @"x"]) {
            result = firstNumber * secondNumber;
            calcResult.text = [NSString stringWithFormat:@"%i",result];
            firstNumber = result;
        }
        operator = nil;
        return;
    }
    
    if(!isOperatorSelectionMode) {
        if ([operator isEqual: @"+"]) {
            result = firstNumber + secondNumber;
            calcResult.text = [NSString stringWithFormat:@"%i",result];
            firstNumber = result;
        } else if ([operator isEqual: @"-"]) {
            result = firstNumber - secondNumber;
            calcResult.text = [NSString stringWithFormat:@"%i",result];
            firstNumber = result;
        } else if ([operator isEqual: @"/"]) {
            result = firstNumber / secondNumber;
            calcResult.text = [NSString stringWithFormat:@"%i",result];
            firstNumber = result;
        } else if ([operator isEqual: @"x"]) {
            result = firstNumber * secondNumber;
            calcResult.text = [NSString stringWithFormat:@"%i",result];
            firstNumber = result;
        }
    }
    
    isOperatorSelectionMode = YES;
    
    if (isOperatorSelectionMode) {
        operator = sender.currentTitle;
        
    }
    
    NSLog(@"Number First = %i", firstNumber);
    NSLog(@"Number Second = %i", secondNumber);
    NSLog(@"Number Result = %i", result);
    NSLog(@"Number Operator = %@", operator);


}

- (void)numButtonDidTapped:(UIButton*)sender {
    
    isOperatorSelectionMode = NO;
    
    if (!isEditingMode) {
        calcResult.text = [NSString stringWithFormat:@"%@",sender.currentTitle];
        if (!isFirst) {
            firstNumber = [calcResult.text intValue];
        } else {
            secondNumber = [calcResult.text intValue];
        }
        isEditingMode = YES;
    } else {
        NSMutableString *enteredNumber = [NSMutableString stringWithString:calcResult.text];
        [enteredNumber appendString:sender.currentTitle];
        calcResult.text = enteredNumber;
        if (!isFirst) {
            firstNumber = [calcResult.text intValue];
        } else {
            secondNumber = [enteredNumber intValue];
        }
        
    }
    
    isFirst = YES;

    NSLog(@"Number First = %i", firstNumber);
    NSLog(@"Number Second = %i", secondNumber);
    NSLog(@"Number Operator = %@", operator);
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
}



@end
