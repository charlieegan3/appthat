#!/usr/bin/env python2

from os import path
from wordcloud import WordCloud
import matplotlib.pyplot as plt

d = path.dirname(__file__)
text = open(path.join(d, 'thing.txt')).read()

wordcloud = WordCloud(
              max_font_size=120,
              min_font_size=20,
              relative_scaling=0.3,
              width=1000,
              height=1000,
              stopwords=["an", "app", "to", "that", "need", "the", "you", "there", "was", "for", "wish", "me", "my", "a", "and", "needs", "of", "on", "in", "be", "I", "make", "want", "is", "when", "all", "can", "tells", "it"]
            ).generate(text)
plt.figure()
plt.imshow(wordcloud)
plt.axis("off")
plt.show()

