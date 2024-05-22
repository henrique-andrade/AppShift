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
