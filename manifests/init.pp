class systemd {
  exec { 'systemd-reload':
    command     => '/usr/bin/systemctl -q daemon-reload',
    refreshonly => true,
  }
}
