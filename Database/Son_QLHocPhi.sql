use QLHocPhi
--View: Xem 2 học viên cao điểm nhất trong lớp
ALTER VIEW HaiHVMAXDIEM AS
SELECT MAHOCVIEN,DIEM,MALOP FROM XEPHANG WHERE HANG IN (1,2)

ALTER VIEW XEPHANG AS
SELECT DENSE_RANK() OVER (PARTITION BY MALOP ORDER BY DIEM)  AS [HANG],MaHocVien,Diem,MaLop FROM DiemThi

--select * from dbo.DiemThi
SELECT * FROM HaiHVMAXDIEM
SELECT * FROM XEPHANG

---------------------------------------------------------------

--Trigger: Không xóa học viên đang học hoặc đang bảo lưu

alter TRIGGER Trg_KoXoaHV
ON HocVien
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @DEL INT = (SELECT Delflag FROM DELETED)
	DECLARE @NGAYHNAY DATETIME = GETDATE()
	DECLARE @PHIHV INT = (SELECT PhiHocVien from DELETED)
	DECLARE @MaHV INT = (SELECT MaHocVien FROM DELETED)
	DECLARE @MaLop INT = (SELECT MaLop FROM DangKy WHERE @MaHV = MaHocVien)
	IF ((SELECT NgayBaoLuu FROM PhiHocVien WHERE @PHIHV = MaPhi) > @NGAYHNAY)
	BEGIN
		raiserror('HOC VIEN DANG BAO LUU',16,1)
		rollback tran
	END
	ELSE IF ((SELECT Ngay_KT FROM LOP WHERE @MaLop = MaLop) > @NGAYHNAY )
	BEGIN
		raiserror('HOC VIEN VAN CON HOC',16,1)
		rollback tran
	END
	ELSE
	BEGIN
		UPDATE HOCVIEN SET Delflag = 1 WHERE @MaHV = MaHocVien
	END
END

DELETE FROM HocVien WHERE MaHocVien = 1

--select * from [dbo].[HocVien]
--select * from [dbo].[PhiHocVien]
--select * from [dbo].[Lop]
--select * from DangKy
--insert into DangKy values(5,5,1,null,0,1)
--insert into PhiHocVien values(100000,10000,0,'1/1/2018')

--update HocVien set Delflag = 0 where MaHocVien = 1
--update HocVien set PhiHocVien = 1 where MaHocVien = 1
--update PhiHocVien set NgayBaoLuu = '1/1/2018'
--UPDATE LOP SET Ngay_KT ='10/10/2017' WHERE MaLop = 1
-- Xóa học viên, cập nhật delflag lên 1

------------------------------------------------------------

-- Giao tác: Chuyển lớp
-- Mô tả:
--Học viên chuyển lớp thành công
--1. Giảm sỉ số lớp cũ -1
--2. Tăng sỉ số lớp mới +1
--3. DangKy.ChuyenLop +1

CREATE PROC ChuyenLop @MaHV int, @MaLopCu int, @MaLopMoi int
AS
BEGIN
	IF ((SELECT ChuyenLop FROM DangKy WHERE MaHocVien = @MaHV AND MaLop = @MaLopCu) < 2 AND
		(SELECT SiSo FROM LOP WHERE MaLop = @MaLopMoi) < 20 AND
		@MaLopCu != @MaLopMoi)
	BEGIN
		UPDATE DangKy SET ChuyenLop += 1 WHERE DangKy.MaHocVien=@MaHV AND MaLop = @MaLopCu
		UPDATE DangKy SET MaLop = @MaLopMoi WHERE DangKy.MaHocVien=@MaHV AND MaLop = @MaLopCu
		UPDATE LOP SET SiSo -=1 WHERE MaLop = @MaLopCu
		UPDATE LOP SET SiSo +=1 WHERE MaLop = @MaLopMoi
	END
	ELSE
	BEGIN
		RAISERROR('KHONG THE CHUYEN HOC VIEN NAY!',16,1)
	END
END
--
EXEC ChuyenLop 3,3,1

--select * from DangKy
--select * from Lop
