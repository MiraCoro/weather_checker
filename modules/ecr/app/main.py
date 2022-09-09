import boto3
import json5
import requests
from tabulate import tabulate

def lambda_handler(event, context):
    url = "https://api.openweathermap.org/data/2.5/weather?q=Prague,cz&appid=31e68dc105a8404f0b7154ce4fa6d226"
    response = requests.get(url)
    bucket_name = "weather-checker-dev-v1-2022"
    file = "/tmp/current_weather.json"
    
    open(file, "wb").write(response.content)
    s3 = boto3.resource("s3")
    s3.Bucket(bucket_name).upload_file(file, "current_weather.json")
    
    with open(file, "rb") as json_file:
        json_load = json5.load(json_file)
    
    table = [{"City:": "Prague", "Weather": json_load["weather"][0]["main"], "Temperature": json_load["main"]["temp"], "Feels like": json_load["main"]["feels_like"], "Min temperature": json_load["main"]["temp_min"], \
        "Max temperature": json_load["main"]["temp_max"], "Pressure": json_load["main"]["pressure"], "Humidity": json_load["main"]["humidity"], "Visibility": json_load["visibility"],\
            "Wind speed": json_load["wind"]["speed"], "Clouds": json_load["clouds"]["all"]}]
    with open("/tmp/index.html", "w") as html:
        html.write("<!DOCTYPE html><html lang=\"en\" dir=\"ltr\"> <head><meta charset=\"utf-8\"><title>Weather Checker</title></head><body>")
        html.write(tabulate(table, headers="keys", tablefmt="html"))
        html.write("</body></html>")
    s3.Bucket(bucket_name).upload_file("/tmp/index.html", "index.html", ExtraArgs={"ContentType": "text/html"})
    s3.Bucket(bucket_name).upload_file("/var/task/error.html", "error.html", ExtraArgs={"ContentType": "text/html"})