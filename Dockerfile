FROM ubuntu:latest

EXPOSE 8000

WORKDIR /app

COPY ./main .

CMD [ "./main" ]
