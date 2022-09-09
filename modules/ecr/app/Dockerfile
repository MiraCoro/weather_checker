FROM public.ecr.aws/lambda/python:3.8

COPY main.py ${LAMBDA_TASK_ROOT}
COPY requirements.txt  .
COPY error.html ${LAMBDA_TASK_ROOT}
RUN  pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"
CMD [ "main.lambda_handler" ]