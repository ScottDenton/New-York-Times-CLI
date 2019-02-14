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

##Usage

Watch this [video](https://vimeo.com/317361060) for an brief run down on how to use the NYT CLI.


##Credits
Created by [Ezra Schwepker](https://github.com/MoreSaltMoreLemon)  and [Scott Denton](https://github.com/ScottDenton).


##License
MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
