Strano
======

The Github and Git backed mostly deployment management UI.

Strano allows you to run any task via a clean and simple web interface.
Simply create a project from any of your Github or Git repositories, and Strano will use
repository as working directory to run any task you want (but we only use it for Capistrano).
Which means you don't have to set up Capistrano twice, and you can still run
capistrano tasks from the command line without fear of different configurations
being used, causing conflicted deploys.

All tasks are recorded, so you can look back and see a full history of who did
what and when.

Strano is in production use at KupiKupon and other Express42 clients, but is
still in active development.  So I need your help to improve and ensure the code
is top quality. So I encourage any and all pull requests. Fork away!

Installation
------------

Strano is simply a Rails app with a DB backend for processing background jobs.
Clone the repo from [Github](https://github.com/express42/strano) and run:

    script/bootstrap

Then start the app:

    bundle exec rails s

**NOTE** Strano cannot be run on Heroku, as the project repositories have to cloned
to a local directory in your app at `vendors/repos`.


Configuration
-------------

Strano requires that you define only three configuration variables. The rest are
optional, but can be overridden. You can either create a config/strano.yml
configuration file and define them in there, or you can define them in the `ENV`
variable. See `config/strano.example.yml` for all possible configuration variables.

The following are required and should be defined before running Strano.

- Github Key and Secret

  Create a [Github application](https://github.com/settings/applications) and copy
  the generated key and secret to: `github_key` and `github_secret`.

- Public SSH key

  In order to clone repositories from Github, it requires a public SSH key be
  defined in `public_ssh_key`. Or strano process running user should have access
  to Github (or Git) repo. Also user running strano process should have SSH
  access to the machines, is you want it to run Capistrano tasks.


Background Processing
---------------------

Background processing of tasks and repo management is taken care of by the excellent rake task. Run
the queue like this:

    bundle exec rake bg:worker

License
-------

Strano is released under the MIT license:

* http://www.opensource.org/licenses/MIT


Contributing
------------

Read the [Contributing][cb] wiki page first.

Once you've made your great commits:

1. [Fork][1] Strano
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Create a [Pull Request](http://help.github.com/pull-requests/) from your branch
5. That's it!
