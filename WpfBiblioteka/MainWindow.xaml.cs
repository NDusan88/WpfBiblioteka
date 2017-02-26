using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WpfBiblioteka
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        List<Bibliotekar> bibliotekar = new List<Bibliotekar>();
        public MainWindow()
        {
            InitializeComponent();
        }

        private void buttonLogin_Click(object sender, RoutedEventArgs e)
        {
            SqlConnection SqlConn = Konekcija.KreirajKonekciju();            
            try
            {
                SqlConn.Open();
                SqlCommand cmd = new SqlCommand("SELECT Ime, Sifra FROM Admin", SqlConn);
                SqlDataReader read = cmd.ExecuteReader();
                while (read.Read())
                {
                    Bibliotekar p = new Bibliotekar();
                    string Ime = read.GetString(0);
                    string Prezime = read.GetString(1);

                    p.Ime = Ime;
                    p.Prezime = Prezime;
                    bibliotekar.Add(p);

                    if (textBox.Text.Trim().Contains(p.Ime) && passwordBox.Password.Contains(p.Prezime))
                    {
                        Window1 w1 = new Window1();
                        Close();
                        w1.ShowDialog();
                    }
                    else
                    {
                        MessageBox.Show("Pogresni podaci!");
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                SqlConn.Close();
            }
        }
    }
}
