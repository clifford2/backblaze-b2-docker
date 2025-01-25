#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2021 Clifford Weinmann <https://www.cliffordweinmann.com/>
#
# SPDX-License-Identifier: Unlicense

# Update version number in Dockerfile

set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"

current=$(awk '/^ENV BACKBLAZE_B2_VERSION/ {print $3}' Dockerfile)
latest=$(curl -fsSL 'https://pypi.org/pypi/b2/json' | jq -r .info.version)

echo $current $latest

if [ "$latest" == "$current" ]
then
	echo "Version unchanged ($current)"
else
	echo "New version available - upgrading from $current to $latest"
	set -x
	sed -ri 's/^(ENV BACKBLAZE_B2_VERSION) .*/\1 '"$latest"'/' Dockerfile
	sed -i -e "s|cliffordw/backblaze-b2:[^ ]*|cliffordw/backblaze-b2:${latest}-1|" README.md
fi
