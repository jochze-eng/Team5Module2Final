1. Install the GCP SDK/ CLI

2. Open a terminal in VScode or any cmd. Type the following command
type "gcloud init" then press Enter. If you already authenticate before it will ask you 2 options. I choose [1] Re-initialize this configuration [default] with new settins
type "gcloud projects list" this will show all projects in GCP. We need to set this to our project id "fluid-keyword-454503-a8". 
if "gcloud projects list" got error do the login again by typing "gcloud auth login" this will open web browswer and ask you to loginto GCP
type "gcloud config set project fluid-keyword-454503-a8" to get project folder to our project
type "gcloud config list" to check your login account and project. We should see project = fluid-keyword-454503-a8

3. pip install google-cloud-bigquery
Install the "Google Cloud Code" VScode extension is optional

4. We can check our buket list in the project. Following CLI work
"gsutil ls" This will list all buckets in your current project
"gsutil ls -p fluid-keyword-454503-a8" More detailed listing:
"gsutil ls gs://team5brazilian" If you want to see details about a specific bucket. This will return 
gs://team5brazilian/olist_customers_dataset.csv
gs://team5brazilian/olist_geolocation_dataset.csv
gs://team5brazilian/olist_order_items_dataset.csv
gs://team5brazilian/olist_order_payments_dataset.csv
gs://team5brazilian/olist_order_reviews_dataset.csv
gs://team5brazilian/olist_orders_dataset.csv
gs://team5brazilian/olist_products_dataset.csv
gs://team5brazilian/olist_sellers_dataset.csv

5. to create buket "gsutil mb gs://your-unique-bucket-name". Well we can use GCP Console for ease of getting the job done

About how to access BigQuerry from CLI
1. "bq ls", "bq ls --format=pretty", "bq ls --format=json". Any of this will list all datasets in your current project. Return like this
datasetId  
-----------
brazilian


2. "bq ls brazilian". we can check how many tables are in side the dataset. I got the return like this:
      tableId        Type    Labels   Time Partitioning   Clustered Fields  
 ------------------- ------- -------- ------------------- ------------------
  customers_dataset   TABLE
  geolocation         TABLE
  order_items         TABLE
  order_payments      TABLE
  orders              TABLE
  products            TABLE
  sellers             TABLE

