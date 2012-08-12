imhere
======
save current location

* Ruby 1.8.7+ or 1.9.2+
* MongoDB2.0+


Clone
-----

    % git clone git://github.com/shokai/imhere.git
    % cd imhere


Install Dependencies
--------------------

    % gem install bundler foreman
    % bundle install --path vendor/bundle


Run
---

    % foreman start

=> http://localhost:5000


Deploy
------

Heroku Ruby <---> Heroku MongoDB

    % heroku create --stack cedar
    % heroku config:add TZ=Asia/Tokyo

enable addon MongoLab or MongoHQ

    % heroku addons:add mongolab:starter
    % heroku addons:add mongohq:free

deploy

    % git push heroku master
    % heroku open
    % heroku logs --tail


Console
-------

Local Ruby <---> Heroku MongoDB

    % heroku config --shell | ruby -lane 'puts "export "+$_'

 => export MONGOLAB_URI=mongodb://heroku1234@mongolab.com/herokuapp12345foo

    % ruby -Ku bin/console.rb
    > User.find_by_name :shokai
    > User.count
    > User.all(:limit => 20).map &:name


LICENSE
=======
(The MIT License)

Copyright (c) 2012 Sho Hashimoto

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

