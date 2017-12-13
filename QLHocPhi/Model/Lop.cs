namespace QLHocPhi.Model
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Lop")]
    public partial class Lop
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Lop()
        {
            DangKies = new HashSet<DangKy>();
            DiemThis = new HashSet<DiemThi>();
            HocPhis = new HashSet<HocPhi>();
        }

        [Key]
        public int MaLop { get; set; }

        [StringLength(20)]
        public string TenLop { get; set; }

        public int? SiSo { get; set; }

        public DateTime? Ngay_BD { get; set; }

        public DateTime? Ngay_KT { get; set; }

        public int? MaTKB { get; set; }

        public int? MaGiangVien { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DangKy> DangKies { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DiemThi> DiemThis { get; set; }

        public virtual GiangVien GiangVien { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<HocPhi> HocPhis { get; set; }

        public virtual ThoiKhoaBieu ThoiKhoaBieu { get; set; }
    }
}
