# Deploy to Cloud Run

The package executable has been built and added to the example until the
`functionsframework` is published. 

## HTTP functions

1. Set env var "GCP_PROJECT" to our project name:

  ```
  GCP_PROJECT=$(gcloud config list --format 'value(core.project)' 2>/dev/null)
  ```

1. Build and upload your image in Google Container Registry:

  ```
  gcloud builds submit \
  --tag gcr.io/$GCP_PROJECT/hello-r \
  --timeout="20m"
  ```

1. Deploy your container to Cloud Run:

  ```
  gcloud run deploy hello-r \
  --image gcr.io/$GCP_PROJECT/hello-r \
  --platform managed \
  --allow-unauthenticated
  ```

1. Test out your app:

  ```bash
  curl https://hello-r-HASH-uc.a.run.app

  # Output
  ["Hello World!"]
  ```

## Background functions

1. Update the Dockerfile with  `ENTRYPOINT`:

```Dockerfile
ENTRYPOINT [ "Rscript", "create-app.R", "--target", "HelloEvent", "--source", "event.R", "--signature_type", "event" ]
```
1. Follow the above steps to build and deploy.

1. Test out your app:

```bash
curl -H 'content-type: application/json' \
  -X POST \
  --data $'{"context": { "eventId": "some-eventId", "timestamp": "some-timestamp", "eventType": "some-eventType", "resource": "some-resource"},"data": {"filename": "filename.txt", "value": "some-value"}}' \
  https://hello-r-HASH-uc.a.run.app

# Output
["Hello Event!"]
```
