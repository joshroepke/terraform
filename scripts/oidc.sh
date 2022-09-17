#!/bin/bash 

aws iam list-open-id-connect-providers
aws iam create-open-id-connect-provider
aws iam update-open-id-connect-provider-thumbprint
aws iam tag-open-id-connect-provider
aws iam list-open-id-connect-provider-tags
aws iam untag-open-id-connect-provider

