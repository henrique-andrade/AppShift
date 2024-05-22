# Tutorial de Configuração do Projeto AppShift

## Estrutura de Diretórios

Crie a seguinte estrutura de diretórios para o seu projeto:

```plaintext
AppShift/
├── build/
├── data/
│   ├── icons/
│   ├── app.desktop
│   ├── org.example.AppShift.gresource.xml
│   └── ui/
│       └── MainWindow.ui
├── po/
│   ├── en.po
│   └── pt_BR.po
├── src/
│   ├── main.vala
│   ├── application.vala
│   ├── window.vala
│   └── utils.vala
├── tests/
│   └── test_main.vala
├── meson.build
├── README.md
└── LICENSE            
```

## Conteúdo dos Arquivos

### `CMakeLists.txt`

Crie o arquivo `CMakeLists.txt` com o seguinte conteúdo:

```cmake
cmake_minimum_required(VERSION 3.10)
project(appshift C)

find_package(PkgConfig REQUIRED)
pkg_check_modules(DEPS REQUIRED gtk+-3.0 granite)

include_directories(${DEPS_INCLUDE_DIRS})
link_directories(${DEPS_LIBRARY_DIRS})

set(SOURCES
    src/main.vala
    src/application.vala
    src/window.vala
    src/utils.vala
)

add_definitions(${DEPS_CFLAGS_OTHER})

# GResources
set(GRESOURCE_XML ${CMAKE_SOURCE_DIR}/data/org.example.AppShift.gresource.xml)
set(GRESOURCE_C ${CMAKE_BINARY_DIR}/gresources.c)

add_custom_command(
    OUTPUT ${GRESOURCE_C}
    COMMAND glib-compile-resources
    --generate-source
    --target=${GRESOURCE_C}
    ${GRESOURCE_XML}
    DEPENDS ${GRESOURCE_XML}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/data
)

add_executable(appshift ${SOURCES} ${GRESOURCE_C})

target_link_libraries(appshift ${DEPS_LIBRARIES})
```

### `data/org.example.AppShift.gresource.xml`

Crie o arquivo `data/org.example.AppShift.gresource.xml` com o seguinte conteúdo:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<gresources>
    <gresource prefix="/com/example/AppShift">
        <file>ui/MainWindow.ui</file>
    </gresource>
</gresources>
```

### `data/ui/MainWindow.ui`

Crie o arquivo `data/ui/MainWindow.ui` com o seguinte conteúdo:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<interface>
    <object class="GtkWindow" id="main_window">
        <property name="default_width">800</property>
        <property name="default_height">600</property>
        <child>
            <object class="GtkBox" id="box">
                <property name="orientation">vertical</property>
                <child>
                    <object class="GtkLabel" id="label">
                        <property name="label">Bem-vindo ao AppShift!</property>
                    </object>
                </child>
            </object>
        </child>
    </object>
</interface>
```

### `src/main.vala`

Crie o arquivo `src/main.vala` com o seguinte conteúdo:

```vala
int main(string[] args) {
    var app = new AppShift.Application();
    return app.run(args);
}
```

### `src/application.vala`

Crie o arquivo `src/application.vala` com o seguinte conteúdo:

```vala
public class AppShift.Application : Gtk.Application {
    public Application () {
        Object (
            application_id: "com.example.AppShift",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var window = new AppShift.MainWindow(this);
        window.show_all();
    }
}
```

### `src/window.vala`

Crie o arquivo `src/window.vala` com o seguinte conteúdo:

```vala
public class AppShift.MainWindow : Gtk.ApplicationWindow {
    public MainWindow (Gtk.Application app) {
        Object (
            application: app,
            title: "AppShift",
            default_width: 800,
            default_height: 600
        );

        // Use um widget do Granite
        var welcome = new Granite.Widgets.Welcome("Bem-vindo ao AppShift", "Migre seus aplicativos facilmente.");
        welcome.append("informação adicional", "Este é um texto adicional.", "dialog-information-symbolic");
        this.add(welcome);
    }
}
```

### `src/utils.vala`

Crie o arquivo `src/utils.vala` com o seguinte conteúdo:

```vala
public static string[] get_installed_packages () {
    // Implementação para obter pacotes instalados
    return {"example-package"};
}
```

## Passos para Construção e Execução

1. **Limpar o Diretório de Construção:**

```bash
cd ~/Projetos/AppShift
rm -rf build
mkdir build
cd build
```

2. **Configurar o Projeto com CMake:**

```bash
cmake ..
```

3. **Construir o Projeto com make:**

```bash
make
```

4. **Executar o Aplicativo:**

```bash
./appshift
```

## Compilação Direta com `valac`

Para depuração, você pode tentar compilar diretamente com `valac`:

```bash
valac --pkg gtk+-3.0 --pkg granite src/main.vala src/application.vala src/window.vala src/utils.vala -o appshift
```

2/2