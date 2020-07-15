from google.cloud import dataproc_v1 as dataproc
from googleapiclient import discovery


def create_cluster(credentials, project_id, location, cluster_name):
    """This sample walks a user through creating a Cloud Dataproc cluster
       using the Python client library.

       Args:
           project_id (string): Project to use for creating resources.
           region (string): Region where the resources should live.
           cluster_name (string): Name to use for creating a cluster.
    """

    # Create a client with the endpoint set to the desired cluster region.
    cluster_client = dataproc.ClusterControllerClient(credentials=credentials, client_options={
        'api_endpoint': '{}-dataproc.googleapis.com:443'.format(location)
    })

    # Create the cluster config.
    cluster = {
        'project_id': project_id,
        'cluster_name': cluster_name,
        'config': {
            'master_config': {
                'num_instances': 1,
                'machine_type_uri': 'n1-standard-1',
                # "diskConfig":
                #     {
                #         "bootDiskSizeGb": 100
                #     }
            }
        }
    }

    # Create the cluster.
    operation = cluster_client.create_cluster(project_id, location, cluster)
    result = operation.result()

    # Output a success message.
    print('Cluster created successfully: {}'.format(result.cluster_name))


def submit_job(credentials, project_id, location, cluster_id, job_jar):
    # http://googleapis.github.io/google-api-python-client/docs/dyn/dataproc_v1.projects.regions.jobs.html#submit

    service = discovery.build('dataproc', 'v1', credentials=credentials, cache_discovery=False)
    data_proc_jobs = service.projects().regions().jobs()

    response = data_proc_jobs.submit(projectId=project_id, region=location, body=
    {
        "job": {
            "placement": {
                "clusterName": cluster_id
            },
            "sparkJob": {
                "args": [

                ],
                "jarFileUris": [
                    job_jar
                ],
                "mainJarFileUri": job_jar,
            },
        },
    }).execute()
    job_id = response.get("jobUuid")
    print("job id {0} status {1}".format(job_id, response.get("status").get("state")))
    return job_id

