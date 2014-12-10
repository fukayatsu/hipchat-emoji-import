#!/usr/bin/python

import os
import requests
import shutil
from bs4 import BeautifulSoup
emoticons_page_url = 'https://www.hipchat.com/emoticons'

session = requests.Session()
response = session.get(emoticons_page_url)
html = response.text

soup = BeautifulSoup(html)
links = soup.find_all('img')

for div in soup.find_all('div', 'emoticon-block'):
  emoji = div.text.strip()[1:-1]
  url = div.img['src']
  filename = os.path.join('tmp', emoji + os.path.splitext(url)[1])
  print '%s: %s filename: %s' % (emoji, url, filename)
  response = session.get(url, stream=True)
  if response.status_code == 200:
    with open(filename, 'wb') as f:
      response.raw.decode_content = True
      shutil.copyfileobj(response.raw, f)
  else:
    print('%s: GET failed: %s' % (url, response.status))
