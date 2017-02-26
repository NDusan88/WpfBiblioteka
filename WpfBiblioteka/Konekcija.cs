using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfBiblioteka
{
    class Konekcija
    {
        public static SqlConnection KreirajKonekciju()
        {
            SqlConnection SqlConn = new SqlConnection(@"Data Source=DESKTOP-U50ISQ7\ROOT;Initial Catalog=Biblioteka;Integrated Security=True");
            return SqlConn;
        }

    }
}
