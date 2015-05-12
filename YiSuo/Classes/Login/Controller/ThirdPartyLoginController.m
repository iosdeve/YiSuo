//
//  ThirdPartyLoginController.m
//  YiSuo
//
//  Created by 陈欣 on 15/4/27.
//  Copyright (c) 2015年 陈欣. All rights reserved.
//

#import "ThirdPartyLoginController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "HttpTool.h"
#import "UIBarButtonItem+Custom.h"
#import "OAuthInfo.h"
#import "UserToken.h"
#import "CustomTabBarController.h"
#import "MJExtension.h"
#import "CommonUtil.h"

/*******************新浪第三方*******************/
//成功授权后的回调地址
#define OAuthSinaRedirectURL @"http://m.baidu.com"
//Oauth登陆URL，用来获取access token
#define OAuthSinaURL @"https://api.weibo.com/oauth2/authorize"
#define OAuthSinaAppKey @"3972601632"
#define OAuthSinaAppSecret @"9e6df9d7c5314776204e90d9d7715289"
//获取accessToken URL
#define OAuthSinaAccessTokenURL @"https://api.weibo.com/oauth2/access_token"
//获取用户信息
#define OAuthSinaShowUserInfoURL @"https://api.weibo.com/2/users/show.json"

/*******************QQ第三方*******************/
//Oauth登陆URL，用来获取access token
#define OAuthQQURL @"https://graph.qq.com/oauth2.0/authorize"
#define OAuthQQAppID @"101105395"
#define OAuthQQAppKey @"48906f83a4209543f69c1157c70da29c"
//获取accessToken URL
#define OAuthQQAccessTokenURL @"https://graph.qq.com/oauth2.0/token"
//获取OpenId
#define OauthQQOpenIdURL @"https://graph.qq.com/oauth2.0/me"
//获取用户信息
#define OAuthQQGetUserInfoURL @"https://openmobile.qq.com/user/get_simple_userinfo"
//回调 URL地址
#define OAuthQQRedirectURL @"http://luji.sinaapp.com/index.html"

@interface ThirdPartyLoginController ()<UIWebViewDelegate>

@property(nonatomic, copy) NSString *url;
@property(nonatomic, strong) MBProgressHUD *hud;
@end

@implementation ThirdPartyLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置webView
    [self setupWebView];
}

/**
 *  设置webView
 */
-(void) setupWebView{
    //构造对应第三方账号登录的OAuth授权地址
    if(self.loginType==LoginTypeSina){
        self.title=@"新浪登录";
        self.url=[NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",OAuthSinaURL,OAuthSinaAppKey,OAuthSinaRedirectURL];
    }else if(self.loginType==LoginTypeQQ){
        self.title=@"QQ登录";
        NSString *redirctURL=[OAuthQQRedirectURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.url=[NSString stringWithFormat:@"%@?response_type=code&client_id=%@&redirect_uri=%@&state=%@&display=mobile",OAuthQQURL,OAuthQQAppID,redirctURL,@"test"];
        MyLog(@"%@",self.url);
    }else if(self.loginType==LoginTypeWexin){
        self.title=@"微信登录";
    }
    
    UIWebView *webView=[[UIWebView alloc] init];
    webView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    webView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    webView.delegate=self;
    [self.view addSubview:webView];
}

/**
 *  开始请求URL调用
 */
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view];
    MBProgressHUD *hud=[MBProgressHUD showMessage:@"加载中..." toView:self.view];
    hud.color=[UIColor lightGrayColor];
    hud.dimBackground=NO;
}
/**
 *  结束请求URL调用
 */
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  是否向服务器发送请求
 *
 *  @param webView
 *  @param request        request的url
 *  @param navigationType
 *
 *  @return 如果返回NO，则不发送请求
 */
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //获取请求URL地址
    NSString *url=request.URL.absoluteString;
    //截取accessToken
    NSRange range=[url rangeOfString:@"?code="];
    NSString *accessCode=nil;
    if (range.location!=NSNotFound) {
        accessCode=[url substringFromIndex:range.location+range.length];
        NSRange range2=[accessCode rangeOfString:@"&"];
        if (range2.location!=NSNotFound) {
            accessCode=[accessCode substringToIndex:range2.location];
        }
        MyLog(@"code%@",url);
        MyLog(@"code:%@",accessCode);
        if (self.loginType==LoginTypeSina) {
            [self sinaWeiBoLogin:accessCode];
        }else if (self.loginType==LoginTypeQQ){
            [self qqLogin:accessCode];
        }
        return NO;
    }
    return YES;
}

