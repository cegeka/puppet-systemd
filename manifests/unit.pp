define systemd::unit (
  $ensure = 'link',
  $target,
) {

  include '::systemd'

  validate_re($ensure, '^(link|present|absent)$',
    "invalid value for ensure (${ensure}) in systemd::unit")
  validate_re($name, '\.(target|service)$',
    "invalid name (${name}) in systemd::unit")

  # don't force the user to put the full path to systemd's directory
  if $target =~ '^/' {
    $real_target = $target
  } else {
    $real_target = "/lib/systemd/system/${target}"
  }

  file { "/etc/systemd/system/${name}":
    ensure  => $ensure ? { 'present' => 'link', default => $ensure},
    target  => $real_target,
    notify  => Exec['systemd-reload'],
  }

}
