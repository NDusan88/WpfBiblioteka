using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfBiblioteka
{
    class Publikacija
    {
        public int PublikacijaId { get; set; }
        public int VrstaPublikacijeId { get; set; }
        public int IzdavacId { get; set; }
        public string Naziv { get; set; }
        public int Kom { get; set; }
        public override string ToString()
        {
            return string.Format("{0} Kom: {1}", Naziv, Kom);
        }
    }
}
