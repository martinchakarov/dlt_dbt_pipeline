import dlt
import os
from dlt.common import pendulum
from dlt.common.data_writers import TDataItemFormat
from dlt.common.pipeline import LoadInfo
from dlt.common.typing import TDataItems
from dlt.pipeline.pipeline import Pipeline

connection_url = os.environ.get('SOURCES__MONGODB__CONNECTION_URL')
os.environ['SOURCES__MONGODB__CONNECTION_URL'] = connection_url + "sample_supplies"

try:
    from .mongodb import mongodb, mongodb_collection  # type: ignore
except ImportError:
    from mongodb import mongodb, mongodb_collection

def load_collection_incrementally(pipeline: Pipeline = None) -> LoadInfo:
    """Use the mongodb source to reflect an entire database schema and load select tables from it."""
    if pipeline is None:

        pipeline = dlt.pipeline(
            pipeline_name="local_mongo",
            destination='snowflake',
            dataset_name="supplies_sample",
            progress="log"
        )

    sales = mongodb(incremental=dlt.sources.incremental("saleDate")).with_resources(
        "sales"
    )

    sales.max_table_nesting = 0
    info = pipeline.run(sales, write_disposition="merge")

    return info

if __name__ == "__main__":
    print(load_collection_incrementally())