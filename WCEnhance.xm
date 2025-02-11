#import <UIKit/UIKit.h>

@interface WCTableViewCellLeftConfig : NSObject
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;
@end

@interface WCC2CImageScrollView : UIView

@end

%hook WCTableViewCellLeftConfig

- (NSString *)title {
	NSString *r = %orig;
	
	if (r == nil) {
		return nil;
	}
	if ([r isEqualToString:@"订单与卡包"]) {
		return @"卡包";
	}
	if ([r isEqualToString:@"支付与服务"]) {
		return @"服务";
	}
	
	return r;
}

%end

%hook UIButton

- (void)setAccessibilityLabel:(NSString *)accessibilityLabel {
	%orig;

	if ([accessibilityLabel isEqualToString:@"我的⼆维码"]) {

		self.hidden = YES;
	}
}

%end

%hook WCC2CImageScrollView

- (void)layoutSubviews {
	%orig;
	
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *version = [bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
	
if ([version compare:@"8.0.55" options:NSNumericSearch] != NSOrderedAscending) {
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCloseBtnClick:)];
		tapGesture.cancelsTouchesInView = NO;
		[self addGestureRecognizer:tapGesture];
	}
	
	NSArray *subviews = [self.subviews copy];
	for (UIView *subview in subviews) {
		if ([subview class] == [UIView class]) {
			[subview setHidden:YES];
		}
	}
}

%end
