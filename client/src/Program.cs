using System;
using System.Windows.Forms;
using src.ui;  // Namespace où est MainForm

namespace src
{
    static class Program
    {
        [STAThread]
        static void Main()
        {
            Application.SetHighDpiMode(HighDpiMode.SystemAware);
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            // On lance la fenêtre principale MainForm
            Application.Run(new MainForm());
        }
    }
}
