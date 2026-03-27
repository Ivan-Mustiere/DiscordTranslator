using System;
using System.Windows.Forms;
using System.Drawing; // Pour Icon

namespace src.ui
{
    public class MainForm : Form
    {
        private Button testButton;

        public MainForm()
        {
            // Titre de la fenêtre
            Text = "DiscordTrad";
            Width = 400;
            Height = 300;

            // Taille minimale
            MinimumSize = new Size(300, 200);  // Largeur 300px, Hauteur 200px

            // Définir l'icône (logo.ico doit être dans le dossier bin ou inclus dans le projet)
            Icon = new Icon("ui/resources/logo.ico");

            // Création du bouton
            testButton = new Button();
            testButton.Text = "Test audio";
            testButton.Top = 50;
            testButton.Left = 50;
            testButton.Click += TestButton_Click;

            Controls.Add(testButton);
        }

        private void TestButton_Click(object? sender, EventArgs e)
        {
            MessageBox.Show("Bouton cliqué !");
            // Ici tu peux appeler ton code audio / network / models
        }
    }
}
