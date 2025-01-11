import dlt
import os
from dlt.common import pendulum
from dlt.common.data_writers import TDataItemFormat
from dlt.common.pipeline import LoadInfo
from dlt.common.typing import TDataItems
from dlt.pipeline.pipeline import Pipeline

connection_url = os.environ.get('SOURCES__MONGODB__CONNECTION_URL')
os.environ['SOURCES__MONGODB__CONNECTION_URL'] = connection_url + "sample_mflix"

try:
    from .mongodb import mongodb, mongodb_collection  # type: ignore
except ImportError:
    from mongodb import mongodb, mongodb_collection

def load_entire_database(pipeline: Pipeline = None) -> LoadInfo:
    """Use the mongo source to completely load all collection in a database"""
    if pipeline is None:
        pipeline = dlt.pipeline(
            pipeline_name="mongo_mflix",
            destination='snowflake',
            dataset_name="mflix_sample",
            progress="log"
        )

    source = mongodb()
    source.max_table_nesting = 0

    info = pipeline.run(source, write_disposition="replace")

    return list(info)


if __name__ == "__main__":
    print(load_entire_database())