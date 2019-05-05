# Roupio

Roupio is a open source nonprofit organization oriented ERP. It aims to be easily modifiable by adding multiple modules. It ships his own HTML/CSS framework.

## Installation

Roupio comes with a management script. From it, you can easily build and run your Roupio instance.

To build and run it as a production instance :

`./manager.sh prod` or `./manager.sh build` if you just want to build the server.

To build it as a development instance :

`./manager.sh dvpt`

To generate the documentation :

`./manager.sh docs`

Make sure to install all needed dependencies for the crystal langage. Before any compilation, run

`./manager.sh deps`

to find any incomplete dependencies. The tool won't install it. Check https://crystal-lang.org/reference/installation/ to find any help.

*Don't forget that's Roupio is in his early state of dvpt.*

## Contributing

1. Fork it (<https://github.com/vinhig/Roupio/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [vinhig](https://github.com/vinhig) - creator and maintainer
