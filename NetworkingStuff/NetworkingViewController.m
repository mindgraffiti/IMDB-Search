//
//  NetworkingViewController.m
//  NetworkingStuff
//
//  Created by Thuy Copeland on 4/9/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "NetworkingViewController.h"
#import "AFNetworking.h"

@interface NetworkingViewController ()

@end

@implementation NetworkingViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // add this as another acceptable content type 
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    self.title = @"IMDB Search";
}
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    NSDictionary *movie = [self.movies objectAtIndex:indexPath.row];
    cell.textLabel.text = [movie valueForKeyPath:@"title"];
    return cell;
}

- (IBAction)search:(id)sender
{
    // dismiss the keyboard view upon searching
    [self.view endEditing:YES];
    
    NSString *searchURL = [NSString stringWithFormat:@"http://imdbapi.org/?type=json&title=%@&limit=10", self.searchField.text];
    // encode special characters found in the searchURL.
    NSString *encodedURL = [searchURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodedURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        self.movies = JSON;
        [self.movieTable reloadData];
        //NSLog(@"%@", [JSON valueForKeyPath:@"title"]);
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        NSLog(@"Errors. %@", error);
     }];
    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
