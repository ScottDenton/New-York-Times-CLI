#NEW YORK TIMES SEACH CLI

A Command Line Interface based search of the New York Times articles
database using the NYT Search Articles API.

Allows a user to search,
open, and favorite articles, as well as favorite artcles saved
by other users.

Uses the [`tty-prompt`](https://github.com/piotrmurach/tty-prompt) gem to enhance CLI interactivity, and includes
error handling for malformed dates, internet connection interruptions,
and invalid API queries.

Data provided by [**_The New York Times_**](https://developer.nytimes.com).

[![New York times logo](./lib/poweredby_nytimes_200b.png)](https://developer.nytimes.com)

Instructional video: https://vimeo.com/317361060

##Installation and set up instructions
1) Sign up for a NYT's api key at https://developer.nytimes.com/get-started
2) Create a file called `.keys.rb` within the config folder.
Your file structure should look as follows: `config/.keys.rb`
3) In `.keys.rb`, save your new API key to a constant `NYT_KEY`
i.e. `NYT_KEY = -insert-api-key-here-`
4) From terminal run:
- `bundle install`
- `rake db:migrate`
- `ruby bin/run.rb`

Created by [Ezra Schwepker](https://github.com/MoreSaltMoreLemon)  and [Scott Denton](https://github.com/ScottDenton)
