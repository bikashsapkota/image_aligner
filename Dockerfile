FROM public.ecr.aws/lambda/python:3.8 
LABEL problem="image aligner"

RUN yum upgrade -y
RUN yum install mesa-libGL -y


RUN pip install pip --upgrade
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
LABEL version="bet"
COPY handler.py .
COPY helper.py .
CMD ["handler.main"]