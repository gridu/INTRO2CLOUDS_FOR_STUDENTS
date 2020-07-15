from google.cloud import pubsub
import subprocess


def list_topics(credentials, project_id):
    publisher_client = pubsub.PublisherClient(credentials=credentials)
    project_path = publisher_client.project_path(project_id)
    for topic in publisher_client.list_topics(project_path):
        print(topic.name)


def create_topic(credentials, project_id, topic_name):
    publisher_client = pubsub.PublisherClient(credentials=credentials)
    topic_path = publisher_client.topic_path(project_id, topic_name)
    topic = publisher_client.create_topic(topic_path)
    return topic.name

