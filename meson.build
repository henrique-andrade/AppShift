project('appshift', 'vala', 
  version: '0.1',
  meson_version: '>= 0.59.0'
)

gnome = import('gnome')

dependencies = [
  dependency('gtk+-3.0'),
  dependency('granite'),
  dependency('gee-0.8')
]

gresource = gnome.compile_resources(
  'appshift.gresource',
  'data/org.example.AppShift.gresource.xml',
  source_dir: 'data'
)

executable('appshift',
  'src/main.vala',
  'src/application.vala',
  'src/window.vala',
  'src/utils.vala',
  gresource,
  dependencies: dependencies,
  install: true
)

install_data('data/icons/appshift-icon.png', install_dir: get_option('prefix') / 'share' / 'icons' / 'hicolor' / 'scalable' / 'apps')
install_subdir('data/ui', install_dir: get_option('prefix') / 'share' / 'appshift')
