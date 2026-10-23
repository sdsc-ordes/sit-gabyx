<p align="center">
  <img src="./docs/assets/logo.svg" alt="project logo" width="250">
</p>

<h1 align="center">
  sit-gabyx
</h1>
<p align="center">
</p>

[![Current Release](https://img.shields.io/github/release/swissdatasciencecenter/sit-gabyx.svg?label=release)](https://github.com/swissdatasciencecenter/sit-gabyx/releases/latest)
[![Pipeline Status](https://img.shields.io/github/actions/workflow/status/swissdatasciencecenter/sit-gabyx/normal.yaml?label=ci)](https://github.com/swissdatasciencecenter/sit-gabyx/actions/workflows/normal.yaml)
[![License label](https://img.shields.io/badge/License-Apache2.0-blue.svg?)](http://www.apache.org/licenses/LICENSE-2.0.html)

**Authors:**

- [sit-team sdsc](mailto:infrastructure-team@datascience.ch)

## Usage

```bash
nix run ".#messages"                 # Show all messages.
nix run ".#message-common"           # Show a single message.
nix run ".#gabyx-future"             # Show the default future.
```

Or with [`just`](https://github.com/casey/just):

```bash
just run                             # Show all messages.
just run message-common              # Show a single message.
just run gabyx-future                # Show the default future.
```

## Development

### Add a Message

Add your message to `src/messages/entries/<your-name>.parts.nix`. Pick a `style`
from [`src/messages/styles.parts.nix`](src/messages/styles.parts.nix) (`plain`,
`cowsay`, `rainbow`, `markdown`, `dragon`, `crab`) or add a new one. Custom
cow files live in [`src/messages/cows/`](src/messages/cows).

### Shaping the Future

`gabyx-future` is a flake-parts option. Set its attributes (see
[`src/gabyx-future/module.nix`](src/gabyx-future/module.nix)) in
[`src/gabyx-future/config.parts.nix`](src/gabyx-future/config.parts.nix).

## Acknowledgement

Acknowledge all contributors and external collaborators here.

## Copyright

Copyright © 2026-2028 Swiss Data Science Center (SDSC),
[www.datascience.ch](http://www.datascience.ch/). All rights reserved. The SDSC
is jointly established and legally represented by the École Polytechnique
Fédérale de Lausanne (EPFL) and the Eidgenössische Technische Hochschule Zürich
(ETH Zürich). This copyright encompasses all materials, software, documentation,
and other content created and developed by the SDSC.
