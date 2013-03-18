//
//  main.m
//  DicFileGlue
//
//  Created by Viktor Yamchinov on 2/28/13.
//  Copyright (c) 2013 Viktor Yamchinov. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        // NSLog(@"Hello, World!");
        NSFileManager *filemanager = [NSFileManager defaultManager];
        NSString *path;
        for (int i = 0; i < argc; i++) {
            if (i == 1) {
                path = [NSString stringWithCString:argv[i] encoding:NSUTF8StringEncoding];
            }
        }
        // check directory path
        if ([filemanager fileExistsAtPath:path] == YES) {
            NSLog(@"Directory exist!");
            NSArray *files;
            NSError *error;
            NSString *textFromFiles = @"\n";
            NSString *str = [[NSString alloc] init];
            // get files in directory
            files = [filemanager contentsOfDirectoryAtPath:path error:&error];
            NSString *resultfile = [path stringByAppendingPathComponent:@"result.txt"];
            // create result file if it doesn't exist
            if ([filemanager fileExistsAtPath:resultfile] == NO) {  
                NSLog(@"Result file doesn't exit! Creating...");
                [filemanager createFileAtPath:resultfile contents:nil attributes:nil];
            }
            // write content of all files in result file
            for (NSString *f in files) {
                NSString *tempStr = [NSString stringWithContentsOfFile:[path stringByAppendingPathComponent:f] usedEncoding:nil error:nil];
                // check that the content is exist
                if (tempStr == nil) {
                    NSLog(@"tempStr is NULL");
                }
                else
                    str = [textFromFiles stringByAppendingString:tempStr];
                textFromFiles = str;
                NSLog(@"File: %@", f);
            }
            [textFromFiles writeToFile:resultfile atomically:YES encoding:YES error:nil];
        }
        else {
            NSLog(@"Directory doesn't exist!");
        }
        
    }
    return 0;
}

