namespace AppShift {
    public class Utils {
        public static string[] get_installed_packages () {
            try {
                string[] argv = {"dpkg", "--get-selections"};
                var subprocess = new GLib.Subprocess.newv(
                    argv,
                    GLib.SubprocessFlags.STDOUT_PIPE | GLib.SubprocessFlags.STDERR_PIPE
                );
                string output;
                string error_output;
                bool success = subprocess.communicate_utf8(null, null, out output, out error_output);
                if (!success) {
                    warning("Subprocess failed: %s", error_output);
                }
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
