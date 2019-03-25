//
//  MovieListViewController.m
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "MovieListViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MoviePOJO.h"
@interface MovieListViewController ()
{
    
    NSArray* images ;
    NSArray* myData;
}
@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    images = @[@"1.png",@"1.png",@"1.png"];
    myData = @[@"One" , @"Two" , @"Three"];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        
        MoviePresenter *moviePresenter = [[MoviePresenter alloc] initWithMovieView:self];
        [moviePresenter getMovies];
    });
    
    // Do any additional setup after loading the view.
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
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"moviecell" forIndexPath:indexPath];
    
    // Configure the cell
    UIImageView *imageView = [cell viewWithTag:1];

   // [imageView setImage:[UIImage imageNamed:[images objectAtIndex:indexPath.row]]];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://api.androidhive.info/json/movies/1.jpg"]
                 placeholderImage:[UIImage imageNamed:@"1.png"]];
    //printf("%s   %i \n " ,myData[indexPath.row] ,indexPath.row);
    return cell;
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

- (void)renderMoviesWithObject:(nonnull MoviePOJO *)movieList {
    printf("hide Loading\n");
}

@end
