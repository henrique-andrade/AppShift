public class AppShift.MainWindow : Gtk.ApplicationWindow {
    public MainWindow (Gtk.Application app) {
        Object (
            application: app,
            title: "AppShift",
            default_width: 800,
            default_height: 600
        );

        // Use um widget do Granite
        var welcome = new Granite.Widgets.Welcome();
        welcome.append("Bem-vindo ao AppShift", "Migre seus aplicativos facilmente.", "dialog-information-symbolic");
        this.add(welcome);
    }
}

