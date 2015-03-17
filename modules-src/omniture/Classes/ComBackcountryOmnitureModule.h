
#import "TiModule.h"
#import "ADBMobile.h"

@interface ComBackcountryOmnitureModule : TiModule
{
}
@end

// this block in necessary for removing a warning on the build sumbission, see [here](http://stackoverflow.com/a/26094120/182077)
@interface NSObject (Consume)
    -(void)consume:(id)dummy;
@end
@implementation NSObject (Consume)
    -(void)consume:(id)dummy {}
@end

