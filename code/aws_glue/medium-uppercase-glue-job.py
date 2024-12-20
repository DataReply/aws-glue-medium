import sys
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

from corelib.utils import convert_column_to_uppercase, convert_column_to_lowercase

args = getResolvedOptions(sys.argv, ['JOB_NAME', 'MEDIUM_BUCKET'])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

source_path = f"s3://{args['MEDIUM_BUCKET']}/raw-data/"
target_path = f"s3://{args['MEDIUM_BUCKET']}/uppercase-data/"

source_df = spark.read.csv(source_path, header=True)

# Make product column uppercase
processed_df = convert_column_to_uppercase(source_df, "product")

processed_df.write.mode("overwrite").parquet(target_path)

job.commit()
