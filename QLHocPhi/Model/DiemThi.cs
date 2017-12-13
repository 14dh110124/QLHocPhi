namespace QLHocPhi.Model
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DiemThi")]
    public partial class DiemThi
    {
        [Key]
        public int MaDiemThi { get; set; }

        public int? MaHocVien { get; set; }

        public int? MaLop { get; set; }

        public decimal? Diem { get; set; }

        [StringLength(5)]
        public string XepLoai { get; set; }

        public virtual HocVien HocVien { get; set; }

        public virtual Lop Lop { get; set; }
    }
}
