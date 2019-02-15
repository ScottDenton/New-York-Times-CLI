require 'bundler'
Bundler.require
require 'tty-prompt'
require 'bcrypt'
require_all 'app'


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil # suppress ActiveRecord SQL logging

PROMPT = TTY::Prompt.new
