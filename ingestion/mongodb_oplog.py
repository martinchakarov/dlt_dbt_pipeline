import dlt
from dlt.common import pendulum
from dlt.common.data_writers import TDataItemFormat
from dlt.common.pipeline import LoadInfo
from dlt.common.typing import TDataItems
from dlt.pipeline.pipeline import Pipeline

try:
    from .mongodb import mongodb, mongodb_collection  
except ImportError:
    from mongodb import mongodb, mongodb_collection

def load_select_collection_db(pipeline: Pipeline = None) -> LoadInfo:
    """Use the mongodb source to reflect an entire database schema and load select tables from it.

    This example sources data from a sample mongo database data from [mongodb-sample-dataset](https://github.com/neelabalan/mongodb-sample-dataset).
    """
    if pipeline is None:
        # Create a pipeline
        pipeline = dlt.pipeline(
            pipeline_name="mongo_oplog",
            destination='snowflake',
            dataset_name="mongo_oplog",
            progress="log"
        )
    
    # Configure the source to load a few select collections incrementally
    oplog = mongodb().with_resources(
        "oplog.rs"
    )
    oplog.max_table_nesting = 0
    oplog.primary_key = "ui"

    # Run the pipeline. The merge write disposition merges existing rows in the destination by primary key
    info = pipeline.run(oplog, write_disposition="replace")

    return info


if __name__ == "__main__":
    print(load_select_collection_db())