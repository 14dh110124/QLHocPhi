namespace QLHocPhi.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("HoaDon")]
    public partial class HoaDon
    {
        [Key]
        public int MaHD { get; set; }

        public int? MaHocVien { get; set; }

        public int? MaNhanVien { get; set; }

        [Column(TypeName = "money")]
        public decimal? TongTien { get; set; }

        public virtual HocVien HocVien { get; set; }

        public virtual NhanVien NhanVien { get; set; }
    }
}
