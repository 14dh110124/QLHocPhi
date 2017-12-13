namespace QLHocPhi.Model
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("PhiHocVien")]
    public partial class PhiHocVien
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public PhiHocVien()
        {
            HocViens = new HashSet<HocVien>();
        }

        [Key]
        public int MaPhi { get; set; }

        [Column(TypeName = "money")]
        public decimal? DaDong { get; set; }

        [Column(TypeName = "money")]
        public decimal? ChuaDong { get; set; }

        [Column(TypeName = "money")]
        public decimal? Du { get; set; }

        public int? BaoLuu { get; set; }

        public DateTime? NgayBaoLuu { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<HocVien> HocViens { get; set; }
    }
}
