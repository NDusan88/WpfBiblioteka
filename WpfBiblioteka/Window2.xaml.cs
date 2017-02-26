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
    /// Interaction logic for Window2.xaml
    /// </summary>
    public partial class Window2 : Window
    {
        List<Korisnici> korisnici = new List<Korisnici>();
        public Window2()
        {
            InitializeComponent();
        }
        private void Korisnici()
        {
            SqlConnection SqlConn = Konekcija.KreirajKonekciju();
            try
            {
                SqlConn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM View_Korisnik", SqlConn);
                SqlDataReader read = cmd.ExecuteReader();
                while (read.Read())
                {
                    Korisnici k = new Korisnici();
                    int KorisniciId = read.GetInt32(0);
                    string Ime = read.GetString(1);
                    string Prezime = read.GetString(2);
                    int BrojLk = read.GetInt32(3);
                    int BrojTel = read.GetInt32(4);
                    string Adresa = read.GetString(5);

                    k.KorisnikId = KorisniciId;
                    k.Ime = Ime;
                    k.Prezime = Prezime;
                    k.BrojLk = BrojLk;
                    k.Adresa = Adresa;
                    k.BrojTelefona = BrojTel;

                    korisnici.Add(k);
                }
                listBoxListaKorisnika.ItemsSource = null;
                listBoxListaKorisnika.ItemsSource = korisnici;
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

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            Korisnici();
        }

        private void buttonUclani_Click(object sender, RoutedEventArgs e)
        {
            korisnici.Clear();
            SqlConnection SqlConn = Konekcija.KreirajKonekciju();
            try
            {
                if (!string.IsNullOrWhiteSpace(textBoxIme.Text) && !string.IsNullOrWhiteSpace(textBoxPrezime.Text) && !string.IsNullOrWhiteSpace(textBoxBrojLk.Text) && !string.IsNullOrWhiteSpace(textBoxBrojTelefona.Text) && !string.IsNullOrWhiteSpace(textBoxBrojAdresa.Text))
                {
                    SqlConn.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO Korisnik(Ime,Prezime,BrojLK,BrojTelefona,Adresa) VALUES(@Ime,@Prezime,@BrojLK,@BrojTelefona,@Adresa)", SqlConn);
                    cmd.Parameters.Add(new SqlParameter("@Ime", textBoxIme.Text.Trim()));
                    cmd.Parameters.Add(new SqlParameter("@Prezime", textBoxPrezime.Text.Trim()));
                    cmd.Parameters.Add(new SqlParameter("@BrojLK", textBoxBrojLk.Text.Trim()));
                    cmd.Parameters.Add(new SqlParameter("@Adresa", textBoxBrojAdresa.Text.Trim()));
                    cmd.Parameters.Add(new SqlParameter("@BrojTelefona", textBoxBrojTelefona.Text.Trim()));

                    int ubaci = cmd.ExecuteNonQuery();
                    if (ubaci == 0)
                    {
                        MessageBox.Show("Doslo je do grekse");
                    }
                    else
                    {
                        Korisnici();
                        MessageBox.Show("Korisnik je dodat");
                    }
                }
                else
                {
                    MessageBox.Show("Niste uneli sve podatke");
                }               
            }
            catch (Exception)
            {

                MessageBox.Show("Morate uneti broj");
            }
            finally
            {
                SqlConn.Close();
            }
        }

        private void buttonObrisi_Click(object sender, RoutedEventArgs e)
        {
            korisnici.Clear();
            if (listBoxListaKorisnika.SelectedIndex > -1)
            {
                SqlConnection SqlConn = Konekcija.KreirajKonekciju();
                try
                {
                    SqlConn.Open();
                    SqlCommand cmd = new SqlCommand("DELETE FROM Korisnik WHERE KorisnikId = @KorisnikId",SqlConn);
                    cmd.Parameters.Add(new SqlParameter("@KorisnikId", (listBoxListaKorisnika.SelectedItem as Korisnici).KorisnikId));

                    int delete = cmd.ExecuteNonQuery();
                    if (delete == 0 )
                    {
                        MessageBox.Show("Doslo je do greske");
                    }
                    else
                    {
                        Korisnici();
                        MessageBox.Show("Korisnik je obrisan");
                    }
                }
                catch (Exception)
                {

                    throw;
                }
            }
        }

        private void buttonNazad_Click(object sender, RoutedEventArgs e)
        {
            Window1 w1 = new Window1();
            Close();
            w1.ShowDialog();

        }
    }
}
