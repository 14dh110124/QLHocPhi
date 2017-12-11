USE master
GO
IF EXISTS(SELECT * FROM SYSDATABASES WHERE name='QLHocPhi')
	DROP DATABASE QLHocPhi
GO
---------------------
CREATE DATABASE QLHocPhi
GO
USE QLHocPhi
GO
CREATE TABLE PhiHocVien( -- Phí học viên
	MaPhi INT IDENTITY(1,1) PRIMARY KEY,
	DaDong MONEY, -- Đã đóng
	ChuaDong MONEY, -- Chưa đóng hoặc thiếu (Thiếu khi chuyển từ lớp có học phí thấp sang lớp có học phí cao - Hoặc khi đi đăng ký chỉ đặt cọc). ChuaDong = HocPhi.SoTien - DaDong
	Du MONEY, -- Số tiền dư (Dư khi chuyển từ lớp có học phí cao sang lớp có học phí thấp)
	BaoLuu INT,
	NgayBaoLuu DATETIME
)
GO
CREATE TABLE HocVien(
	MaHocVien INT IDENTITY(1,1) PRIMARY KEY,
	HoTen NVARCHAR(50),
	DiaChi NVARCHAR(100),
	SDT VARCHAR(11),
	Email VARCHAR(50),
	PhiHocVien INT FOREIGN KEY (PhiHocVien) REFERENCES PhiHocVien(MaPhi),
	Delfag INT
)
GO
CREATE TABLE GiangVien(
	MaGiangVien INT IDENTITY(1,1) PRIMARY KEY,
	HoTen NVARCHAR(50),
	DiaChi NVARCHAR(100),
	SDT VARCHAR(11),
	Email VARCHAR(50)
)
GO
CREATE TABLE QuyenNV(
	MaQuyen INT IDENTITY(1,1) PRIMARY KEY,
	TenQuyen NVARCHAR(20)
)
GO
CREATE TABLE NhanVien(
	MaNhanVien INT IDENTITY(1,1) PRIMARY KEY,
	HoTen NVARCHAR(50),
	DiaChi NVARCHAR(100),
	SDT VARCHAR(11),
	Email VARCHAR(50),
	MatKhau VARCHAR(30),
	MaQuyen INT FOREIGN KEY (MaQuyen) REFERENCES QuyenNV(MaQuyen)
)
GO
CREATE TABLE ThoiKhoaBieu(
	MaTKB INT IDENTITY(1,1) PRIMARY KEY,
	ThoiGian VARCHAR(10)
)
GO
CREATE TABLE Lop(
	MaLop INT IDENTITY(1,1) PRIMARY KEY,
	TenLop NVARCHAR(20),
	SiSo INT, -- Max: 20
	Ngay_BD DATETIME, -- Ngày bắt đầu
	Ngay_KT DATETIME, -- Ngày kết thúc. Dựa vào ngày này để tính số ngày còn dư nếu học viên chuyển lớp: Số ngày dư = Ngày kết thúc - ngày hiện tại. Từ số ngày dư tính đc số tiền Dư trong bảng PhiHocVien
	MaTKB INT FOREIGN KEY (MaTKB) REFERENCES ThoiKhoaBieu(MaTKB),
	MaGiangVien INT FOREIGN KEY (MaGiangVien) REFERENCES GiangVien(MaGiangVien)
)
GO
CREATE TABLE DangKy(
	MaDK INT IDENTITY(1,1) PRIMARY KEY,
	MaHocVien INT FOREIGN KEY (MaHocVien) REFERENCES HocVien(MaHocVien),
	MaTKB INT FOREIGN KEY (MaTKB) REFERENCES ThoiKhoaBieu(MaTKB),
	MaLop INT FOREIGN KEY (MaLop) REFERENCES Lop(MaLop),
	NgayDK DATETIME,
	GiamHocPhi INT, -- Dựa vào giá trị này để tính toán có giảm học phí cho lần đăng ký tiếp theo hay ko (0: chưa giảm - 1: được giảm)
	ChuyenLop INT -- Số lần chuyển lớp, lớn nhất là 2
)
GO
CREATE TABLE DiemDanh( -- Dựa vào bảng này để tính trung bình sỉ số đi học của 1 lớp / ngày
	MaLop INT FOREIGN KEY (MaLop) REFERENCES Lop(MaLop),
	NgayDiemDanh DATETIME,
	MaHocVien INT FOREIGN KEY (MaHocVien) REFERENCES HocVien(MaHocVien),
	SoLuong INT, -- SoLuong = COUNT(MaHocVien) theo MaLop
)
GO
CREATE TABLE DiemThi(
	MaDiemThi INT IDENTITY(1,1) PRIMARY KEY,
	MaHocVien INT FOREIGN KEY (MaHocVien) REFERENCES HocVien(MaHocVien),
	MaLop INT FOREIGN KEY (MaLop) REFERENCES Lop(MaLop),
	Diem DECIMAL,
	XepLoai NVARCHAR(5), -- Giỏi, tốt, khá, trung bình, yếu, kém
)
GO
CREATE TABLE HocPhi(
	MaHocPhi INT IDENTITY(1,1) PRIMARY KEY,
	MaLop INT FOREIGN KEY (MaLop) REFERENCES Lop(MaLop),
	SoTien MONEY
)
GO
CREATE TABLE HoaDon(
	MaHD INT IDENTITY(1,1) PRIMARY KEY,
	MaHocVien INT FOREIGN KEY (MaHocVien) REFERENCES HocVien(MaHocVien),
	MaNhanVien INT FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
	TongTien MONEY
)
GO
CREATE TABLE CTHD(
	MaHD INT FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
	MaLop INT FOREIGN KEY (MaLop) REFERENCES Lop(MaLop),
	ThanhTien MONEY
)
GO
---------------------
--insert into PhiHocVien values(null,null,null,null,null)
--insert into PhiHocVien values(null,null,null,null,null)
--insert into PhiHocVien values(null,null,null,null,null)
--insert into PhiHocVien values(null,null,null,null,null)
insert into HocVien values(N'Đỗ Trần Thái Nam',N'1224 Trường Sa P14 Q.Phú Nhuận TP.HCM','0918112771','dotranthainam@gmail.com', null, 0)
insert into HocVien values(N'Lê Việt Quang',N'155 Sư Vạn Hạnh (nd) Q10 TP.HCM','0908142123','minhminh@gmail.com', null, 0)
insert into HocVien values(N'Nguyễn Minh Minh',N'215 Tên Lửa Q.Bình Tân TP.HCM','01684309004','quangstupid@gmail.com', null, 0)
insert into HocVien values(N'Phạm Thanh Sơn',N'523/14 Hùng Vương Q5 TP.HCM','01686024111','soncrazy@gmail.com', null, 0)
insert into GiangVien values(N'Ưng Hoàng Phúc',N'12 Hoàng Hoa Thám Q.Tân Bình TP.HCM','09884125167','nguyenvana@yahoo.com')
insert into GiangVien values(N'Trí Hải',N'132 Kinh Dương Vương Q.5 TP.HCM','0915836380','nguyenvanb@gmail.com')
insert into GiangVien values(N'Minh Hằng',N'529 Nguyễn Trãi Q5 TP.HCM','091536349','tranthic@yahoo.com')
insert into GiangVien values(N'Lương Bích Hữu',N'72 Đồng Khởi Q1 TP.HCM','0900152833','ONgONgONg@gmail.com')
insert into QuyenNV values(N'Admin')
insert into QuyenNV values(N'Quản lý học viên')
insert into QuyenNV values(N'Quản lý hóa đơn')
insert into QuyenNV values(N'Lao công')
insert into NhanVien values(N'Đỗ Trần Thái Nam',N'1220 Trường Sa, Q.Phú Nhuận','0918112771','admin@gmail.com', 'admin', 1)
insert into NhanVien values(N'Lê Việt Quang',N'46 Lý Thường Kiệt Q10 TP.HCM','0918112771','admin1@gmail.com', 'admin', 2)
insert into NhanVien values(N'Nguyễn Minh Minh',N'65 Phạm Văn Hai Q.Tân Bình TP.HCM','0918112771','admin2@gmail.com', 'admin', 3)
insert into NhanVien values(N'Trúc Nhân',N'12 Đồng Khởi Q1 TP.HCM','0900152900','nhansinger@gmail.com', '123456789', 4)
insert into NhanVien values(N'Sơn Tùng MTP',N'46 Lý Thường Kiệt Q10 TP.HCM','0908112114','tungmtp@gmail.com', '123456789', 4)
insert into NhanVien values(N'Lệ Quyên',N'65 Phạm Văn Hai Q.Tân Bình TP.HCM','0912445296','lequyen@gmail.com', '123456789', 4)
insert into NhanVien values(N'Jimmy Nguyễn',N'83 Trung Quốc','0242183659','jimmyng@gmail.com', '123456789', 4)
insert into ThoiKhoaBieu values('S1 2-4-6')
insert into ThoiKhoaBieu values('S2 2-4-6')
insert into ThoiKhoaBieu values('C1 2-4-6')
insert into ThoiKhoaBieu values('C2 2-4-6')
insert into ThoiKhoaBieu values('T1 2-4-6')
insert into ThoiKhoaBieu values('T2 2-4-6')
insert into ThoiKhoaBieu values('S1 3-5-7')
insert into ThoiKhoaBieu values('S2 3-5-7')
insert into ThoiKhoaBieu values('C1 3-5-7')
insert into ThoiKhoaBieu values('C2 3-5-7')
insert into ThoiKhoaBieu values('T1 3-5-7')
insert into ThoiKhoaBieu values('T2 3-5-7')
insert into Lop values('TOIEC100',20,null,null,1,null)
insert into Lop values('TOIEC100',20,null,null,2,null)
insert into Lop values('TOIEC100',20,null,null,3,null)
insert into Lop values('TOIEC100',20,null,null,4,null)
insert into Lop values('TOIEC100',20,null,null,5,null)
insert into Lop values('TOIEC100',20,null,null,6,null)
insert into Lop values('TOIEC100',20,null,null,7,null)
insert into Lop values('TOIEC100',20,null,null,8,null)
insert into Lop values('TOIEC100',20,null,null,9,null)
insert into Lop values('TOIEC100',20,null,null,10,null)
insert into Lop values('TOIEC100',20,null,null,11,null)
insert into Lop values('TOIEC100',20,null,null,12,null)
insert into Lop values('TOIEC200',20,null,null,1,null)
insert into Lop values('TOIEC200',20,null,null,2,null)
insert into Lop values('TOIEC200',20,null,null,3,null)
insert into Lop values('TOIEC200',20,null,null,4,null)
insert into Lop values('TOIEC200',20,null,null,5,null)
insert into Lop values('TOIEC200',20,null,null,6,null)
insert into Lop values('TOIEC200',20,null,null,7,null)
insert into Lop values('TOIEC200',20,null,null,8,null)
insert into Lop values('TOIEC200',20,null,null,9,null)
insert into Lop values('TOIEC200',20,null,null,10,null)
insert into Lop values('TOIEC200',20,null,null,11,null)
insert into Lop values('TOIEC200',20,null,null,12,null)
insert into Lop values('TOIEC300',20,null,null,1,null)
insert into Lop values('TOIEC300',20,null,null,2,null)
insert into Lop values('TOIEC300',20,null,null,3,null)
insert into Lop values('TOIEC300',20,null,null,4,null)
insert into Lop values('TOIEC300',20,null,null,5,null)
insert into Lop values('TOIEC300',20,null,null,6,null)
insert into Lop values('TOIEC300',20,null,null,7,null)
insert into Lop values('TOIEC300',20,null,null,8,null)
insert into Lop values('TOIEC300',20,null,null,9,null)
insert into Lop values('TOIEC300',20,null,null,10,null)
insert into Lop values('TOIEC300',20,null,null,11,null)
insert into Lop values('TOIEC300',20,null,null,12,null)
insert into Lop values('TOIEC400',20,null,null,1,null)
insert into Lop values('TOIEC400',20,null,null,2,null)
insert into Lop values('TOIEC400',20,null,null,3,null)
insert into Lop values('TOIEC400',20,null,null,4,null)
insert into Lop values('TOIEC400',20,null,null,5,null)
insert into Lop values('TOIEC400',20,null,null,6,null)
insert into Lop values('TOIEC400',20,null,null,7,null)
insert into Lop values('TOIEC400',20,null,null,8,null)
insert into Lop values('TOIEC400',20,null,null,9,null)
insert into Lop values('TOIEC400',20,null,null,10,null)
insert into Lop values('TOIEC400',20,null,null,11,null)
insert into Lop values('TOIEC400',20,null,null,12,null)
insert into DangKy values(1,1,1,null,0,0)
insert into DangKy values(2,2,1,null,0,0)
insert into DangKy values(3,3,1,null,0,0)
insert into DangKy values(4,4,1,null,0,0)
insert into DiemDanh values(1,null,1,null)
insert into DiemDanh values(1,null,2,null)
insert into DiemDanh values(1,null,3,null)
insert into DiemDanh values(2,null,1,null)
insert into DiemDanh values(2,null,4,null)
insert into DiemThi values(1,1,7.5,'Khá')
insert into DiemThi values(1,2,7.5,'Khá')
insert into DiemThi values(2,1,7.5,'Khá')
insert into DiemThi values(3,1,7.5,'Khá')
insert into DiemThi values(4,2,7.5,'Khá')
insert into HocPhi values(1,600000)
insert into HocPhi values(2,600000)
insert into HocPhi values(3,650000)
insert into HocPhi values(4,650000)
insert into HocPhi values(5,800000)
insert into HocPhi values(6,750000)
insert into HocPhi values(7,600000)
insert into HocPhi values(8,600000)
insert into HocPhi values(9,650000)
insert into HocPhi values(10,650000)
insert into HocPhi values(11,800000)
insert into HocPhi values(12,750000)
insert into HoaDon values(1,1,null)
insert into HoaDon values(2,1,null)
insert into HoaDon values(3,1,null)
insert into HoaDon values(4,1,null)
insert into CTHD values(1,1,null)
insert into CTHD values(1,2,null)
insert into CTHD values(2,3,null)
insert into CTHD values(3,4,null)