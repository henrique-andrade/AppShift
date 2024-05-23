namespace AppShift {
    public class MainWindow : Gtk.ApplicationWindow {
        private Gtk.TextView output_textview;

        public MainWindow (Gtk.Application app) {
            Object (
                application: app,
                title: "AppShift",
                default_width: 800,
                default_height: 600
            );

            // Adicionar mensagem de log para rastrear o fluxo de execução
            stdout.printf("MainWindow constructor started\n");

            // Carregar a interface do arquivo UI
            var builder = new Gtk.Builder();
            try {
                builder.add_from_file("/home/henrique/Projetos/AppShift/data/ui/MainWindow.ui");
                stdout.printf("UI file loaded successfully\n");
            } catch (Error e) {
                stderr.printf("Error loading UI file: %s\n", e.message);
                return;
            }

            var box = builder.get_object("box") as Gtk.Box;
            if (box == null) {
                stderr.printf("Error finding GtkBox in UI file\n");
                return;
            }

            // Adicionar o GtkBox ao contêiner correto se necessário
            var parent = box.get_parent() as Gtk.Container;
            if (parent != null) {
                parent.remove(box);
            }
            this.add(box);

            var list_apps_button = builder.get_object("list_apps_button") as Gtk.Button;
            if (list_apps_button != null) {
                list_apps_button.clicked.connect(this.on_list_apps_button_clicked);
            } else {
                stderr.printf("Error finding list_apps_button in UI file\n");
                return;
            }

            output_textview = builder.get_object("output_textview") as Gtk.TextView;
            if (output_textview == null) {
                stderr.printf("Error finding output_textview in UI file\n");
                return;
            }

            // Adicionar mensagem de log para rastrear o fluxo de execução
            stdout.printf("MainWindow constructor finished\n");
        }

        private void on_list_apps_button_clicked() {
            // Adicionar mensagem de log para rastrear o fluxo de execução
            stdout.printf("Button clicked: Listing installed packages\n");

            try {
                string[] packages = Utils.get_installed_packages();
                string package_list = string.joinv("\n", packages);

                // Exibir os pacotes no GtkTextView
                output_textview.get_buffer().set_text(package_list, -1);
                stdout.printf("Packages listed successfully\n");
            } catch (Error e) {
                stderr.printf("Exception fetching installed packages: %s\n", e.message);
            }
        }
    }
}
