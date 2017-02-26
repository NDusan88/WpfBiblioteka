using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfBiblioteka
{
    class Korisnici
    {
        public int KorisnikId { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public int BrojLk { get; set; }
        public string Adresa { get; set; }
        public int BrojTelefona { get; set; }
        public override string ToString()
        {
            return string.Format("{0} {1}",Ime, Prezime);
        }
    }
}
