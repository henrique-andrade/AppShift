namespace AppShift {
    public class Utils {
        public static string[] get_installed_packages () {
            try {
                string[] argv = {"dpkg", "--get-selections"};
                GLib.Subprocess subprocess = new GLib.Subprocess(
                    GLib.SubprocessFlags.STDOUT_PIPE | GLib.SubprocessFlags.STDERR_PIPE,
                    argv
                );
                string output;
                string error_output;
                subprocess.communicate_utf8(null, null, out output, out error_output);
                string[] packages = output.split("\n");
                Gee.ArrayList<string> package_list = new Gee.ArrayList<string>();
                foreach (string line in packages) {
                    string[] parts = line.split("\t");
                    if (parts.length > 0 && parts[0] != "") {
                        package_list.add(parts[0]);
                    }
                }
                return package_list.to_array();
            } catch (Error e) {
                warning("Exception fetching installed packages: %s", e.message);
                return {};
            }
        }
    }
}
