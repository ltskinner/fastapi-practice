FROM python:3.9

RUN apt-get update
RUN apt-get -y install make

RUN mkdir /home/faj2

COPY ./ /home/faj2

WORKDIR /home/faj2

RUN make install

ENTRYPOINT [ "python" ]

CMD [ "wsgi.py" ]
