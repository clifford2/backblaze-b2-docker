# Backblaze B2 CLI container image

## About

This code builds a Backblaze B2 [CLI](https://www.backblaze.com/b2/docs/quick_command_line.html) container image.

Version information:

- B2 CLI version: 4.4.1
- Container build version: 1

Based on <https://github.com/tianon/dockerfiles/tree/master/backblaze-b2>, with these changes:

- Updated b2 version (based on releases at <https://github.com/Backblaze/B2_Command_Line_Tool>)
- Added entrypoint

## How To Use

Use my image:

```sh
B2CONFDIR=${XDG_CONFIG_HOME:-$HOME/.config}/b2-cli
test -d $B2CONFDIR || mkdir -p $B2CONFDIR
podman run --rm -it -v $B2CONFDIR:/home/b2:z -v $PWD:/data:z -w /data ghcr.io/clifford2/backblaze-b2:4.4.1-1 account authorize
podman run --rm -it -v $B2CONFDIR:/home/b2:z -v $PWD:/data:z -w /data ghcr.io/clifford2/backblaze-b2:4.4.1-1 bucket list
podman run --rm -it -v $B2CONFDIR:/home/b2:z -v $PWD:/data:z -w /data ghcr.io/clifford2/backblaze-b2:4.4.1-1 <command>
```

Build your own copy with:

```sh
podman build --pull -t backblaze-b2:4.4.1-1 .
```

## License & Disclaimer

This is free and unencumbered software released into the public domain

It is provided *AS IS*, without warranty of any kind.

See [`LICENSES/Unlicense.txt`](LICENSES/Unlicense.txt) for the full license text and disclaimer.

## Security

This code is updated as often as possible, but support is provided on a best effort basis only.

Please report any problems or vulnerabilities by opening a [GitHub issue here](https://github.com/clifford2/backblaze-b2-docker/issues).
