//
//  FavouriteMovieViewController.m
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "FavouriteMovieViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MoviePOJO.h"

#import "MoviedetailsViewController.h"
@interface FavouriteMovieViewController ()
{
    
  
    NSArray* myData;
}
@property (weak, nonatomic) IBOutlet UICollectionView *favouriteCollectionView;
@end

@implementation FavouriteMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    self.title =@"Favourite";
    myData = [NSMutableArray new];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        FavouriteMoviePresenter *moviePresenter = [[FavouriteMoviePresenter alloc] initWithMovieView:self];
        [moviePresenter getMovies];
    });
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return myData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"favouritecell" forIndexPath:indexPath];
    
    // Configure the cell
    UIImageView *imageView = [cell viewWithTag:1];

    NSString *imgPath=@"https://image.tmdb.org/t/p/w185//";
    NSString *imgData=@"";//myData[indexPath.row][@"poster_path"];// poster_path  for network
     MoviePOJO *movieDetails2=myData[indexPath.row];
    imgData=movieDetails2.poster_path;//myData[indexPath.row][@"poster_path"];// poster_path  for network
    
    if (imgData == (id)[NSNull null] || imgData.length == 0 ) {
        imgData = @"";
    }
    imgPath=[imgPath stringByAppendingString: imgData   ];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imgPath]
                 placeholderImage:[UIImage imageNamed:@"defaultPoster.jpg"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MoviedetailsViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"moviedetail"];
    MoviePOJO *movieDetails=myData[indexPath.row];

    [detail setMovieDetail:movieDetails];
    [self.navigationController pushViewController:detail animated:YES];
    
    
    
}
#pragma mark <UICollectionViewDelegate>


-(void)showLoading{
    
    printf("Show Loading\n");
    
}

-(void) hideLoading{
    
    printf("hide Loading\n");
}

-(void)showErrorMessage:(NSString *)errorMessage{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
}

- (void)renderMoviesWithObject:(nonnull NSArray *)movieList : (Boolean) isFromNetwrok {
    printf("hide Loading\n");
    myData=movieList;
    [self.favouriteCollectionView reloadData];
}

@end
