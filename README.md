#NEW YORK TIMES SEACH CLI

A Command Line Interface based search of the New York Times articles 
database using the NYT Search Articles API. Allows a user to search,
open, and favorite articles, as well as favorite the artcles saved
by other users.

Uses the `tty-prompt` gem to enhance the CLI interactivity, and includes
error handling for malformed dates, internet connection interruptions,
and invalid API queries.

Data provided by The New York Times https://developer.nytimes.com.

link to video ===

##Installation
1) Sign up for api at https://developer.nytimes.com/get-started
2) Create file called `.keys.rb` within config folder: `./config/.keys.rb`
3) In `.keys.rb`, save API key to `NYT_KEY = -insert-api-key-here`
4) From terminal run `bundle install`
5) From terminal run `rake db:migrate`
6) From terminal run `ruby bin/run.rb`

