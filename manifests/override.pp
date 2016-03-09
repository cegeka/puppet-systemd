define systemd::override (
  $unit = {},
  $service = {},
) {

  include '::systemd'

  validate_re($name, '^[A-Za-z0-9\-]+\.service$',
    "invalid name (${name}) in systemd::override")

  if empty($unit) and empty($service) {
    fail("systemd::override '${name}' does not have a unit hash or service hash defined")
  }

  file { "/etc/systemd/system/${name}.d":
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    purge   => true,
    recurse => true,
    notify  => Exec['systemd-reload'],
  }

  file { "/etc/systemd/system/${name}.d/puppet.conf":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('systemd/unit.erb'),
    notify  => Exec['systemd-reload'],
    require => File["/etc/systemd/system/${name}.d"],
  }

}
