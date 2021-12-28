FROM public.ecr.aws/lambda/python:3.8
LABEL problem="image aligner"

RUN yum upgrade -y
RUN yum install mesa-libGL -y
RUN pip install pip --upgrade
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum -y update
# RUN pip install boto3
RUN yum -y install tesseract
COPY osd.traineddata /usr/share/tesseract/tessdata/osd.traineddata
LABEL version="be"
COPY handler.py .
COPY helper.py .
COPY ct2.png .
# RUN python handler.py ct2.png
CMD ["handler.main"]

