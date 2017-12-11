use QLHocPhi
--View: Xem 2 học viên cao điểm nhất trong lớp
CREATE VIEW HaiHVCaoDiemNhat AS
SELECT * FROM DBO.DiemThi WHERE XepHang = '1' OR XepHang = '2'

--select * from dbo.DiemThi
--SELECT * FROM HaiHVCaoDiemNhat

---------------------------------------------------------------

--Trigger: Không xóa học viên đang học hoặc đang bảo lưu
alter TRIGGER Trg_KoXoaHV
ON HocVien
FOR UPDATE
AS
BEGIN
	DECLARE @DEL INT = (SELECT Delfag FROM INSERTED)
	DECLARE @NGAYHNAY DATETIME = GETDATE()
	DECLARE @PHIHV INT = (SELECT PhiHocVien from INSERTED)
	DECLARE @MaHV INT = (SELECT MaHocVien FROM INSERTED)
	DECLARE @MaLop INT = (SELECT MaLop FROM DangKy WHERE @MaHV = MaHocVien)
	IF (@DEL = 1)
	BEGIN
		IF ((SELECT NgayBaoLuu FROM PhiHocVien WHERE @PHIHV = MaPhi) > @NGAYHNAY)
		BEGIN
			print('HOC VIEN DANG BAO LUU')
			rollback tran
		END
		ELSE IF ((SELECT Ngay_KT FROM LOP WHERE @MaLop = MaLop) > @NGAYHNAY )
		BEGIN
			print('HOC VIEN VAN CON HOC')
			rollback tran
		END
	END
END

--select * from [dbo].[HocVien]
--select * from [dbo].[PhiHocVien]
--select * from [dbo].[Lop]
--select * from DangKy
--insert into DangKy values(5,5,1,null,0,1)
--insert into HocVien values(N'PDSn',N'5DSDC Q5 TP.HCM','01686324111','sDazy@gmail.com', 2, 1)
--insert into PhiHocVien values(100000,10000,0,1,'1/1/2018')


--UPDATE HocVien SET Delfag = 1 WHERE MaHocVien = 4
--UPDATE LOP SET Ngay_KT ='1/1/2018' WHERE MaLop = 1
