require 'bundler'
Bundler.require

require 'launchy'
require 'tty-prompt'
require 'bcrypt'
require 'nokogiri'
require 'httparty'
require 'pry'

require_all 'app'
PROMPT = TTY::Prompt.new


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil # suppress ActiveRecord SQL logging