/**
 *  新浪微博登录
 *
 *  @param accessToken 第三方token
 */
-(void) sinaWeiBoLogin:(NSString *) accessCode{
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"client_id"]=OAuthSinaAppKey;
    parameters[@"client_secret"]=OAuthSinaAppSecret;
    parameters[@"grant_type"]=@"authorization_code";
    parameters[@"code"]=accessCode;
    parameters[@"redirect_uri"]=OAuthSinaRedirectURL;
    //发送Post请求
    [HttpTool postURL:OAuthSinaAccessTokenURL parameter:parameters success:^(id responseObject) {
        MyLog(@"accessToken:%@",responseObject);
        NSString *accessToken=responseObject[@"access_token"];
        NSString *openId=responseObject[@"uid"];
        [HttpTool getURL:OAuthSinaShowUserInfoURL parameter:@{@"access_token":accessToken,@"uid":openId} success:^(id responseObject) {
            MyLog(@"userinfo:%@",responseObject);
            NSString *nickname=responseObject[@"screen_name"];
            NSString *img=responseObject[@"profile_image_url"];
            [HttpTool postURL:RegistUserInfoForThirdpartLogin parameter:@{@"type":@2,@"openid":openId,@"nickname":nickname,@"img":img} success:^(id responseObject) {
                MyLog(@"addResult:%@",responseObject);
                NSString *result=responseObject[@"result"];
                if ([@"1" isEqualToString:result]) {
                    
                }else{
                    //[MBProgressHUD showError:@"登录失败"];
                }
                NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
                parameters[@"client_id"]=@"mobile_yisuo";
                parameters[@"client_secret"]=@"secret_yisuo";
                parameters[@"grant_type"]=@"password";
                parameters[@"username"]=[NSString stringWithFormat:@"WEIBO-%@",openId];
                parameters[@"password"]=@"12345678";
                [HttpTool postURL:Login_UserToken parameter:parameters success:^(id responseObject) {
                    MyLog(@"loginResult:%@",responseObject);
                    UserToken *userToken=[UserToken objectWithKeyValues:responseObject];
                    [CommonUtil saveUserToken:userToken];
                    CustomTabBarController *tabBarVC=[[CustomTabBarController alloc] init];
                    self.view.window.rootViewController=tabBarVC;
                } faile:^(NSError *error) {
                    [MBProgressHUD showError:@"登录失败"];
                }];
                
            } faile:^(NSError *error) {
                [MBProgressHUD showError:@"登录失败"];
            }];
        } faile:^(NSError *error) {
            [MBProgressHUD showError:@"登录失败"];
        }];
        
    } faile:^(NSError *error) {
        [MBProgressHUD showError:@"登录失败"];
    }];
}


/**
 *  QQ登录
 *
 *  @param accessToken 第三方token
 */
