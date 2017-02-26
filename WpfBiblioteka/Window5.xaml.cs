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
    /// Interaction logic for Window5.xaml
    /// </summary>
    public partial class Window5 : Window
    {     
        List<Zaduzenje> zaduzenje = new List<Zaduzenje>();
        public Window5()
        {
            InitializeComponent();
        }
        private void PopuniListu()
        {
            SqlConnection SqlConn = Konekcija.KreirajKonekciju();
            try
            {
                SqlConn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM View_Zaduzenje", SqlConn);
                SqlDataReader read = cmd.ExecuteReader();

                while (read.Read())
                {
                    Zaduzenje z = new Zaduzenje();
                    string Ime = read.GetString(0);
                    string Prezime = read.GetString(1);
                    int BrojLk = read.GetInt32(2);
                    int BrojTel = read.GetInt32(3);
                    string Adresa = read.GetString(4);
                    DateTime DatumDo = read.GetDateTime(5);
                    string Naziv = read.GetString(6);
                    int BrojKnjiga = read.GetInt32(7);

                    z.Ime = Ime;
                    z.Prezime = Prezime;
                    z.BrojLk = BrojLk;
                    z.BrojTelefona = BrojTel;
                    z.Adresa = Adresa;
                    z.DatumRazduzenja = DatumDo;
                    z.Naziv = Naziv;
                    z.BrojKnjiga = BrojKnjiga;

                    zaduzenje.Add(z);
                }
                listBoxListaPublikacije.ItemsSource = null;
                listBoxListaPublikacije.ItemsSource = zaduzenje;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            PopuniListu();
        }

        private void listBoxListaPublikacije_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Zaduzenje item = (Zaduzenje)listBoxListaPublikacije.SelectedItem;
            textBoxIme.Text = item.Ime;
            textBoxPrezime.Text = item.Prezime;
            textBoxBrojLK.Text = item.BrojLk.ToString();
            textBoxBrojTel.Text = item.BrojTelefona.ToString();
            textBoxAdresa.Text = item.Adresa;
            textBoxVremeDo.Text = item.DatumRazduzenja.ToShortDateString();

        }

        private void buttonNazad_Click(object sender, RoutedEventArgs e)
        {
            Window1 w1 = new Window1();
            Close();
            w1.ShowDialog();
        }
    }
}
