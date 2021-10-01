# mpd

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
