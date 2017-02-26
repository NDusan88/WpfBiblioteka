using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfBiblioteka
{
    class VrstaPublikacije
    {
        public int VrstaPublikacijeId { get; set; }
        public string Naziv { get; set; }
        public override string ToString()
        {
            return string.Format("{0}", Naziv);
        }
    }
}
