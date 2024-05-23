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

            // Carregar a interface do arquivo UI
            var builder = new Gtk.Builder();
            try {
                builder.add_from_file("/com/example/AppShift/ui/MainWindow.ui");
            } catch (Error e) {
                stderr.printf("Error loading UI file: %s\n", e.message);
                return;
            }

            var box = builder.get_object("box") as Gtk.Box;
            if (box != null) {
                this.add(box);
            } else {
                stderr.printf("Error finding GtkBox in UI file\n");
                return;
            }

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
        }

        private void on_list_apps_button_clicked() {
            try {
                string[] packages = Utils.get_installed_packages();
                string package_list = string.joinv("\n", packages);

                // Exibir os pacotes no GtkTextView
                output_textview.get_buffer().set_text(package_list, -1);
            } catch (Error e) {
                warning("Exception fetching installed packages: %s", e.message);
            }
        }
    }
}
