# AWS

Module's hand out contains 
* _CloudFormation_ templates:
    * [pubsub_cf_template.yaml](pubsub_cf_template.yaml) creates resources for publisher running on AWS Lambda, subscriber running on AWS EC2, including S3 Bucket and SQS Queue
    * [emr_cf_template.yaml](emr_cf_template.yaml) creates EMR cluster(also contains example of EMR Steps commented out)
    * [glue_cf_template.yaml](glue_cf_template.yaml) creates AWS Glue Crawler which is supposed to create Athena tables over data stored by EMR Steps

* [run_flow.py](run_flow.py) which contains utility functions to simplify automation of flow deployment. This file needs to be "finished" to automate deployment of the entire flow

Feel free to adjust/delete any of aforementioned files. At the end, it would be preferable to run the full flow with a single command, e.g.
```
$ aws/run_flow.py <arguments>
```