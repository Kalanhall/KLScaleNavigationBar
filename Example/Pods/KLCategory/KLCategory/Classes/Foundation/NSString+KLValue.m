//
//  NSString+KLValue.m
//  KLCategory
//
//  Created by Logic on 2019/12/16.
//

#import "NSString+KLValue.h"

@implementation NSString (KLValue)

- (CGFloat)kl_decimalValue
{ return round(self.doubleValue * 100) / 100; }

- (NSString *)kl_decimalString
{ return [NSString stringWithFormat:@"%.2f", self.kl_decimalValue]; }

+ (NSString *)kl_decimalStringWithValue:(CGFloat)value
{
    value = round(value * 100) / 100;
    return [NSString stringWithFormat:@"%.2f", value];
}

- (NSString *)kl_decimalStyleString
{
    NSNumberFormatter *formatter = NSNumberFormatter.alloc.init;
    NSNumber *number = [formatter numberFromString:self.kl_decimalString];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    return [formatter stringFromNumber:number];
}

+ (NSString *)kl_decimalStyleStringWithValue:(CGFloat)value
{
    NSNumberFormatter *formatter = NSNumberFormatter.alloc.init;
    NSNumber *number = [formatter numberFromString:[self kl_decimalStringWithValue:value]];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    return [formatter stringFromNumber:number];
}

- (NSNumber *)kl_numberValue
{
    NSNumberFormatter *formatter = NSNumberFormatter.alloc.init;
    return [formatter numberFromString:self];
}

@end
