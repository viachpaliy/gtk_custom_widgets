# gtk_custom_widgets

The "gtk_custom_widgets" is a collection of helper functions and custom controls for Crystal.

### Controls

 - [SevenSegmentDisplay](doc/Controls/SevenSegmentDisplay.md)
 - [SlopSevSegDisplay](doc/Controls/SlopSevSegDisplay.md)
 - [EightSegmentDisplay](doc/Controls/EightSegmentDisplay.md)
 - [DigitalDisplay](doc/Controls/DigitalDisplay.md)
 - [TimerColon](doc/Controls/TimerColon.md)
 - [DigitalClockDisplay](doc/Controls/DigitalClockDisplay.md)
 - [AnalogClockDisplay](doc/Controls/AnalogClockDisplay.md) 
 - [NixieTube](doc/Controls/NixieTube.md)
 

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     gtk_custom_widgets:
       github: viachpaliy/gtk_custom_widgets
   ```

2. Run `shards install`

Note : this shard use "gobject"(https://github.com/jhass/crystal-gobject) and "cairo-gobject"((https://github.com/viachpaliy/cairo-gobject) shards.
 If you use Ubuntu18.04 based distributives uncomment *Rectangle* structure in *lib/cairo-gobject/src/lib_cairo.cr* file (lines 7...12). 



## Usage

```crystal
require "gtk_custom_widgets/gtk_custom_widgets"
```

## Samples

Run sample :
```shell
  cd gtk_custom_widgets
  crystal run samples/sample_name.cr
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/viachpaliy/gtk_custom_widgets/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [viachpaliy](https://github.com/your-github-user) - creator and maintainer
