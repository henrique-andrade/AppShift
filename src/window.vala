namespace AppShift {
    public class MainWindow : Gtk.ApplicationWindow {
        private Gtk.TextView output_textview;
        private string[] installed_packages;

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

            var export_csv_button = builder.get_object("export_csv_button") as Gtk.Button;
            if (export_csv_button != null) {
                export_csv_button.clicked.connect(this.on_export_csv_button_clicked);
            } else {
                stderr.printf("Error finding export_csv_button in UI file\n");
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
                installed_packages = Utils.get_installed_packages();
                string package_list = string.joinv("\n", installed_packages);

                // Exibir os pacotes no GtkTextView
                output_textview.get_buffer().set_text(package_list, -1);
                stdout.printf("Packages listed successfully\n");
            } catch (Error e) {
                stderr.printf("Exception fetching installed packages: %s\n", e.message);
            }
        }

        private void on_export_csv_button_clicked() {
            // Adicionar mensagem de log para rastrear o fluxo de execução
            stdout.printf("Button clicked: Exporting to CSV\n");

            try {
                if (installed_packages != null && installed_packages.length > 0) {
                    var dialog = new Gtk.FileChooserDialog("Save File", this, Gtk.FileChooserAction.SAVE);
                    dialog.add_button("_Cancel", Gtk.ResponseType.CANCEL);
                    dialog.add_button("_Save", Gtk.ResponseType.ACCEPT);

                    dialog.set_do_overwrite_confirmation(true);
                    dialog.set_current_name("installed_packages.csv");

                    if (dialog.run() == (int) Gtk.ResponseType.ACCEPT) {
                        string filepath = dialog.get_filename();
                        var file = File.new_for_path(filepath);
                        var contents = string.joinv("\n", installed_packages);
                        var bytes = contents.data;
                        file.replace_contents(bytes, null, false, FileCreateFlags.NONE, null);
                        stdout.printf("Packages exported successfully to %s\n", filepath);
                    }

                    dialog.destroy();
                } else {
                    stderr.printf("No packages to export\n");
                }
            } catch (Error e) {
                stderr.printf("Exception exporting packages: %s\n", e.message);
            }
        }
    }
}
