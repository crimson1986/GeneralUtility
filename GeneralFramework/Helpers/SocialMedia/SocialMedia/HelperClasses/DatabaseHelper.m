//
//  DatabaseHelper.m
//  Helpers
//
//  Created by Chirag shah on 11/03/14.
//  Copyright (c) 2014 Brijesh 04. All rights reserved.
//

#import "DatabaseHelper.h"

@interface DatabaseHelper ()
{
    sqlite3 *database;
}

@end

@implementation DatabaseHelper

+ (instancetype)sharedInstance {
    static DatabaseHelper *staticObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticObject = [[DatabaseHelper alloc] init];
    });
    return staticObject;
}

#pragma mark -
#pragma mark Database Methods
#pragma mark -

// Creates a writable copy of the bundled default database in the application Documents directory.
- (void)createEditableCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"database.sqlite"];
	NSString *writableDataPath = [documentsDirectory stringByAppendingPathComponent:@"data"];
    success = [fileManager fileExistsAtPath:writableDBPath];
	NSLog(@"%@",writableDBPath);
    if (success) return;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"database.sqlite"];
	//[fileManager createDirectoryAtPath:writableDataPath attributes:nil];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
		NSString *errString = [NSString stringWithFormat:@"%@", [NSLocalizedString(@"databaseLoadFailedKey",@"") stringByReplacingOccurrencesOfString:@"#" withString:[error localizedDescription] ]];
        NSAssert1(0, @"%@", errString);
    }
}

// Open the database connection and retrieve minimal information for all objects.
- (void)initializeDatabase {
	
    // The database is stored in the application bundle.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"database.sqlite"];
	
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
	{
        //TRUE
    }
	else
	{
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
		//NSString *errString = [NSString stringWithFormat:@"%@", [NSLocalizedString(@"databaseSelectionFailedKey",@"") stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithCString:sqlite3_errmsg(database)] ]];
        //NSAssert1(0, @"%@", errString);
        // Additional error handling, as appropriate...
    }
}

//Method for Datbase
-(BOOL)UpdateData:(NSMutableDictionary*)objDic :(NSString*)PrimaryKey :(NSString*)TABLE_NAME
{
	
	NSString* SQLColumns=@"";
	NSString* SQLValues=@"";
	NSString* SQL=@"";
	
	//Chekc Wheather Insert or update?
	BOOL IsNew=NO;
	if(![objDic valueForKey:PrimaryKey] )
	{
		IsNew=YES;
	}
	
	NSArray* Keys=[objDic allKeys];
	
	if(IsNew)
	{
		for(int i=0;i<Keys.count;i++)
		{
			if(![[Keys objectAtIndex:i] isEqual:PrimaryKey])
			{
				SQLColumns=[NSString stringWithFormat:@"%@%@,",SQLColumns,[Keys objectAtIndex:i]];
				SQLValues=[NSString stringWithFormat:@"%@?,",SQLValues];
			}
		}
		
		if([SQLColumns length]>0)
		{
			SQLColumns=[SQLColumns substringToIndex:[SQLColumns length]-1];
			SQLValues=[SQLValues substringToIndex:[SQLValues length]-1];
		}
		
		SQL=[NSString stringWithFormat:@"INSERT INTO %@ (%@) Values(%@)",TABLE_NAME,SQLColumns,SQLValues];
	}
	else
	{
		for(int i=0;i<Keys.count;i++)
		{
			if(![[Keys objectAtIndex:i] isEqual:PrimaryKey])
			{
				SQLColumns=[NSString stringWithFormat:@"%@%@=?,",SQLColumns,[Keys objectAtIndex:i]];
			}
		}
		
		if([SQLColumns length]>0)
		{
			SQLColumns=[SQLColumns substringToIndex:[SQLColumns length]-1];
		}
		
		SQL=[NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@=?",TABLE_NAME,SQLColumns,PrimaryKey];
	}
	
	sqlite3_stmt *insert_statement=nil;
	
	if (sqlite3_prepare_v2(database, [SQL UTF8String], -1, &insert_statement, NULL) != SQLITE_OK) {
		//NSString *errString = [NSString stringWithFormat:@"%@", [NSLocalizedString(@"statementPrepareFailedKey",@"") stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithCString:sqlite3_errmsg(database)] ]];
        //NSAssert1(0, @"%@", errString);
	}
	
	int intBindIndex=1;
	for(int i=0;i<Keys.count;i++)
	{
		if(![[Keys objectAtIndex:i] isEqual:PrimaryKey])
		{
			sqlite3_bind_text(insert_statement,intBindIndex,[[objDic valueForKey:[Keys objectAtIndex:i]] UTF8String],-1, SQLITE_STATIC);
			intBindIndex++;
		}
	}
	
	if(!IsNew)
	{
		sqlite3_bind_text(insert_statement,Keys.count,[[objDic valueForKey:PrimaryKey] UTF8String],-1, SQLITE_STATIC);
	}
	
	int result;
	result=sqlite3_step(insert_statement);
	
	if(IsNew)
	{
		[objDic setObject:[NSString stringWithFormat:@"%d",sqlite3_last_insert_rowid(database)] forKey:PrimaryKey];
	}
	
	sqlite3_finalize(insert_statement);
	
	
	if(result==SQLITE_DONE)
		return YES;
	else
		return NO;
}

-(NSMutableArray*)GetList:(NSString*)TABLE_NAME
{
	//NSAutoreleasePool* pool=[[NSAutoreleasePool alloc]init];
	
	NSMutableArray* Array;
	
	Array=[[NSMutableArray alloc]init];
	
	sqlite3_stmt *select_statement=nil;
	
	NSString *sql =[NSString stringWithFormat:@"select * from %@",TABLE_NAME];
	if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &select_statement, NULL) != SQLITE_OK) {
		NSString *errString = [NSString stringWithFormat:@"%@", [NSLocalizedString(@"statementPrepareFailedKey",@"") stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithCString:sqlite3_errmsg(database)] ]];
        NSAssert1(0, @"%@", errString);
	}
	
	int columncount=sqlite3_column_count(select_statement);
	
	NSMutableDictionary* dic;
	
	while (sqlite3_step(select_statement) == SQLITE_ROW)
	{
		dic=[[NSMutableDictionary alloc]init];
		
		for(int j=0;j<columncount;j++)
		{
			if(sqlite3_column_text(select_statement, j)!=nil)
				[dic setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(select_statement, j)] forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_name(select_statement,j)]];
			else
				[dic setObject:@"" forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_name(select_statement,j)]];
		}
		
		[Array addObject:dic];
	}
	
	sqlite3_finalize(select_statement);
	
	return Array;
}
-(NSMutableArray*)GetListBySQL:(NSString*)SQL
{
	
	NSMutableArray* Array;
	
	Array=[[NSMutableArray alloc]init];
	
	sqlite3_stmt *select_statement=nil;
	
	if (sqlite3_prepare_v2(database, [SQL UTF8String], -1, &select_statement, NULL) != SQLITE_OK) {
		NSString *errString = [NSString stringWithFormat:@"%@", [NSLocalizedString(@"statementPrepareFailedKey",@"") stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithCString:sqlite3_errmsg(database)] ]];
        NSAssert1(0, @"%@", errString);
	}
	
	int columncount=sqlite3_column_count(select_statement);
	
	NSMutableDictionary* dic;
	
	while (sqlite3_step(select_statement) == SQLITE_ROW)
	{
		dic=[[NSMutableDictionary alloc]init];
		
		for(int j=0;j<columncount;j++)
		{
			if(sqlite3_column_text(select_statement, j)!=nil)
				[dic setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(select_statement, j)] forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_name(select_statement,j)]];
			else
				[dic setObject:@"" forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_name(select_statement,j)]];
		}
		
		[Array addObject:dic];
	}
	
	sqlite3_finalize(select_statement);
	
	return Array;
}

