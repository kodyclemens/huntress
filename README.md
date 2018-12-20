# Sinatra/Heroku Template

This branch is a clean Sinatra application, generated using Corneal, that is setup to be published to Heroku. SQLite will be the DB used for development and PostgreSQL will be used for production.

*If you want to generate a new Sinatra application using Corneal and configure it yourself to be deployed on Heroku, follow [Dakota's guide](https://github.com/DakotaLMartinez/sinatra-heroku-demo)*.

## Requirements

* **Mac OS X** local development environment installed with Git setup - [Guide here](http://help.learn.co/technical-support/local-environment/mac-osx-manual-environment-set-up)
* Recommend the latest version of Ruby (2.5.3 at time of this writing)
* Heroku requires at least Ruby 2.3.5 at the time of this writing

## Instructions

You will need a Heroku account, signup [here](https://signup.heroku.com/dc).

Strongly recommend using the latest version of Ruby. Use RVM to manage different versions.

**Remember, to run `learn` and do normal Flatiron labs, you must use 2.3.3 (at the time of this writing). Do not uninstall 2.3.3. We wll be using the latest version of Ruby for projects only, not cirriculum work.**

* [RVM installation guide](http://rvm.io/rvm/install)
* `rvm list` in terminal to see installed versions of Ruby.
* `rvm install 2.5.3` in terminal to install Ruby 2.5.3
* `rvm use 2.5.3` to switch and use the 2.5.3 interpreter

You can always switch back to Ruby 2.3.3 when needed: `rvm use 2.3.3`

You will need to have the Bundler gem and Heroku application installed. [Setup Brew](https://docs.brew.sh/Installation) if not already complete.

* `gem install bundler`
* `brew install heroku/brew/heroku`
* `heroku login` - This authentication is required for both the `heroku` and `git` commands to work correctly.

Recommend viewing [Heroku Getting Started guide](https://devcenter.heroku.com/articles/getting-started-with-ruby) if you have never used it.

### Setup a new Git repository for the app.
1. Delete the .git folder after forking
2. Run `git init` to set fresh Git files for the application
3. Create repository on Github, connect and push to master as you normally would

### Getting Started with Heroku

1. Set the version of Ruby you decided to use in your Gemfile (line 2).

2. `bundle install`

3. Run `heroku create` while in the base directory of the project. (Use `heroku create APP_NAME` instead to customize your Heroku application name)

4. At this point you need to setup at least one migration. A `Users` table is pretty common, so that may be a good one to begin with. It is up to you, but we need a schema to be generated.

5. Run migrations locally using Rake. Commit and push changes to Github

6. Run `git push heroku master` to push our current project to Heroku

7. Run `heroku open` to view your newly created application on Heroku

If everything went smoothly, you should be greeted by a fresh Sinatra application with the Corneal front-end style on Heroku. If not, you can use `heroku logs --tail` to see what went wrong.

### More Resources

[Dakota Martinez's Repo Guide](https://github.com/DakotaLMartinez/sinatra-heroku-demo)

[Dakota Martinez's Video](https://www.youtube.com/watch?v=UszqKE4pJKQ)

[Seth Alexander's Blog Post](https://itzsaga.github.io/post/day-051/)

[Heroku Getting Started Guide](https://devcenter.heroku.com/articles/getting-started-with-ruby)

[Flatiron Local Environment Setup](http://help.learn.co/technical-support/local-environment/mac-osx-manual-environment-set-up)
