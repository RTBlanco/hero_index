# Hero Index

This Ruby gem is a CLI that allows the user to be able to see information about their favorite heros 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hero_index'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hero_index

## Usage
After proper installation of the gem, simply run:
    
    $ hero-index

This will prompt you to choose to either search with and `ID` or a `Name`:

    Search Hero by Name or hero ID?

Once you have entered a hero this will prompt a menu with choices that lead to further information about the chosen hero

    Search Hero by Name or hero ID?
    $ name

    Looking with name!
    Please enter the name.
    $ robin

    Found Red Robin!
    What would you like know about Red Robin
        (1) Main Information
        (2) Physical Traits
        (3) Power Levels
        (4) Who Is Stonger (pits current hero verser another)

        -------------------------------------------------------
        (back) To go back
        (quit) To quit program
    $ 1

- Once you have made a selection and would like to make another you simply enter its corresponding number
- You can close the CLI anytime by inputing `quit`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hero_index. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/hero_index/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HeroIndex project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/hero_index/blob/master/CODE_OF_CONDUCT.md).
