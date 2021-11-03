#!/bin/bash

function install-sql-tools() {
    local distro="2019"
    local codename="developer";+

    while [ "$#" -gt 0 ]; do
        case $1 in
            -h|--help)
                show_usage;
                exit 1;;

            -d | --distro)
                distro=$2;
                shift 2;;

            -c | --codename)
                codename=$2;
                shift 2;;
        esac
    done

    if [ "$do_continue" != true ]; then
        echo "SQL Server Tools for Linux will not be installed." >&2
        exit 0
    fi

    echo "Installing mssql-tools"
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc | (OUT=$(apt-key add - 2>&1) || echo $OUT)
    DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
    CODENAME=$(lsb_release -cs)
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-${DISTRO}-${CODENAME}-prod ${CODENAME} main" > /etc/apt/sources.list.d/microsoft.list
    apt-get update
    ACCEPT_EULA=Y apt-get -y install unixodbc-dev msodbcsql17 libunwind8 mssql-tools

    echo "Installing sqlpackage"
    curl -sSL -o sqlpackage.zip "https://aka.ms/sqlpackage-linux"
    mkdir /opt/sqlpackage
    unzip sqlpackage.zip -d /opt/sqlpackage
    rm sqlpackage.zip
    chmod a+x /opt/sqlpackage/sqlpackage

}