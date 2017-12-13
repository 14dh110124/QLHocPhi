using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using QLHocPhi.Model;

namespace QLHocPhi.Controllers
{   
    public class HocVienController : Controller
    {
        private QLHP db = new QLHP();

        // GET: HocVien
        public ActionResult Index()
        {
            var hocViens = db.HocViens.Include(h => h.PhiHocVien);
            return View(hocViens.ToList());
        }

        // GET: HocVien/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            HocVien hocVien = db.HocViens.Find(id);
            if (hocVien == null)
            {
                return HttpNotFound();
            }
            return View(hocVien);
        }

        // GET: HocVien/Create
        public ActionResult Create()
        {
            ViewBag.MaPhi = new SelectList(db.PhiHocViens, "MaPhi", "MaPhi");
            return View();
        }

        // POST: HocVien/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaHocVien,HoTen,DiaChi,SDT,Email,MaPhi,Delfag")] HocVien hocVien)
        {
            if (ModelState.IsValid)
            {
                db.HocViens.Add(hocVien);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MaPhi = new SelectList(db.PhiHocViens, "MaPhi", "MaPhi", hocVien.MaPhi);
            return View(hocVien);
        }

        // GET: HocVien/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            HocVien hocVien = db.HocViens.Find(id);
            if (hocVien == null)
            {
                return HttpNotFound();
            }
            ViewBag.MaPhi = new SelectList(db.PhiHocViens, "MaPhi", "MaPhi", hocVien.MaPhi);
            return View(hocVien);
        }

        // POST: HocVien/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaHocVien,HoTen,DiaChi,SDT,Email,MaPhi,Delfag")] HocVien hocVien)
        {
            if (ModelState.IsValid)
            {
                db.Entry(hocVien).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MaPhi = new SelectList(db.PhiHocViens, "MaPhi", "MaPhi", hocVien.MaPhi);
            return View(hocVien);
        }

        // GET: HocVien/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            HocVien hocVien = db.HocViens.Find(id);
            if (hocVien == null)
            {
                return HttpNotFound();
            }
            return View(hocVien);
        }

        // POST: HocVien/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            HocVien hocVien = db.HocViens.Find(id);
            db.HocViens.Remove(hocVien);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
