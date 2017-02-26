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
    /// Interaction logic for Window3.xaml
    /// </summary>
    public partial class Window3 : Window
    {
        List<VrstaPublikacije> vrstaPublikacije = new List<VrstaPublikacije>();
        List<Publikacija> publikacija = new List<Publikacija>();
        public Window3()
        {
            InitializeComponent();
        }
        private void VrstaPublikacije()
        {
            SqlConnection SqlConn = Konekcija.KreirajKonekciju();
            try
            {
                SqlConn.Open();
                SqlCommand cmd = new SqlCommand("SELECT VrstaPublikacijeId, Naziv FROM VrstaPublikacije", SqlConn);
                SqlDataReader read = cmd.ExecuteReader();
                while (read.Read())
                {
                    VrstaPublikacije p = new VrstaPublikacije();
                    int VrstaPublikacijeId = read.GetInt32(0);
                    string Naziv = Naziv = read.GetString(1);

                    p.VrstaPublikacijeId = VrstaPublikacijeId;
                    p.Naziv = Naziv;

                    vrstaPublikacije.Add(p);
                }
                listBoxVrstaPublikacije.ItemsSource = null;
                listBoxVrstaPublikacije.ItemsSource = vrstaPublikacije;
                comboBox.ItemsSource = null;
                comboBox.ItemsSource = vrstaPublikacije;

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
        private void Publikacija()
        {
            SqlConnection SqlConn = Konekcija.KreirajKonekciju();
            try
            {
                SqlConn.Open();
                SqlCommand cmd = new SqlCommand("SELECT PublikacijaId, VrstaPublikacijeId, Naziv, Kom FROM Publikacija", SqlConn);
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
            VrstaPublikacije();
            //Publikacija();
        }

        private void buttonDodaj_Click(object sender, RoutedEventArgs e)
        {
            vrstaPublikacije.Clear();
            //comboBox.Items.Clear();
            SqlConnection SqlConn = Konekcija.KreirajKonekciju();
            if (!string.IsNullOrWhiteSpace(textBoxImeVrste.Text))
            {
                try
                {
                    SqlConn.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO VrstaPublikacije(Naziv) VALUES(@Naziv)",SqlConn);
                    cmd.Parameters.Add(new SqlParameter("@Naziv",textBoxImeVrste.Text.Trim()));
                    int ubaci = cmd.ExecuteNonQuery();
                    if (ubaci == 0)
                    {
                        MessageBox.Show("Doslo je do grekse");
                    }
                    else
                    {
                        VrstaPublikacije();
                        MessageBox.Show("Vrsta publikacije je dodata");
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
            else
            {
                MessageBox.Show("Niste uneli vrstu publikacije");
            }
        }

        private void buttoUbaci_Click(object sender, RoutedEventArgs e)
        {
            SqlConnection SqlConn = Konekcija.KreirajKonekciju();
            if (!string.IsNullOrWhiteSpace(textBoxImePublikacije.Text) && !string.IsNullOrWhiteSpace(textBoxImeAutora.Text) && !string.IsNullOrWhiteSpace(textBoxPrezimeAutora.Text) && !string.IsNullOrWhiteSpace(textBoxKolicina.Text) && comboBox.SelectedIndex > -1)
            {
                try
                {
                    SqlConn.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO Publikacija(VrstaPublikacijeId, Naziv, Kom) VALUES(@VrstaPublikcijeId, @Naziv, @Kom)", SqlConn);
                    SqlCommand cmd1 = new SqlCommand("INSERT INTO Autor(Ime,Prezime) VALUES(@Ime,@Prezime)", SqlConn);
                    
                    cmd.Parameters.Add(new SqlParameter("@VrstaPublikcijeId", (comboBox.SelectedItem as VrstaPublikacije).VrstaPublikacijeId));
                    cmd.Parameters.Add(new SqlParameter("@Naziv", textBoxImePublikacije.Text.Trim()));
                    cmd.Parameters.Add(new SqlParameter("@Kom", textBoxKolicina.Text.Trim()));
                    cmd1.Parameters.Add(new SqlParameter("@Ime", textBoxImeAutora.Text.Trim()));
                    cmd1.Parameters.Add(new SqlParameter("@Prezime", textBoxPrezimeAutora.Text.Trim()));
                    //cmd1.Parameters.Add(new SqlParameter("@PublikacijaId", (comboBox.SelectedItem as VrstaPublikacije)));
                    int ubaci = cmd.ExecuteNonQuery();
                    int ubaci1 = cmd1.ExecuteNonQuery();
                    if (ubaci == 0 || ubaci1 == 0)
                    {
                        MessageBox.Show("Doslo je do grekse");
                    }
                    else
                    {
                        //VrstaPublikacije();
                        MessageBox.Show("Vrsta publikacije je dodata");
                    }
                }
                catch (Exception)
                {
                    MessageBox.Show("Morate uneti ceo broj");
                }
                finally
                {
                    SqlConn.Close();
                }
            }
            else
            {
                MessageBox.Show("Niste uneli sve podatke");
            }
        }

        private void buttoNazad_Click(object sender, RoutedEventArgs e)
        {
            Window1 w1 = new Window1();
            Close();
            w1.ShowDialog();
        }
    }
}