-(void) qqLogin:(NSString *) accessCode{
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"client_id"]=OAuthQQAppID;
    parameters[@"client_secret"]=OAuthQQAppKey;
    parameters[@"grant_type"]=@"authorization_code";
    parameters[@"code"]=accessCode;
    parameters[@"redirect_uri"]=OAuthQQRedirectURL;
    //发送Post请求
    [HttpTool getURL:OAuthQQAccessTokenURL parameter:parameters successWithUnkowSerializer:^(id responseObject) {
        MyLog(@"accessToken:%@",responseObject);
        NSString *responseStr=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSArray *kVArray=[responseStr componentsSeparatedByString:@"&"];
        NSString *accessToken=nil;
        NSString *expires=nil;
        NSString *refreshToken=nil;
        for (NSString *kv in kVArray) {
            NSRange range1=[kv rangeOfString:@"access_token="];
            NSRange range2=[kv rangeOfString:@"expires_in="];
            NSRange range3=[kv rangeOfString:@"refresh_token="];
            if (range1.location !=NSNotFound) {
                accessToken=[kv substringFromIndex:range1.location+range1.length];
                MyLog(@"key=%@;value=%@",kv,accessToken);
            }else if (range2.location !=NSNotFound){
                expires=[kv substringFromIndex:range2.location+range2.length];
                MyLog(@"key=%@;value=%@",kv,expires);
            }else if (range3.location !=NSNotFound){
                refreshToken=[kv substringFromIndex:range3.location+range3.length];
                MyLog(@"key=%@;value=%@",kv,refreshToken);
            }
        }
        [HttpTool getURL:OauthQQOpenIdURL parameter:@{@"access_token":accessToken} successWithUnkowSerializer:^(id responseObject) {
            NSString *openId=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSRange beginRange=[openId rangeOfString:@"("];
            NSRange endRange=[openId rangeOfString:@")"];
            NSString *temp=[openId substringWithRange:NSMakeRange(beginRange.location+1, (endRange.location-beginRange.location)-1)];
            MyLog(@"%@",temp);
            NSDictionary *openIdJson=[NSJSONSerialization JSONObjectWithData:[temp dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            MyLog(@"%@",openIdJson[@"openid"]);
            openId=openIdJson[@"openid"];
            [HttpTool getURL:OAuthQQGetUserInfoURL parameter:@{
                                                               @"access_token":accessToken,
                                                               @"oauth_consumer_key":OAuthQQAppID,
                                                               @"openid":openId
                                                               }
            successWithUnkowSerializer:^(id responseObject) {
                NSString *userInfo=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                MyLog(@"userInfo%@",userInfo);
                NSString *nickname=dict[@"nickname"];
                NSString *img=dict[@"figureurl"];
                MyLog(@"img:%@",img);
                MyLog(@"openid:%@",openId);
                [HttpTool postURL:RegistUserInfoForThirdpartLogin parameter:@{@"type":@3,@"openid":openId,@"nickname":nickname,@"img":img} success:^(id responseObject) {
                    NSString *result=responseObject[@"result"];
                    if ([@"1" isEqualToString:result]) {
                        NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
                        parameters[@"client_id"]=@"mobile_yisuo";
                        parameters[@"client_secret"]=@"secret_yisuo";
                        parameters[@"grant_type"]=@"password";
                        parameters[@"username"]=[NSString stringWithFormat:@"QQ-%@",openId];
                        parameters[@"password"]=@"12345678";
                        [HttpTool postURL:Login_UserToken parameter:parameters success:^(id responseObject) {
                            MyLog(@"loginResult:%@",responseObject);
                            UserToken *userToken=[UserToken objectWithKeyValues:responseObject];
                            [CommonUtil saveUserToken:userToken];
                            CustomTabBarController *tabBarVC=[[CustomTabBarController alloc] init];
                            self.view.window.rootViewController=tabBarVC;
                        } faile:^(NSError *error) {
                            [MBProgressHUD showError:@"登录失败"];
                        }];

                    }
                
                } faile:^(NSError *error) {
                    MyLog(@"addUserError%@",error);
                }];
                
            } faile:^(NSError *error) {
                MyLog(@"userInfo Error:%@",error);
            }];
            
        } faile:^(NSError *error) {
            MyLog(@"openId--Error:%@",error);
        }];
        
    } faile:^(NSError *error) {
        MyLog(@"accessTokenError:%@",error);
        [MBProgressHUD showError:@"登录失败"];
    }];
}


@end
