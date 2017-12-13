namespace QLHocPhi.Model
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class QLHP : DbContext
    {
        public QLHP()
            : base("name=QLHP")
        {
        }

        public virtual DbSet<DangKy> DangKies { get; set; }
        public virtual DbSet<DiemThi> DiemThis { get; set; }
        public virtual DbSet<GiangVien> GiangViens { get; set; }
        public virtual DbSet<HoaDon> HoaDons { get; set; }
        public virtual DbSet<HocPhi> HocPhis { get; set; }
        public virtual DbSet<HocVien> HocViens { get; set; }
        public virtual DbSet<Lop> Lops { get; set; }
        public virtual DbSet<NhanVien> NhanViens { get; set; }
        public virtual DbSet<PhiHocVien> PhiHocViens { get; set; }
        public virtual DbSet<QuyenNV> QuyenNVs { get; set; }
        public virtual DbSet<ThoiKhoaBieu> ThoiKhoaBieux { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<DiemThi>()
                .Property(e => e.Diem)
                .HasPrecision(18, 0);

            modelBuilder.Entity<GiangVien>()
                .Property(e => e.SDT)
                .IsUnicode(false);

            modelBuilder.Entity<GiangVien>()
                .Property(e => e.Email)
                .IsUnicode(false);

            modelBuilder.Entity<HoaDon>()
                .Property(e => e.TongTien)
                .HasPrecision(19, 4);

            modelBuilder.Entity<HocPhi>()
                .Property(e => e.SoTien)
                .HasPrecision(19, 4);

            modelBuilder.Entity<HocVien>()
                .Property(e => e.SDT)
                .IsUnicode(false);

            modelBuilder.Entity<HocVien>()
                .Property(e => e.Email)
                .IsUnicode(false);

            modelBuilder.Entity<NhanVien>()
                .Property(e => e.SDT)
                .IsUnicode(false);

            modelBuilder.Entity<NhanVien>()
                .Property(e => e.Email)
                .IsUnicode(false);

            modelBuilder.Entity<NhanVien>()
                .Property(e => e.MatKhau)
                .IsUnicode(false);

            modelBuilder.Entity<PhiHocVien>()
                .Property(e => e.DaDong)
                .HasPrecision(19, 4);

            modelBuilder.Entity<PhiHocVien>()
                .Property(e => e.ChuaDong)
                .HasPrecision(19, 4);

            modelBuilder.Entity<PhiHocVien>()
                .Property(e => e.Du)
                .HasPrecision(19, 4);

            modelBuilder.Entity<ThoiKhoaBieu>()
                .Property(e => e.ThoiGian)
                .IsUnicode(false);
        }
    }
}
