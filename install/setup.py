#!/usr/bin/env python3

import argparse
import os
import re
import subprocess

wlan_config_template = """iface {wlan_ssid} inet dhcp
   wpa-ssid {wlan_ssid}
   wpa-psk {wlan_psk}
"""

ros_config_template = """ROS_MASTER_URI=http://localhost:11311
ROS_HOSTNAME={hostname}
HOSTNAME={hostname}
"""

_NO_BACKUP = ['./etc/network/interfaces.d']


def main(target='/', name='thymioXX', wlans=[], **kwargs):

    hostname = name
    ssid = name.capitalize()

    print('Fill configuration files and copy them to {target}'.format(
        target=target))

    for folder, _, files in os.walk('./etc'):
        for path in files:
            with open(os.path.join(folder, path)) as f:
                config = f.read().format(**locals(), **kwargs)
            target_path = os.path.join(target, folder, path)
            target_path_backup = target_path + '.orig'
            if(folder not in _NO_BACKUP and os.path.exists(target_path) and
               not os.path.exists(target_path_backup)):
                print(
                    '\t- {target_path} -> {target_path_backup}'.format(**locals()))
                os.rename(target_path, target_path_backup)
            os.makedirs(os.path.dirname(target_path), exist_ok=True)
            with open(target_path, 'w') as f:
                print('\t- Write {target_path}'.format(**locals()))
                f.write(config)

    print('Add wireless access points to {target}'.format(target=target))

    for wlan_ssid, wlan_password in wlans:
        r = subprocess.run(['/usr/bin/wpa_passphrase', str.encode(wlan_ssid)],
                           input=str.encode(wlan_password),
                           stdout=subprocess.PIPE)
        wlan_psk = re.search('psk=(\S*)', r.stdout.decode()).group(1)
        wlan_config = wlan_config_template.format(**locals(), **kwargs)
        path = os.path.join(target, 'etc', 'network',
                            'interfaces.d', wlan_ssid)
        with open(path, 'w') as f:
            print('\tWrite {path}'.format(**locals()))
            f.write(wlan_config)

    path = os.path.join(target, './root/docker/mighty-thymio/ros.env')
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w') as f:
        print('Configure ROS env in {path}'.format(path=path))
        f.write(ros_config_template.format(**locals()))


if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument("--target", help="the root folder",
                        default='/', required=False)
    parser.add_argument("--name", '--n', help="the robot name", required=True)
    parser.add_argument("--password", '--p',
                        help="the wlan password", required=True)
    parser.add_argument("--channel", '--c',
                        help="the wlan channel", default=6, required=False)
    parser.add_argument('--access_points', '--a', nargs='*',
                        help='the list of Access Points: ssid1 password1 ssid2 password2 ...)',
                        required=False)

    args = parser.parse_args()
    wlans = zip(args.access_points[::2], args.access_points[1::2])
    main(wpa_passphrase=args.password, wlans=wlans, **vars(args))
