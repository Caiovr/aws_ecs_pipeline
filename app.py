import datetime
import pandas as pd
import awswrangler as wr
from config import READ_BUCKET, \
    READ_DATA_PATH, \
    WRITE_BUCKET, \
    WRITE_DATA_PATH

def main():
    print("Hello world")
    objects = wr.s3.list_objects("s3://"+str(READ_BUCKET))
    #objects = wr.s3.list_objects("s3://vi-etl-dev-bucket-test-1")
    print(objects)
    main_df= pd.DataFrame()
    for object in objects:
        LastModified = wr.s3.describe_objects(object)[object]['LastModified']
        print("Object %s was last modified at %s " % (object,LastModified))
        if object.endswith(".csv")  and "~" not in object: ##file ends with .xlsx
            df = wr.s3.read_csv(
                path=object,
                sep = ";",
                encoding = "latin1"
            )
            main_df = pd.concat([main_df,df])
    
    #df = pd.read_csv(r"C:\Users\caiov\Downloads\cnaes.csv", encoding="latin1", sep=";")
    print (main_df)


if __name__ == '__main__':
    main()
    print("finished!")