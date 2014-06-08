Redmine Issue Post
=========

TrelloPost is greatly inspired on [IssuePost][1] for [github][2]. In this case, it is aimed at the [Trello][3] and allow a user to quickly enter new cards into their boards without requiring them to open their browser, navigate to trello and fill out all the fields.

![Screenshot](screenshot.png?raw=true)

Motivation
----------

This was developed because I really liked [IssuePost][1] but I was using Trello for bug tracking.


Features
--------

* Easy to install
* Quick card creation into Trello
* Available on Linux, Mac OS X and Windows

Requirements
------------

This assumes you have [NPM][8] installed. If not, you can go to http://nodejs.org/ or http://nodejs.org/download/ and download/execute the required installer.

Install steps
-------------

* Run `npm install`
* Go to [Developer API Keys][9] to generate your key
* Replace the YOUR_KEY placeholder in index.html with the generated key

Usage
-----

* Run `npm start` to execute/start TrelloPost
* TrelloPost is good to go!

Supported platforms
-------------------

As this is an application based on [node-webkit][5], it should work on Linux, Mac and Windows.

External dependencies
---------------------

TrelloPost is currently based off various softwares which are either already included when you download TrelloPost or when your run the install steps.

At runtime, the following are used:

* [node-webkit][5]
* [jQuery][6]
* [Bootstrap][7]
* [Coffeescript][10]

The following tools are quite important to our development process:

* [NPM][8]

(For a complete list of dependencies, see package.json)

License
-------

The code is licensed under the [MIT license][4]. Please, see the LICENSE file.

  [1]: http://issuepostapp.com
  [2]: http://www.github.com
  [3]: http://www.redmine.org
  [4]: http://opensource.org/licenses/MIT
  [5]: https://github.com/rogerwang/node-webkit
  [6]: http://jquery.com
  [7]: http://getbootstrap.com
  [8]: https://npmjs.org
  [9]: https://trello.com/1/appKey/generate
  [10]: http://coffeescript.org/
