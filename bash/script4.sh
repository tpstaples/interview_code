import boto3
queue_url = "https://sqs.us-east-1.amazonaws.com/xxxxxxx/example"

sqs_client = boto3.client('sqs')
messages = []

while True:
    resp = sqs_client.receive_message(
        QueueUrl=queue_url,
        AttributeNames=['All'],
        MaxNumberOfMessages=10
    )
    try:
        messages.extend(resp['Messages'])
    except KeyError:
        break
    print(resp)
    print(resp['Messages'])
    entries = [
        {'Id': msg['MessageId'], 'ReceiptHandle': msg['ReceiptHandle']}
        for msg in resp['Messages']
    ]

    resp = sqs_client.delete_message_batch(
        QueueUrl=queue_url, Entries=entries
    )
    if len(resp['Successful']) != len(entries):
        raise RuntimeError(
            f"Failed to delete messages: entries={entries!r} resp={resp!r}"
        )

