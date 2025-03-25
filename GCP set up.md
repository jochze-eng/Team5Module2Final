# Google Cloud Platform (GCP) Setup Guide

## 1. Install and Initialize GCP SDK/CLI

### Prerequisites
- Install Google Cloud SDK from the [official website](https://cloud.google.com/sdk/docs/install)

### Authentication and Project Setup

1. Open terminal in VSCode or Command Prompt

2. Initialize GCP configuration:
   ```bash
   gcloud init
   ```
   - If already authenticated, choose: 
     `[1] Re-initialize this configuration [default] with new settings`

3. List available projects:
   ```bash
   gcloud projects list
   ```
   - If you encounter an error, log in first:
     ```bash
     gcloud auth login
     ```
     - This opens a web browser for GCP authentication

4. Set your project:
   ```bash
   gcloud config set project fluid-keyword-454503-a8
   ```

5. Verify configuration:
   ```bash
   gcloud config list
   ```
   - Confirm project is set to `fluid-keyword-454503-a8`

## 2. Prepare Development Environment

1. Install BigQuery Python library:
   ```bash
   pip install google-cloud-bigquery
   ```

2. Optional: Install VSCode Extension
   - Install "Google Cloud Code" from VSCode Extensions

## 3. Explore Google Cloud Storage (GCS)

### List Buckets and Files

1. List all buckets:
   ```bash
   gsutil ls
   ```

2. Detailed project bucket listing:
   ```bash
   gsutil ls -p fluid-keyword-454503-a8
   ```

3. View specific bucket contents:
   ```bash
   gsutil ls gs://team5brazilian
   ```
   This will show files like:
   - `olist_customers_dataset.csv`
   - `olist_geolocation_dataset.csv`
   - ... (other CSV files)

4. Create a new bucket (if needed):
   ```bash
   gsutil mb gs://your-unique-bucket-name
   ```
   💡 *Tip: You can also create buckets via GCP Console*

## 4. Accessing BigQuery via CLI

### List Datasets
```bash
bq ls
# Alternative formats:
# bq ls --format=pretty
# bq ls --format=json
```

### List Tables in a Dataset
```bash
bq ls brazilian
```

Example output:
```
tableId             Type    Labels   Time Partitioning   Clustered Fields  
------------------- ------- -------- ------------------- ------------------
customers_dataset   TABLE
geolocation         TABLE
order_items         TABLE
order_payments      TABLE
orders              TABLE
products            TABLE
sellers             TABLE
```

## 💡 Pro Tips
- Always double-check your project ID
- Use `gcloud auth login` if authentication fails
- Keep your Google Cloud SDK updated
