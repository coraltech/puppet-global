
class global::params inherits global::default {

  $setup_packages           = module_array('setup_packages')
  $setup_ensure             = module_param('setup_ensure')
  $build_packages           = module_array('build_packages')
  $build_ensure             = module_param('build_ensure')
  $common_packages          = module_array('common_packages')
  $common_ensure            = module_param('common_ensure')
  $runtime_packages         = module_array('runtime_packages')
  $runtime_ensure           = module_param('runtime_ensure')

  #---

  $apt_always_apt_update    = module_param('apt_always_apt_update')
  $apt_disable_keys         = module_param('apt_disable_keys')
  $apt_proxy_host           = module_param('apt_proxy_host')
  $apt_proxy_port           = module_param('apt_proxy_port')
  $apt_purge_sources_list   = module_param('apt_purge_sources_list')
  $apt_purge_sources_list_d = module_param('apt_purge_sources_list_d')
  $apt_purge_preferences_d  = module_param('apt_purge_preferences_d')

  #---

  $facts                    = module_hash('facts')
  $fact_environment         = module_param('fact_environment')
  $facts_template           = module_param('facts_template')

  #---

  $make_revision            = module_param('make_revision')
  $make_dev_ensure          = module_param('make_dev_ensure')
  $make_user                = module_param('make_user')
  $make_group               = module_param('make_group')
  $make_options             = module_param('make_options')
}
