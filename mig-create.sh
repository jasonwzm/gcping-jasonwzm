#!/bin/bash

REGION=$1
echo "Creating MIG for "$REGION
# create MIG with template
gcloud compute instance-groups managed create gcping-${REGION} --template gcping-regional-template --size 3 --region ${REGION}
# enable autoscaler on created MIG
gcloud compute instance-groups managed set-autoscaling gcping-${REGION} --target-cpu-utilization 0.6 --max-num-replicas 9 --min-num-replicas 3 --region ${REGION}
# create static external ip address
gcloud compute addresses create gcping-${REGION}-ip --region ${REGION}
# add http health check object
gcloud compute http-health-checks create gcping-${REGION}-hc
# create target pool in the same region as the MIG
gcloud compute target-pools create gcping-${REGION}-tp --region ${REGION} --http-health-check gcping-${REGION}-hc
# add instance group to target pool
gcloud compute instance-groups managed set-target-pools gcping-${REGION} --target-pools gcping-${REGION}-tp --region ${REGION}
# add forwarding rule serving on an external IP 
gcloud compute forwarding-rules create gcping-${REGION}-forwarding --region ${REGION} --ports 80 --address gcping-${REGION}-ip --target-pool gcping-${REGION}-tp
