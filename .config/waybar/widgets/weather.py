#!/usr/bin/env python
# Based on <https://gist.github.com/bjesus/f8db49e1434433f78e5200dc403d58a3>
# Note that the location info used with this is fetched from ~/.waybar_weather_location by default

import json
import requests
from datetime import datetime
import os.path
from urllib.parse import quote_plus

WEATHER_CODES = {
    '113': '☀️',
    '116': '⛅️',
    '119': '☁️',
    '122': '☁️',
    '143': '🌫',
    '176': '🌦',
    '179': '🌧',
    '182': '🌧',
    '185': '🌧',
    '200': '⛈',
    '227': '🌨',
    '230': '❄️',
    '248': '🌫',
    '260': '🌫',
    '263': '🌦',
    '266': '🌦',
    '281': '🌧',
    '284': '🌧',
    '293': '🌦',
    '296': '🌦',
    '299': '🌧',
    '302': '🌧',
    '305': '🌧',
    '308': '🌧',
    '311': '🌧',
    '314': '🌧',
    '317': '🌧',
    '320': '🌨',
    '323': '🌨',
    '326': '🌨',
    '329': '❄️',
    '332': '❄️',
    '335': '❄️',
    '338': '❄️',
    '350': '🌧',
    '353': '🌦',
    '356': '🌧',
    '359': '🌧',
    '362': '🌧',
    '365': '🌧',
    '368': '🌨',
    '371': '❄️',
    '374': '🌧',
    '377': '🌧',
    '386': '⛈',
    '389': '🌩',
    '392': '⛈',
    '395': '❄️'
}

data = {}

location = ""

try:
    with open(os.path.expanduser("~/.waybar_weather_location")) as f:
        location = f.read().replace("\n", "").replace(",", "")
except:
    location = ""

weather = requests.get("https://wttr.in/" + quote_plus(location) + "?format=j1").json()


def format_time(time):
    return time.replace("00", "").zfill(2)


def format_temp(temp):
    return (hour['FeelsLikeC']+"°").ljust(3)


def format_chances(hour):
    chances = {
        "chanceoffog": "Fog",
        "chanceoffrost": "Frost",
        "chanceofovercast": "Overcast",
        "chanceofrain": "Rain",
        "chanceofsnow": "Snow",
        "chanceofsunshine": "Sunshine",
        "chanceofthunder": "Thunder",
        "chanceofwindy": "Wind"
    }

    conditions = []
    for event in chances.keys():
        if int(hour[event]) > 0:
            conditions.append(chances[event]+" "+hour[event]+"%")
    return ", ".join(conditions)


data['text'] = WEATHER_CODES[weather['current_condition'][0]['weatherCode']] + \
    " "+weather['current_condition'][0]['temp_C']+"°"


data['tooltip'] = (
    f"Location:<span color='#92c1ff' size='10pt'> {weather['nearest_area'][0]['areaName'][0]['value']}, {weather['nearest_area'][0]['country'][0]['value']}</span>\n"
    f"Date:<span color='#92c1ff' size='10pt'> {datetime.now().strftime('%Y-%m-%d %I:%M %p')}</span>\n"
    f"\n<span color='#92c1ff' size='10pt'>    <u>Current Conditions</u></span>\n"
    f"Feels Like:<span color='#92c1ff' size='10pt'> {weather['current_condition'][0]['FeelsLikeC']}°</span>\n"
    f"Humidity:<span color='#92c1ff' size='10pt'> {weather['current_condition'][0]['humidity']}%</span>\n"
    f"Wind:<span color='#92c1ff' size='10pt'> {weather['current_condition'][0]['windspeedKmph']}Km/h</span>\n"
    f"Rain:<span color='#92c1ff' size='10pt'> {weather['current_condition'][0]['precipMM']}mm</span>\n"
    f"Last Rain:<span color='#92c1ff' size='10pt'> {weather['current_condition'][0]['observation_time']}</span>\n"
    f"Rain Totals:<span color='#92c1ff' size='10pt'> {weather['current_condition'][0]['precipMM']}mm</span>\n"
)

print(json.dumps(data))
