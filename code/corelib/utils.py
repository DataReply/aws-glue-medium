from pyspark.sql import DataFrame
from pyspark.sql import functions as F


def convert_column_to_uppercase(df: DataFrame, column_name: str) -> DataFrame:
    """
    Converts specified column values to uppercase.
    
    Args:
        df: Input DataFrame
        column_name: Name of the column to convert to uppercase
    
    Returns:
        DataFrame with converted column
    """
    return df.withColumn(column_name, F.upper(F.col(column_name)))


def convert_column_to_lowercase(df: DataFrame, column_name: str) -> DataFrame:
    """
    Converts specified column values to lowercase.
    
    Args:
        df: Input DataFrame
        column_name: Name of the column to convert to lowercase
    
    Returns:
        DataFrame with converted column
    """
    return df.withColumn(column_name, F.lower(F.col(column_name)))
