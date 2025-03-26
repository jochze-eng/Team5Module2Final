from google.cloud import bigquery

# Initialize BigQuery client
client = bigquery.Client()

# Define project and dataset details
project_id = "fluid-keyword-454503-a8"
dataset_id = "olist_ecommerce_staging"  # Suggested dataset name
gcs_bucket = "team5brazilian"

# Define table names and their corresponding GCS file paths
tables = {
    "customers_dataset": "olist_customers_dataset.csv",
    "geolocation_dataset": "olist_geolocation_dataset.csv",
    "order_items_dataset": "olist_order_items_dataset.csv",
    "order_payments_dataset": "olist_order_payments_dataset.csv",
    "order_reviews_dataset": "olist_order_reviews_dataset.csv",
    "orders_dataset": "olist_orders_dataset.csv",
    "products_dataset": "olist_products_dataset.csv",
    "sellers_dataset": "olist_sellers_dataset.csv",
    "translation_dataset" : "product_category_name_translation.csv"
}

# Ensure the dataset exists
dataset_ref = client.dataset(dataset_id)
try:
    client.get_dataset(dataset_ref)
except Exception:
    # Create the dataset if it doesn't exist
    dataset = bigquery.Dataset(dataset_ref)
    client.create_dataset(dataset)
    print(f"Created dataset {dataset_id}")

# Loop over each table and load data
for table_name, file_name in tables.items():
    table_id = f"{project_id}.{dataset_id}.{table_name}"
    gcs_uri = f"gs://{gcs_bucket}/{file_name}"
    
    # Configure the load job
    job_config = bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.CSV,
        skip_leading_rows=1,
        autodetect=True,  # Automatically detects schema
        write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE,  # Overwrites existing data
    )
    
    try:
        print(f"Loading {file_name} into {table_id}...")
        load_job = client.load_table_from_uri(
            gcs_uri, table_id, job_config=job_config
        )
        
        # Wait for the job to complete and handle errors
        load_job.result()
        
        # Get the table to verify load
        table = client.get_table(table_id)
        print(f"✅ Loaded {file_name} into {table_id}")
        print(f"Table {table_name} now has {table.num_rows} rows")
    
    except Exception as e:
        print(f"❌ Error loading {file_name}: {e}")

print("🎉 Data loading process completed!")