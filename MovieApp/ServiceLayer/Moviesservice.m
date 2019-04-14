//
//  Moviesservice.m
//  MovieApp
//
//  Created by Admin on 3/25/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "Moviesservice.h"

#import "MoviePOJO.h"
#import "TrailerPOJO.h"
#import "ReviewPOJO.h"
@implementation Moviesservice
{
@protected int msortType;
}
- (void)handleFailWithErrorMessage:(NSString *)errorMessage :(NSString *)serviceName{
    if ([serviceName isEqualToString:@"Moviesservice"]) {
    [_moviePresenter onFail:errorMessage];
    }
    
    else if ([serviceName isEqualToString:@"Moviesdetailsservice"]) {
        [_moviedetailsPresenter onFail:errorMessage ];
    }
    else if ([serviceName isEqualToString:@"MoviesReviewsService"]) {
        [_movieReviewsPresenter onFail:errorMessage ];
    }
}

- (void)handleSuccessWithJSONData:(id)jsonData :(NSString *)serviceName {
    if ([serviceName isEqualToString:@"Moviesservice"]) {
        NSDictionary *dict = (NSDictionary*)jsonData;
        NSMutableArray<MoviePOJO *>  *moviesArray = [NSMutableArray new];
          NSMutableArray *jsonObj=[[dict objectForKey:@"results"] mutableCopy];
        for(int i=0;i<jsonObj.count;++i){
            MoviePOJO *tempmovie=[MoviePOJO new];
            NSDictionary *tempDic=[jsonObj objectAtIndex:i];
            tempmovie.mid= [tempDic objectForKey:@"id"];
           // tempmovie.mid=[mid stringValue];
           
            tempmovie.title=[tempDic objectForKey:@"title"];
            tempmovie.release_date=[tempDic objectForKey:@"release_date"];
            tempmovie.overview=[tempDic objectForKey:@"overview"];
            tempmovie.poster_path=[tempDic objectForKey:@"poster_path"];
            tempmovie.vote_average= [tempDic objectForKey:@"vote_average"];
           // tempmovie.vote_average = [vote_average stringValue];;
            tempmovie.isFavourite=@"false";
            tempmovie.sortType=msortType;
            [moviesArray addObject:tempmovie];
        }
        [_moviePresenter onSuccess:moviesArray : true];
    }
    
    else if ([serviceName isEqualToString:@"Moviesdetailsservice"]) {
         NSMutableArray  *moviesTrailerArray = [NSMutableArray new];
        NSString *youtubeBaseUrl=@"https://www.youtube.com/watch?v=";
        NSDictionary *dict = (NSDictionary*)jsonData;
        NSMutableArray *jsonObj=[[dict objectForKey:@"results"] mutableCopy];
        for(int i=0;i<jsonObj.count;++i){
            TrailerPOJO *tempTrailer=[TrailerPOJO new];
            NSDictionary *tempDic=[jsonObj objectAtIndex:i];
            tempTrailer.trailerId=[tempDic objectForKey:@"id"];
            tempTrailer.trailerName=[tempDic objectForKey:@"name"];
            NSString *movieTrailerKey=[tempDic objectForKey:@"key"];
            tempTrailer.TrailerUrl=[NSString stringWithFormat:@"%@%@",youtubeBaseUrl,movieTrailerKey];

            [moviesTrailerArray addObject:tempTrailer];
        }
 [_moviedetailsPresenter retrieveTrailers:moviesTrailerArray ];
    }
    else if ([serviceName isEqualToString:@"MoviesReviewsService"]) {
        NSMutableArray  *moviesReviewsArray = [NSMutableArray new];
        NSDictionary *dict = (NSDictionary*)jsonData;
        NSMutableArray *jsonObj=[[dict objectForKey:@"results"] mutableCopy];
        for(int i=0;i<jsonObj.count;++i){
            ReviewPOJO *tempReview=[ReviewPOJO new];
            NSDictionary *tempDic=[jsonObj objectAtIndex:i];
            tempReview.author=[tempDic objectForKey:@"author"];
            tempReview.content=[tempDic objectForKey:@"content"];
             tempReview.url=[tempDic objectForKey:@"url"];
            [moviesReviewsArray addObject:tempReview];
        }
        [_movieReviewsPresenter onSuccess:moviesReviewsArray];
    }
    
    
    
    
}

- (void)getMovies:(id<IMoviePresenter>)moviePresenter  :(int) sortType{
    _moviePresenter = moviePresenter;
    msortType=sortType;
    if(sortType == 0){
       [NetworkManager connectGetToURL:@"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.%20desc&api_key=655584bcccf3ea4d6c31de42c1468bf8" serviceName:@"Moviesservice" serviceProtocol:self];
    }
    else{
        [NetworkManager connectGetToURL:@"https://api.themoviedb.org/3/movie/top_rated?api_key=655584bcccf3ea4d6c31de42c1468bf8" serviceName:@"Moviesservice" serviceProtocol:self];
    }
    
}

- (void)getMoviesDetails:(id<IMovieDetailsPresenter>)movieDetailsPresenter :(NSString*)movieId{
    _moviedetailsPresenter= movieDetailsPresenter;
    
    NSString *urlStr=[NSString stringWithFormat:@"http://api.themoviedb.org/3/movie/%d/videos?api_key=655584bcccf3ea4d6c31de42c1468bf8",[movieId intValue]];//383
    [NetworkManager connectGetToURL:urlStr serviceName:@"Moviesdetailsservice" serviceProtocol:self];
}

- (void)getMoviesReviews:(id<IMovieReviewsPresenter>)movieDetailsPresenter :(NSString*)movieId{
    _movieReviewsPresenter= movieDetailsPresenter;
    
    NSString *urlStr=[NSString stringWithFormat:@"http://api.themoviedb.org/3/movie/%d/reviews?api_key=655584bcccf3ea4d6c31de42c1468bf8",[movieId intValue]];//383
    
    
    //http://api.themoviedb.org/3/movie/301/videos?api_key=655584bcccf3ea4d6c31de42c1468bf8
    [NetworkManager connectGetToURL:urlStr serviceName:@"MoviesReviewsService" serviceProtocol:self];
}


@end
