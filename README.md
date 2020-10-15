# xkcdC: A xkcd client

xkcdC is a command line client for the [xkcd](https://xkcd.com) webcomic.

Right now, there are four command line flags for xkcdC:


| Flag | Action |
| ---- | ------ |
| --verbose | Enable verbosity |
| --export-json | Export the xkcd data as JSON |
| --no-image | Disable image |
| --force-image | Try to disp image even if not supported (WIP) |

## Compiling and installing:

### Microsoft Windows is not supported officially and has not been tested
To compile this, use `dmd build`.

You'll need (On Arch Linux)

- `dmd`
- `dub`

`sudo pacman -S dmd dub`

If you're not on Arch, glance at D's page about [compilers](https://dlang.org/download.html).

Once you've compiled it, call it with `./xkcdc` on Linux.

To install, either do one of these three things:

- Copy it to `/usr/local/bin`: `sudo cp ./xkcdc /usr/local/bin`
- Copy it to `~/.local/bin`: `cp ./xkcdc ~/.local/bin` (Must be on `$PATH`)
- Copy it to any other directory on your `$PATH`

## Usage

To use it, invoke `xkcdc`

You can (optionally) supply a comic number.


