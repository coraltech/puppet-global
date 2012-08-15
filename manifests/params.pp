
class global::params inherits global::default {

  $setup_packages   = module_array('setup_packages')
  $setup_ensure     = module_param('setup_ensure')
  $build_packages   = module_array('build_packages')
  $build_ensure     = module_param('build_ensure')
  $common_packages  = module_array('common_packages')
  $common_ensure    = module_param('common_ensure')
  $runtime_packages = module_array('runtime_packages')
  $runtime_ensure   = module_param('runtime_ensure')

  #---

  $facts            = module_hash('facts')
  $fact_environment = module_param('fact_environment')
  $facts_template   = module_param('facts_template')

  #---

  $make_revision    = module_param('make_revision')
  $make_dev_ensure  = module_param('make_dev_ensure')
  $make_user        = module_param('make_user')
  $make_group       = module_param('make_group')
  $make_options     = module_param('make_options')
}
