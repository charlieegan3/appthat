# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Channel.delete_all
Channel.create(title: 'Social', tags: %w(feed timeline people subtweets muted blocked fb ig twitter snapchat stories tweets social instagram post tinder messages follow blocks friends tweet facebook insta unfollow posts facetime contacts relationship share friend talking sender unfollows block))
Channel.create(title: 'Media', tags: %w(pictures photos movie collage music media videos song ig instagram picture songs photo listen video pic library snap shazam listening sound tv pics tune netflix stream gifs youtube selfies cinema spoilers))
Channel.create(title: 'Geo', tags: %w(nearest public locate uber local driving drive walk places area miles directions roads road locations location weather nearby delivers))
Channel.create(title: 'Food', tags: %w(chocolate chipotle food pizza bed meal coffee restaurants sandwich oven snacks bar))
Channel.create(title: 'Messaging', tags: %w(text texting sends texts unsend chat emails message reply email))
Channel.create(title: 'Money & Shopping', tags: %w(store job pay money grocery cash jobs rent shopping buy))
Channel.create(title: 'Internet & Data', tags: %w(upload data browsers browser online download downloaded downloading wifi data))
Channel.create(title: 'Tech', tags: %w(technology tablet laptop screen tech))
Channel.create(title: 'Mobile', tags: %w(android iphone ios mobile phone phones))
Channel.create(title: 'Intelligent Tool', tags: %w(rates guess find tracks caches scans calculate edits build rate answer search suggestions learn track))
Channel.create(title: 'Health & Fitness', tags: %w(gym health fitness workout fit healthy))
Channel.create(title: 'Clothes', tags: %w(wear wardrobe clothes outfits wearing))
Channel.create(title: 'Reading', tags: %w(read articles write blog))
Channel.create(title: 'Sleep', tags: %w(alarm sleeping woke sleep bed))
Channel.create(title: 'Notifications', tags: %w(notifies notify alerts alert reminder remind))
Channel.create(title: 'Productivity', tags: %w(productive productivity alarms alarm todo organize))
Channel.create(title: 'Language & Translation', tags: %w(translates translate language))
Channel.create(title: 'Sport', tags: %w(baseball football soccer tennis))
Channel.create(title: 'Thinking & Thoughts', tags: %w(mood thoughts decisions meditate thinking think emotions))
Channel.create(title: 'Family', tags: %w(kids baby family children))
Channel.create(title: 'Games', tags: %w(player play callofduty))