-(NSMutableDictionary*)GetDetails:(NSString*)TABLE_NAME :(NSString*)PrimaryKey :(NSString*)Value
{

	
	NSMutableDictionary* dicInfo=[[NSMutableDictionary alloc]init];
	
	sqlite3_stmt *select_statement=nil;
	
	NSString *sql =[NSString stringWithFormat:@"select * from %@ where %@=?",TABLE_NAME,PrimaryKey];
	if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &select_statement, NULL) != SQLITE_OK) {
		NSString *errString = [NSString stringWithFormat:@"%@", [NSLocalizedString(@"statementPrepareFailedKey",@"") stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithCString:sqlite3_errmsg(database)] ]];
        NSAssert1(0, @"%@", errString);
	}
	
	sqlite3_bind_text(select_statement,1,[Value UTF8String],-1, SQLITE_STATIC);
	
	int columncount=sqlite3_column_count(select_statement);
	
	if (sqlite3_step(select_statement) == SQLITE_ROW)
	{
		for(int j=0;j<columncount;j++)
		{
			if(sqlite3_column_text(select_statement, j)!=nil)
				[dicInfo setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(select_statement, j)] forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_name(select_statement,j)]];
			else
				[dicInfo setObject:@"" forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_name(select_statement,j)]];
		}
	}
	
	sqlite3_finalize(select_statement);
	
	
	return dicInfo;
}

-(BOOL)DeleteDetail:(NSString*)TABLE_NAME :(NSString*)PrimaryKey :(NSString*)Value
{
	
	sqlite3_stmt *select_statement=nil;
	
	NSString *sql =[NSString stringWithFormat:@"Delete from %@ where %@=?",TABLE_NAME,PrimaryKey];
	if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &select_statement, NULL) != SQLITE_OK) {
		NSString *errString = [NSString stringWithFormat:@"%@", [NSLocalizedString(@"statementPrepareFailedKey",@"") stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithCString:sqlite3_errmsg(database)] ]];
        NSAssert1(0, @"%@", errString);
	}
	
	sqlite3_bind_text(select_statement,1,[Value UTF8String],-1, SQLITE_STATIC);
	
	int result;
	
	result=sqlite3_step(select_statement);
	
	sqlite3_finalize(select_statement);
	
	
	if(result==SQLITE_DONE)
		return YES;
	else
		return NO;
}

-(BOOL)executeSQL:(NSString*)sql{
	sqlite3_stmt *sql_statement=nil;
	
	if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &sql_statement, NULL) != SQLITE_OK) {
		NSString *errString = [NSString stringWithFormat:@"%@", [NSLocalizedString(@"statementPrepareFailedKey",@"") stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithCString:sqlite3_errmsg(database)] ]];
        NSAssert1(0, @"%@", errString);
	}
	
	int result = sqlite3_step(sql_statement);
	sqlite3_finalize(sql_statement);
	
	if(result==SQLITE_DONE)
		return YES;
	else
		return NO;
}
@end
