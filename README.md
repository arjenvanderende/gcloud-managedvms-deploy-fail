Reproduction case for deployment failure on Google Managed VMs
==============================================================

To reproduce, please run:

```
npm install
gcloud preview app deploy app.yaml --project MY_PROJECT_ID --version SOME_VERSION --no-promote
```

This fails with the following error:

```
Copying files to Google Cloud Storage...
Synchronizing files to [gs://staging.MY_PROJECT_ID.appspot.com/].
Updating module [default]...failed.
ERROR: (gcloud.preview.app.deploy) Error Response: [400] Invalid character in filename: node_modules/istanbul/node_modules/fileset/tests/fixtures/an (odd) filename.js
Deleted [https://www.googleapis.com/compute/v1/projects/MY_PROJECT_ID/zones/us-central1-f/instances/gae-builder-vm-SOME_VERSION].
```

Removing `istanbul` locally and redeploying fixes the issue:

```
rm -r node_modules/istanbul
gcloud preview app deploy app.yaml --project MY_PROJECT_ID --version SOME_VERSION --no-promote
```

This means deployment fails because locally the `node_modules/istanbul` directory contains a file with a weird filename.
That's strange because the Node modules are not added to the Docker image. Why are these files synchronized to Google Cloud Storage?

Output of `gcloud version`:

```
Google Cloud SDK 0.9.85

app 2015.10.30
app-engine-java 1.9.28
app-engine-python 1.9.28
bq 2.0.18
bq-nix 2.0.18
core 2015.10.30
core-nix 2015.09.03
gcloud 2015.10.30
gsutil 4.15
gsutil-nix 4.14
kubectl
kubectl-darwin-x86_64 1.0.6
```

