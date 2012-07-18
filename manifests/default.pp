
class global_lib::default {
  $facts                  = {}
  $build_essential_ensure = 'present'
  $vim_ensure             = 'present'
  $unzip_ensure           = 'present'
  $facts_template         = 'global_lib/facts.sh.erb'
}
