//
//  PostMediaTableViewCtr.m
//  PostMediaAppSampleObjC
//
//

#import "PostMediaTableViewCtr.h"

@interface PostMediaTableViewCtr ()
{

    NSMutableArray *postsObjectsArrayG;
    
    NSString *postsDatabaseClassNameG;
    
    UIView *postViewG;
    
    UITextField *postTextFieldG;
    
    UIButton *postButtonG;
    
}

@end


@implementation PostMediaTableViewCtr


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.tableView.estimatedRowHeight = 44.0;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    
    [self setPostView];
    
    [self getPosts];

    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    int numberOfRows = numberOfRows = (int)postsObjectsArrayG.count;

    
    NSArray *counts = @[[NSNumber numberWithInt:numberOfRows]];
    
    
    return [counts[section] integerValue];

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 
    
    return postViewG;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    return 100.f;

    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    
    
    switch (section)
    {
            
        case 0: return [self displayPostsCell:indexPath];
    
    }
    
    
    return nil;

}


- (void) setPostView {
    
    
    CGRect screenDimensions = [[UIScreen mainScreen] bounds];
    
    
    postsDatabaseClassNameG = @"Posts";
    
    postsObjectsArrayG = [[NSMutableArray alloc] init];

    postViewG =[[UIView alloc] initWithFrame:CGRectMake(0,10,screenDimensions.size.width, 80)];
    
    
    postTextFieldG = [[UITextField alloc] initWithFrame:CGRectMake(10,20,screenDimensions.size.width - 70, 60)];
    
    postTextFieldG.delegate = self;
    
    postTextFieldG.backgroundColor = [UIColor colorWithRed: 0 green: 1.0 blue: 1.0 alpha: .5];
    
    postTextFieldG.placeholder = @"Express yourself";
    
    postTextFieldG.clearsOnBeginEditing = YES;
    
    
    postButtonG = [[UIButton alloc] initWithFrame:CGRectMake(screenDimensions.size.width - 70, 20, 70, 60)];
    
    [postButtonG addTarget:self action:@selector(postButton:) forControlEvents: UIControlEventTouchUpInside];
    
    
    [postButtonG setTitle: @"Post" forState:UIControlStateNormal];
    
    [postButtonG setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    
    postButtonG.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Heavy" size:22];
    
    postButtonG.backgroundColor = [UIColor yellowColor];
    
    
    [postViewG addSubview:postTextFieldG];
    
    [postViewG addSubview:postButtonG];

    
}


- (void) getPosts {
    
    
    PFQuery *postsQuery = [PFQuery queryWithClassName:postsDatabaseClassNameG];
    
    [postsQuery orderByDescending:@"createdAt"];
    
    [postsQuery findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError *error) {
        
        
        [postsObjectsArrayG removeAllObjects];
        
        postsObjectsArrayG = (NSMutableArray *)objects;
        
        [self.tableView reloadData];
        
        
    }];
    
}


- (void) postButton:(UIButton *)sender {

    
    PFObject *newPostObject = [PFObject objectWithClassName:postsDatabaseClassNameG];
    
    NSString *postText = postTextFieldG.text;
    
    
    [newPostObject setObject:postText forKey: @"posts"];
    
    [newPostObject saveInBackground];
    
    
    [postsObjectsArrayG insertObject:newPostObject atIndex:0];
    
    [self.tableView reloadData];
    
    
}


- (UITableViewCell* ) displayPostsCell:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self createCell:indexPath];
    
    NSString *post = @"";

    
    post = [postsObjectsArrayG[indexPath.row] objectForKey:@"posts"];
    
    cell.textLabel.text = post;
    
    
    return cell;

}


- (UITableViewCell *) createCell:(NSIndexPath *) indexPath {
    
    
    NSString *cellID = @"standardPostCell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
