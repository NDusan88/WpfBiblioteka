using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfBiblioteka
{
    class Zaduzenje
    {
        public int ZaduzenjeId { get; set; }
        public int PublikacijaId { get; set; }
        public int KorisnikId { get; set; }
        public DateTime DatumZaduzenja { get; set; }
        public DateTime DatumRazduzenja { get; set; }
        public int BrojKnjiga { get; set; }
      
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public int BrojLk { get; set; }
        public string Adresa { get; set; }
        public int BrojTelefona { get; set; }

        public string Naziv { get; set; }
        public override string ToString()
        {
            return string.Format("{0} Kom: {1}", Naziv, BrojKnjiga);
        }
    }
}
