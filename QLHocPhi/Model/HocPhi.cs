namespace QLHocPhi.Model
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("HocPhi")]
    public partial class HocPhi
    {
        [Key]
        public int MaHocPhi { get; set; }

        public int? MaLop { get; set; }

        [Column(TypeName = "money")]
        public decimal? SoTien { get; set; }

        public virtual Lop Lop { get; set; }
    }
}
