# ng-matrix-component

A matrix grid with dynamic domain and range.

## Quick Start

### Installation

To develop within this project you need NodeJS, which comes with the npm pacakge manager, and [Grunt](http://gruntjs.com).
If you do not have NodeJS installed there are a variety of ways to install it, I recommend using nvm (Node Version Manager).

** find instructions for install NVM **

Once you have NodeJS install you will need to install the grunt command line tool and then install NPM dependencies

```sh
$ npm install -g grunt-cli
$ npm install
```

Next you can initialize the project by running the default task

```sh
$ grunt
```

This will execute bower to download all your client side run-time dependencies,
then download a copy of selenium standalone server and chrome webdriver (to be used for e2e tests).
Finally the sample code will be compiled, packaged and unit tests executed to assure everything is where it should be.

You can remove the sample code, customize the project layout using the value assignments in config/build.config.js.

if you want to see the list of grunt commands available run the following command:

```sh
$ grunt --help
```

# Using Grunt

To develop within this project you need [Grunt](http://gruntjs.com), the following Tasks are available:

```sh
$ grunt
$ grunt <target>
```

replace **target** with one or more of the following:

| target alias     | alias expanded|
|------------------|---------------|
|**dev**           |[reset build karma:unit karma:unit:run karma:midway karma:midway:run watch] builds the app, starts the test servers and starts the watch process to wait for changes|
|**dev_server**    |[express:livereload express-keepalive open]starts an express livereload server to view changes to the app as they happen.|
|**e2e_mocha**     |[express:e2e simplemocha] run all e2e tests using mocha (only tests under the e2e test folder named \*.mocha.spec.[js\|coffee]) |
|**e2e_server**    |[shell:start_selenium] start the selenium webdriver server|
|**test**          |[reset karma:ci_unit karma:ci_midway] clear all previous running servers, start test server, run unit + midway tests |
|**build**         |[clean html2js jshint coffeelint coffee recess:build copy index]|
|**compile**       |[compile:debug recess copy ngmin concat uglify index]|
|**compile:debug** |[compile recess copy ngmin concat uglify index]|
|**release**       |[changelog]|
