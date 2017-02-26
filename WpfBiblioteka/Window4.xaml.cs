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
    /// Interaction logic for Window4.xaml
    /// </summary>
    public partial class Window4 : Window
    {
        List<VrstaPublikacije> vrstaPublikacije = new List<VrstaPublikacije>();
        List<Publikacija> publikacija = new List<Publikacija>();
        List<Korisnici> korisnici = new List<Korisnici>();
        public Window4()
        {
            InitializeComponent();
        }

        private void OsveziCombo()
        {
            SqlConnection SqlConn = Konekcija.KreirajKonekciju();
            try
            {
                SqlConn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM VrstaPublikacije", SqlConn);
                SqlDataReader read = cmd.ExecuteReader();
                while (read.Read())
                {
                    VrstaPublikacije vr = new VrstaPublikacije();
                    int VrstaPublikacijeId = read.GetInt32(0);
                    string Naziv = read.GetString(1);

                    vr.VrstaPublikacijeId = VrstaPublikacijeId;
                    vr.Naziv = Naziv;

                    vrstaPublikacije.Add(vr);
                }

                comboBoxVrsta.ItemsSource = null;
                comboBoxVrsta.ItemsSource = vrstaPublikacije;

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
        private void OsveziKorisnike()
        {
            SqlConnection SqlConn = Konekcija.KreirajKonekciju();
            try
            {
                SqlConn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM Korisnik", SqlConn);
                SqlDataReader read = cmd.ExecuteReader();
                while (read.Read())
                {
                    Korisnici k = new Korisnici();
                    int KorisnikId = read.GetInt32(0);
                    string Ime = read.GetString(1);
                    string Prezime = read.GetString(2);
                    int BrojLk = read.GetInt32(3);
                    int BrojTelefona = read.GetInt32(4);
                    string Adresa = read.GetString(5);

                    k.KorisnikId = KorisnikId;
                    k.Ime = Ime;
                    k.Prezime = Prezime;
                    k.BrojLk = BrojLk;
                    k.Adresa = Adresa;
                    k.BrojTelefona = BrojTelefona;

                    korisnici.Add(k);
                }

                comboBoxKorisnik.ItemsSource = null;
                comboBoxKorisnik.ItemsSource = korisnici;

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
        private void Test()
        {
            if (comboBoxVrsta.SelectedIndex > -1)
            {
                List<Publikacija> publikacija = new List<Publikacija>();
                SqlConnection SqlConn = Konekcija.KreirajKonekciju();
                try
                {
                    SqlConn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM Publikacija WHERE VrstaPublikacijeId = @VrstaPublikacijeId", SqlConn);
                    cmd.Parameters.Add(new SqlParameter("@VrstaPublikacijeId", (comboBoxVrsta.SelectedItem as VrstaPublikacije).VrstaPublikacijeId));
                    SqlDataReader read = cmd.ExecuteReader();
                    while (read.Read())
                    {
                        Publikacija p = new Publikacija();
                        int PublikacijaId = read.GetInt32(0);
                        int VrstaPublikacijeId = read.GetInt32(1);
                        string Naziv = read.GetString(2);
                        int Kom = read.GetInt32(3);

                        p.PublikacijaId = PublikacijaId;
                        p.VrstaPublikacijeId = VrstaPublikacijeId;
                        p.Naziv = Naziv;
                        p.Kom = Kom;

                        publikacija.Add(p);
                    }
                    listBoxPublikacija.ItemsSource = null;
                    listBoxPublikacija.ItemsSource = publikacija;
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
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            OsveziCombo();
            OsveziKorisnike();    
        }

        private void comboBoxVrsta_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (comboBoxVrsta.SelectedIndex > -1)
            {
                List<Publikacija> publikacija = new List<Publikacija>();
                SqlConnection SqlConn = Konekcija.KreirajKonekciju();
                try
                {
                    SqlConn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM Publikacija WHERE VrstaPublikacijeId = @VrstaPublikacijeId", SqlConn);
                    cmd.Parameters.Add(new SqlParameter("@VrstaPublikacijeId", (comboBoxVrsta.SelectedItem as VrstaPublikacije).VrstaPublikacijeId));
                    SqlDataReader read = cmd.ExecuteReader();
                    while (read.Read())
                    {
                        Publikacija p = new Publikacija();
                        int PublikacijaId = read.GetInt32(0);
                        int VrstaPublikacijeId = read.GetInt32(1);        
                        string Naziv = read.GetString(2);
                        int Kom = read.GetInt32(3);

                        p.PublikacijaId = PublikacijaId;
                        p.VrstaPublikacijeId = VrstaPublikacijeId;
                        p.Naziv = Naziv;
                        p.Kom = Kom;

                        publikacija.Add(p);
                    }
                    listBoxPublikacija.ItemsSource = null;
                    listBoxPublikacija.ItemsSource = publikacija;
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

        private void buttonNazad_Click(object sender, RoutedEventArgs e)
        {
            Window1 w1 = new Window1();
            Close();
            w1.ShowDialog();
        }

        private void buttonIznajmi_Click(object sender, RoutedEventArgs e)
        {
            SqlConnection SqlConn = Konekcija.KreirajKonekciju();
            if (comboBoxVrsta.SelectedIndex > -1 && comboBoxKorisnik.SelectedIndex > -1 && !string.IsNullOrWhiteSpace(textBoxKolicina.Text) && dtpDo.SelectedDate.HasValue && dtpDo.SelectedDate.HasValue && listBoxPublikacija.SelectedIndex > -1)
            {
                try
                {
                    SqlConn.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO Zaduzenje(PublikacijaId, KorisnikId, DatumZaduzenja, DatumRazduzenja, BrojKnjiga) VALUES(@PublikacijaId, @KorisnikId, @DatumZaduzenja, @DatumRazduzenja, @BrojKnjiga)", SqlConn);
                    SqlCommand cmd1 = new SqlCommand("UPDATE Publikacija SET Kom = Kom - @Kom WHERE PublikacijaId = @PublikacijaId", SqlConn);
                    cmd.Parameters.Add(new SqlParameter("@PublikacijaId", (listBoxPublikacija.SelectedItem as Publikacija).PublikacijaId));
                    cmd.Parameters.Add(new SqlParameter("@KorisnikId", (comboBoxKorisnik.SelectedItem as Korisnici).KorisnikId));
                    cmd.Parameters.Add(new SqlParameter("@DatumZaduzenja", dptOd.SelectedDate));
                    cmd.Parameters.Add(new SqlParameter("@DatumRazduzenja", dtpDo.SelectedDate));
                    cmd.Parameters.Add(new SqlParameter("@BrojKnjiga", textBoxKolicina.Text.Trim()));
                    cmd1.Parameters.Add(new SqlParameter("@Kom", textBoxKolicina.Text.Trim()));
                    cmd1.Parameters.Add(new SqlParameter("@PublikacijaId", (listBoxPublikacija.SelectedItem as Publikacija).PublikacijaId));
                    int ubaci = cmd.ExecuteNonQuery();
                    int ubaci1 = cmd1.ExecuteNonQuery();

                    if (ubaci == 0 && ubaci1 == 0)
                    {
                        MessageBox.Show("Doslo je do greske");
                    }
                    else
                    {
                        Test();    
                        MessageBox.Show("Publikacija je zaduzena");
                    }
                }
                catch (Exception)
                {

                    throw;
                }
            }
            else
            {
                MessageBox.Show("Morate popuniti sve podatke");
            }
        }
    }
}
