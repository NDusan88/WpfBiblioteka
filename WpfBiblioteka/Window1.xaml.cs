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
using System.Windows.Shapes;

namespace WpfBiblioteka
{
    /// <summary>
    /// Interaction logic for Window1.xaml
    /// </summary>
    public partial class Window1 : Window
    {
        List<Bibliotekar> bibliotekar = new List<Bibliotekar>();
        public Window1()
        {
            InitializeComponent();
        }
        private void Bibliotekar()
        {
            SqlConnection SqlConn = Konekcija.KreirajKonekciju();
            try
            {
                SqlConn.Open();
                SqlCommand cmd = new SqlCommand("SELECT BibliotekarId, Ime,Prezime FROM Bibliotekar", SqlConn);
                SqlDataReader read = cmd.ExecuteReader();
                while (read.Read())
                {
                    Bibliotekar b = new Bibliotekar();
                    int BibliotekarId = read.GetInt32(0);
                    string Ime = read.GetString(1);
                    string Prezime = read.GetString(2);

                    b.BibliotekarId = BibliotekarId;
                    b.Ime = Ime;
                    b.Prezime = Prezime;

                    bibliotekar.Add(b);
                }
                listBoxListaBibliotekara.ItemsSource = null;
                listBoxListaBibliotekara.ItemsSource = bibliotekar;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            Bibliotekar();
        }

        private void buttonDodaj_Click(object sender, RoutedEventArgs e)
        {
            SqlConnection SqlConn = Konekcija.KreirajKonekciju();
            try
            {
                if(!string.IsNullOrWhiteSpace(textBoxIme.Text) && !string.IsNullOrWhiteSpace(textBoxPrezime.Text))
                {
                    bibliotekar.Clear();
                    SqlConn.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO Bibliotekar(Ime, Prezime) VALUES(@Ime,@Prezime)", SqlConn);
                    cmd.Parameters.Add(new SqlParameter("@Ime", textBoxIme.Text.Trim()));
                    cmd.Parameters.Add(new SqlParameter("@Prezime", textBoxPrezime.Text.Trim()));
                    int ubaci = cmd.ExecuteNonQuery();
                    if (ubaci == 0)
                    {
                        MessageBox.Show("Doslo je do grekse");
                    }
                    else
                    {
                        Bibliotekar();
                        MessageBox.Show("Bibliotekar je dodat");
                    }
                }
                else
                {
                    
                    MessageBox.Show("Morate uneti Ime i Prezime");
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

        private void buttonUclani_Click(object sender, RoutedEventArgs e)
        {
            Window2 w2 = new Window2();
            Close();
            w2.ShowDialog();
        }

        private void buttonDodajPublikaciju_Click(object sender, RoutedEventArgs e)
        {
            Window3 w3 = new Window3();
            Close();
            w3.ShowDialog();
        }

        private void buttonObrisi_Click(object sender, RoutedEventArgs e)
        {
            bibliotekar.Clear();
            SqlConnection SqlConn = Konekcija.KreirajKonekciju();
            try
            {
                SqlConn.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM Bibliotekar WHERE BibliotekarId = @BibliotekarId", SqlConn);
                cmd.Parameters.Add(new SqlParameter("@BibliotekarId", (listBoxListaBibliotekara.SelectedItem as Bibliotekar).BibliotekarId));
                int obrisi = cmd.ExecuteNonQuery();

                if (obrisi == 0)
                {
                    MessageBox.Show("Doslo je do greske");
                }
                else
                {
                    Bibliotekar();
                    MessageBox.Show("Korisnik je obrisan");
                }
            }
            catch (Exception)
            {

                MessageBox.Show("Niste Seletkovali listu");
                return;
            }
            finally
            {
                SqlConn.Close();
            }
        }

        private void buttonIznajmiPublikaciju_Click(object sender, RoutedEventArgs e)
        {
            Window4 w4 = new Window4();
            Close();
            w4.ShowDialog();
        }

        private void buttonZaduzene_Click(object sender, RoutedEventArgs e)
        {
            Window5 w5 = new Window5();
            Close();
            w5.ShowDialog();
        }
    }
}
