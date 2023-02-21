FROM python:alpine3.7
WORKDIR /app
COPY main.py /app
COPY requirements.txt /app
RUN pip install -r requirements.txt
EXPOSE 5000
ENTRYPOINT [ "python" ]
CMD [ "main.py" ]
