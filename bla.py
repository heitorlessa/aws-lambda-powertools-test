from aws_lambda_powertools.utilities.batch import BatchProcessor, EventType, batch_processor
from aws_lambda_powertools.utilities.parser.models import SqsS3EventNotificationRecordModel, SqsS3EventNotificationModel, S3Model


processor = BatchProcessor(event_type=EventType.SQS, model=SqsS3EventNotificationRecordModel)


def record_handler(record: SqsS3EventNotificationRecordModel):
    # print(record)


@batch_processor(record_handler=record_handler, processor=processor)
def lambda_handler(event, context):
    return processor.response()
