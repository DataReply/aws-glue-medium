import pytest
from pyspark.sql import SparkSession

@pytest.fixture(scope="session")
def spark():
    return SparkSession.builder \
        .appName("test_glue_utils") \
        .master("local[1]") \
        .getOrCreate()

@pytest.fixture
def sample_df(spark):
    return spark.createDataFrame([
        ("NORTH", "product-a"),
        ("SOUTH", "product-b")
    ], ["region", "product"])

def test_convert_column_to_uppercase(sample_df):
    from corelib.utils import convert_column_to_uppercase
    
    result_df = convert_column_to_uppercase(sample_df, "product")
    
    assert result_df.collect()[0]["product"] == "PRODUCT-A"
    assert result_df.collect()[1]["product"] == "PRODUCT-B"

def test_convert_column_to_lowercase(sample_df):
    from corelib.utils import convert_column_to_lowercase
    
    result_df = convert_column_to_lowercase(sample_df, "region")
    
    assert result_df.collect()[0]["region"] == "north"
    assert result_df.collect()[1]["region"] == "south"

def test_multiple_conversions(sample_df):
    from corelib.utils import convert_column_to_uppercase, convert_column_to_lowercase
    
    result_df = convert_column_to_uppercase(sample_df, "product")
    result_df = convert_column_to_lowercase(result_df, "region")
    
    first_row = result_df.collect()[0]
    assert first_row["region"] == "north"
    assert first_row["product"] == "PRODUCT-A" 