import datetime
import pandas as pd
import awswrangler as wr
import logging
from config import READ_BUCKET, \
    READ_DATA_PATH, \
    WRITE_BUCKET, \
    WRITE_DATA_PATH

READ_BUCKET = "vi-etl-dev-bucket-test-1" #To run Locally
WRITE_BUCKET = "vi-etl-dev-bucket-test-2" #To run Locally

def set_Logger(log_file=""):
    root = logging.getLogger()
    root.setLevel(logging.INFO)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

    #handler = logging.StreamHandler(sys.stdout)
    #handler.setLevel(logging.INFO)
    #handler.setFormatter(formatter)
    
    #root.addHandler(handler)

    if log_file: ## if is empty
        output_file_handler = logging.FileHandler(log_file,mode='w')
        output_file_handler.setLevel(logging.INFO)
        output_file_handler.setFormatter(formatter)
        root.addHandler(output_file_handler)

def main():
    set_Logger("")
    print("Teste de print")
    logging.info(" #### STARTED CAPTACAO ETL PYTHON #### ")
    logging.info("Hello world")
    objects = wr.s3.list_objects("s3://"+str(READ_BUCKET))
    #objects = wr.s3.list_objects("s3://vi-etl-dev-bucket-test-1")
    logging.info(objects)
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
    logging.info(main_df)

    res = wr.s3.to_parquet(
        df=main_df,
        path="s3://"+str(WRITE_BUCKET),
        dataset=True,
        mode="append",
        database="catalog_test",
        table="teste_apagar"
    )


if __name__ == '__main__':
    main()
    logging.info("finished!")