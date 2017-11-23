//
// Copyright (c) 2017, weidian.com
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// * Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "ViewController.h"
#import <Hera/WDHodoer.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation ViewController

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Hera";
	
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self.view addGestureRecognizer:ges];
	
	self.indicatorView.alpha = 0;
}

- (void)didTap {
	
	WDHAppInfo *appInfo = [[WDHAppInfo alloc] init];
	//小程序标识
	appInfo.appId = @"demoapp";
	
	//标识宿主app业务用户id
	appInfo.userId = @"userId";
	
	//小程序资源zip路径,如果为空或未找到资源 则读取MainBundle下以appId命名的资源包(appId.zip)
	appInfo.appPath = @"";
	
	[self.indicatorView startAnimating];
	[UIView animateWithDuration:0.25 animations:^{
		self.indicatorView.alpha = 1.0;
	}];
	
	self.view.userInteractionEnabled = NO;
	[[WDHInterface sharedInterface] startAppWithAppInfo:appInfo entrance:self.navigationController completion:^(BOOL success, NSString *msg) {
		
		NSLog(@"%@", msg);
		
		[UIView animateWithDuration:0.5 animations:^{
			self.indicatorView.alpha = 0.0;
		} completion:^(BOOL finished) {
			[self.indicatorView stopAnimating];
			self.view.userInteractionEnabled = YES;
		}];
	}];

}

@end
