define lxc::container(
  conf_dir = '/etc/lxc',
  data_dir = '/media/buttery',
  template_folder = '/media/buttery/template',
  ){

  file { "$conf_dir/$name/config":
    ensure => directory,
    content => template('lxc/conifg.erb'),
    require => File["$conf_dir/$name"],
  }

  file { "$conf_dir/$name/fstab":
    ensure => directory,
    content => template('lxc/fstab.erb'),
    require => File["$conf_dir/$name"],
  }
  
  file { "$conf_dir/$name":
    ensure => directory,
  }
  
  file { "$lxc_data_dir/$name":
    ensure => directory,
  }

  exec { "copy_contents-$name":
    command => "rsync -PHa $template_folder/ $data_dir/$name/",
    onlyif => "[ `ls lies/ | wc -l` == 0 ]",
    require => File["$lxc_data_dir/$name"],

  }
}
