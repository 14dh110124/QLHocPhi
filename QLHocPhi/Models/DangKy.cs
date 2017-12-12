namespace QLHocPhi.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DangKy")]
    public partial class DangKy
    {
        [Key]
        public int MaDK { get; set; }

        public int? MaHocVien { get; set; }

        public int? MaTKB { get; set; }

        public int? MaLop { get; set; }

        public DateTime? NgayDK { get; set; }

        public int? GiamHocPhi { get; set; }

        public int? ChuyenLop { get; set; }

        public virtual HocVien HocVien { get; set; }

        public virtual Lop Lop { get; set; }

        public virtual ThoiKhoaBieu ThoiKhoaBieu { get; set; }
    }
}
