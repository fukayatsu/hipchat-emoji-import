hipchat-emoji-import
====================

Batch uploading of hipchat emotions.

> You may only have 50 custom emoticons at one time. Please delete an existing emoticon before uploading a new one.

# usage

```
$ git clone git@github.com:fukayatsu/hipchat-emoji-import.git
$ cd hipchat-emoji-import
$ bundle install
$ cp settings.yml.sample settings.yml
$ cp path/to/emoji/*.png emojis/
$ vim settings.yml
$ ./resize.rb
$ ./import.rb
```

# see also
- [arvida/emoji-cheat-sheet.com · GitHub](https://github.com/arvida/emoji-cheat-sheet.com)
