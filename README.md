# [mpd](https://galaxy.ansible.com/kso512/mpd/)

[![Ansible role quality](https://img.shields.io/ansible/quality/56402)](https://galaxy.ansible.com/kso512/mpd) [![Ansible role downloads](https://img.shields.io/ansible/role/d/56402)](https://galaxy.ansible.com/kso512/mpd) [![GitHub repo size](https://img.shields.io/github/repo-size/kso512/mpd)](https://github.com/kso512/mpd)

[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/kso512/mpd)](https://github.com/kso512/mpd) ![GitHub Release Date](https://img.shields.io/github/release-date/kso512/mpd) [![CI](https://github.com/kso512/mpd/actions/workflows/ci.yml/badge.svg)](https://github.com/kso512/mpd/actions/workflows/ci.yml) [![Release](https://github.com/kso512/mpd/actions/workflows/release.yml/badge.svg)](https://github.com/kso512/mpd/actions/workflows/release.yml) [![GitHub issues](https://img.shields.io/github/issues-raw/kso512/mpd)](https://github.com/kso512/mpd)

[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/) [![made-with-Markdown](https://img.shields.io/badge/Made%20with-Markdown-1f425f.svg)](http://commonmark.org) [![GitHub](https://img.shields.io/github/license/kso512/mpd)](https://www.gnu.org/licenses/gpl-2.0.txt)

An [Ansible](https://www.ansible.com/) [Role](http://docs.ansible.com/ansible/playbooks_roles.html#roles) to install the [Music Player Daemon](http://www.musicpd.org/) application from source instead of via a package manager.  Some package managers may not include features such as MP3 support, so compiling from the source code may help.

This is a complete rebuild of the [ansible-install-mpd](https://github.com/kso512/ansible-install-mpd) role I created and maintained for years, undertaken due to changes in CI/CD and naming conventions in Ansible Galaxy.

## Requirements

None yet defined.

## Role Variables

None yet defined.

## Dependencies

None yet defined.

## Example Playbook

Configure each MPD server:

    - hosts: servers
      roles:
        - { role: kso512.mpd }

## License

[GNU General Public License version 2](https://www.gnu.org/licenses/gpl-2.0.txt)

## Author Information

[@kso512](https://github.com/kso512)
