# LogSnag

Ruby Library for sending LogSnag events.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "logsnag"
```

## Usage

### Set Token

Firstly you'll need to set an API Token.

```ruby
@logsnag = LogSnag::Client.new(token: "")
```

### Sending an Event

```ruby
@logsnag.log(project: "my-project", channel: "channel", event: "my-event")
```

### Sending an Insight

```ruby
@logsnag.insight(project: "my-project", title: "Title of Insight", value: "the-value")
```

Available Options:

- description
- icon - Single emoji for the event icon
- notify - if this event should send a notification

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/deanpcmad/logsnag.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
