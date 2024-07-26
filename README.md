# Very Simple Single User Daemon (vssud)

`vssud` is a shell script designed to manage and ensure the continuous operation of multiple shell scripts located in a specified directory. If any of the managed scripts terminate, this script will automatically restart them.

## Features

- Automatically starts all `.sh` scripts located in the `./service` directory.
- Monitors running scripts and restarts them if they terminate.
- Cleans up and terminates all running scripts on receiving `SIGINT` (Ctrl-C) or `SIGTERM` signals.

## Requirements

- Bash

## Installation

1. Clone this repository:
    ```sh
    git clone https://github.com/jjjttwkr123/vssud.git
    cd vssud
    ```

2. Make sure your shell scripts are located in the `./service` directory and are executable:
    ```sh
    mkdir -p service
    echo -e '#!/bin/bash\necho "Script 1 running"\nsleep 10' > service/script1.sh
    echo -e '#!/bin/bash\necho "Script 2 running"\nsleep 15' > service/script2.sh
    chmod +x service/*.sh
    ```

## Usage

1. Run the `init.sh` script to start and manage all scripts in the `./service` directory:
    ```Bash
    ./init.sh
    ```
