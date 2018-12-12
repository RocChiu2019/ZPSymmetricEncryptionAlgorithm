//
//  ViewController.m
//  对称加密算法
//
//  Created by 赵鹏 on 2018/12/11.
//  Copyright © 2018 赵鹏. All rights reserved.
//

/**
 对称加密：明文通过密钥加密得到密文，密文通过密钥解密得到明文。
 
 对称加密主要分为如下的三种加密算法：
 1、DES：数据加密标准（用得少，因为强度不够）；
 2、3DES：使用3个不同的密钥，对相同的数据执行3次加密（因为密钥的个数过多，不容易管理而逐渐被摒弃）；
 3、AES：高级密码标准（用的最多的对称加密方式）。
 
 对称加密分为如下的两种应用模式：
 1、ECB(Electronic Code Book)：电子密码本模式；
 每一块数据都是独立加密的；
 最基本的加密模式，也就是通常理解的加密，相同的明文将永远加密成相同的密文，无初始向量，容易受到密码本重放攻击，一般情况下很少用。
 2、CBC(Cipher Block Chaining)：密码分组链接模式；
 这种加密模式会把需要加密的数据分块，后一块的加密是依赖于前一块的；
 使用一个密钥和一个初始化向量[IV]对数据执行加密；
 明文被加密前要与前面的密文进行异或运算后再加密，因此只要选择不同的初始向量，相同的密文加密后会形成不同的密文，这是目前应用
 最广泛的模式。CBC加密后的密文是上下文相关的，但明文的错误不会传递到后续分组，但如果一个分组丢失，后面的分组将全部作废（同步错误）；
 CBC可以有效的保证密文的完整性，如果一个数据块在传递是丢失或改变，后面的数据将无法正常解密。
 */
#import "ViewController.h"
#import "EncryptionTools.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //AES - ECB 加密解密
//    [self AESECBEncryptDecrypt];
    
    //AES - CBC 加密解密
    [self AESCBCEncryptDecrypt];
}

#pragma mark ————— AES - ECB 加密解密 —————
- (void)AESECBEncryptDecrypt
{
    //key就是对称加密的密钥
    NSString * key = @"abc";
    
    /**
     iv:后面的参数代表几何向量，如果没有向量的话就写nil。
     */
    NSString * encStr = [[EncryptionTools sharedEncryptionTools] encryptString:@"hello" keyString:key iv:nil];
    NSLog(@"AES - ECB加密的结果为：%@", encStr);
    
    NSString *decStr = [[EncryptionTools sharedEncryptionTools] decryptString:encStr keyString:key iv:nil];
    NSLog(@"AES - ECB解密的结果为：%@", decStr);
}

#pragma mark ————— AES - CBC 加密解密 —————
- (void)AESCBCEncryptDecrypt
{
    NSString * key = @"abc";
    
    //几何向量
    uint8_t iv[8] = {1,2,3,4,5,6,7,8};
    
    //把几何向量转换为二进制数据类型
    NSData * ivData = [NSData dataWithBytes:iv length:sizeof(iv)];
    
    NSString * encStr = [[EncryptionTools sharedEncryptionTools] encryptString:@"hello" keyString:@"abc" iv:ivData];
    NSLog(@"AES - CBC加密结果为：%@", encStr);
    
    NSString *decStr = [[EncryptionTools sharedEncryptionTools] decryptString:encStr keyString:key iv:ivData];
    NSLog(@"AES - CBC解密结果为：%@",decStr);
}

@end
