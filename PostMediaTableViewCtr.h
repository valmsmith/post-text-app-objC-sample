//
//  PostMediaTableViewCtr.h
//  PostMediaAppSampleObjC
//

#import <UIKit/UIKit.h>

#import <Parse/Parse.h>


@interface PostMediaTableViewCtr : UITableViewController<UITextFieldDelegate>


- (void) setPostView;

- (void) postButton:(UIButton *) sender;

- (void) getPosts;

- (UITableViewCell *) displayPostsCell:(NSIndexPath *) indexPath;

- (UITableViewCell *) createCell:(NSIndexPath *) indexPath;


@end

