project('appshift', 'vala', 
  version: '0.1',
  meson_version: '>= 0.49.0'
)

gnome = import('gnome')

dependencies = [
  dependency('gtk+-3.0'),
  dependency('granite')
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
