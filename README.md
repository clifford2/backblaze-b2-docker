# Backblaze B2 CLI container image

## About

This code builds a Backblaze B2 [CLI](https://www.backblaze.com/b2/docs/quick_command_line.html) container image.

Version information:

- B2 CLI version: 4.2.0
- Container build version: 1

Based on <https://github.com/tianon/dockerfiles/tree/master/backblaze-b2>, with these changes:

- Updated b2 version (based on releases at <https://github.com/Backblaze/B2_Command_Line_Tool>)
- Added entrypoint

## How To Use

Build with:

```sh
podman build --pull -t docker.io/cliffordw/backblaze-b2:4.2.0-1 .
```

Usage:

```sh
CONFDIR=$HOME/b2config
test -d $CONFDIR || mkdir -p $CONFDIR
podman run --rm -it -v $CONFDIR:/home/b2:z -v $PWD:/data:z -w /data docker.io/cliffordw/backblaze-b2:4.2.0-1 account authorize
podman run --rm -it -v $CONFDIR:/home/b2:z -v $PWD:/data:z -w /data docker.io/cliffordw/backblaze-b2:4.2.0-1 <command>
```

## License & Disclaimer

This code is shared under the BSD 2-Clause "Simplified" License.
It is provided *AS IS*, without warranty of any kind.
See [`LICENSES/BSD-2-Clause.txt`](LICENSES/BSD-2-Clause.txt) for the full license text and disclaimer.

## Security

This code is updated as often as possible, but support is provided on a best effort basis only.

Please report any problems or vulnerabilities by opening a [GitHub issue here](https://github.com/clifford2/backblaze-b2-docker/issues).
