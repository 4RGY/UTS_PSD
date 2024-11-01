program belajar;

uses crt;

type
  PMahasiswa = ^Mahasiswa;
  Mahasiswa = record
    nama: string;
    nomor_identitas: string;
    next: PMahasiswa;
  end;

var
  head: PMahasiswa;

function CekDuplikat(nomor_identitas: string): boolean;
var
  current: PMahasiswa;
begin
  current := head;
  while current <> nil do
  begin
    if current^.nomor_identitas = nomor_identitas then
    begin
      CekDuplikat := true;
      exit;
    end;
    current := current^.next;
  end;
  CekDuplikat := false;
end;

procedure TambahMahasiswa(nama, nomor_identitas: string);
var
  mahasiswa_baru, current: PMahasiswa;
begin
  if CekDuplikat(nomor_identitas) then
  begin
    writeln('Error: Mahasiswa dengan NPM ', nomor_identitas, ' sudah ada. Tidak dapat menambahkan data.');
    exit;
  end;

  New(mahasiswa_baru);
  mahasiswa_baru^.nama := nama;
  mahasiswa_baru^.nomor_identitas := nomor_identitas;
  mahasiswa_baru^.next := nil;

  if head = nil then
    head := mahasiswa_baru
  else
  begin
    current := head;
    while current^.next <> nil do
      current := current^.next;
    current^.next := mahasiswa_baru;
  end;
  writeln('Mahasiswa ', nama, ' dengan ID ', nomor_identitas, ' berhasil ditambahkan.');
end;

procedure TampilkanMahasiswa;
var
  current: PMahasiswa;
begin
  if head = nil then
    writeln('Tidak ada mahasiswa di kelas reguler.')
  else
  begin
    writeln('Daftar Mahasiswa:');
    writeln('=====================');
    current := head;
    while current <> nil do
    begin
      writeln('Nama: ', current^.nama, ', ID: ', current^.nomor_identitas);
      current := current^.next;
    end;
    writeln('=====================');
  end;
end;

procedure CariMahasiswa(nomor_identitas: string);
var
  current: PMahasiswa;
  ditemukan: boolean;
begin
  ditemukan := false;
  current := head;
  while current <> nil do
  begin
    if current^.nomor_identitas = nomor_identitas then
    begin
      writeln('Mahasiswa ditemukan: Nama: ', current^.nama, ', ID: ', current^.nomor_identitas);
      ditemukan := true;
      break;
    end;
    current := current^.next;
  end;

  if not ditemukan then
    writeln('Mahasiswa tidak ditemukan.');
end;

procedure HapusMahasiswa(nomor_identitas: string);
var
  current, prev: PMahasiswa;
  ditemukan: boolean;
begin
  ditemukan := false;
  current := head;
  prev := nil;

  while current <> nil do
  begin
    if current^.nomor_identitas = nomor_identitas then
    begin
      if prev = nil then
        head := current^.next
      else
        prev^.next := current^.next;

      Dispose(current);
      writeln('Mahasiswa dengan ID ', nomor_identitas, ' berhasil dihapus.');
      ditemukan := true;
      break;
    end;
    prev := current;
    current := current^.next;
  end;

  if not ditemukan then
    writeln('Mahasiswa tidak ditemukan.');
end;

procedure UrutkanMahasiswa;
var
  i, j: PMahasiswa;
  tempNama, tempID: string;
begin
  if (head = nil) or (head^.next = nil) then
  begin
    writeln('Tidak cukup data untuk diurutkan.');
    exit;
  end;

  i := head;
  while i <> nil do
  begin
    j := i^.next;
    while j <> nil do
    begin
      if i^.nama > j^.nama then
      begin
        tempNama := i^.nama;
        tempID := i^.nomor_identitas;
        i^.nama := j^.nama;
        i^.nomor_identitas := j^.nomor_identitas;
        j^.nama := tempNama;
        j^.nomor_identitas := tempID;
      end;
      j := j^.next;
    end;
    i := i^.next;
  end;
  writeln('Daftar mahasiswa berhasil diurutkan berdasarkan nama.');
end;

procedure Menu;
var
  pilihan: integer;
  nama, nomor_identitas: string;
begin
  repeat
    clrscr;
    writeln('Menu:');
    writeln('1. Tambah Mahasiswa');
    writeln('2. Tampilkan Mahasiswa');
    writeln('3. Cari Mahasiswa');
    writeln('4. Hapus Mahasiswa');
    writeln('5. Urutkan Mahasiswa');
    writeln('6. Keluar');
    write('Pilih menu: ');
    readln(pilihan);

    case pilihan of
      1: begin
           write('Masukkan nama mahasiswa: ');
           readln(nama);
           write('Masukkan nomor identitas: ');
           readln(nomor_identitas);
           TambahMahasiswa(nama, nomor_identitas);
           readln;
         end;
      2: begin
           TampilkanMahasiswa;
           readln;
         end;
      3: begin
           write('Masukkan nomor identitas yang ingin dicari: ');
           readln(nomor_identitas);
           CariMahasiswa(nomor_identitas);
           readln;
         end;
      4: begin
           write('Masukkan nomor identitas yang ingin dihapus: ');
           readln(nomor_identitas);
           HapusMahasiswa(nomor_identitas);
           readln;
         end;
      5: begin
           writeln('Sebelum diurutkan:');
           TampilkanMahasiswa;
           UrutkanMahasiswa;
           writeln('Setelah diurutkan:');
           TampilkanMahasiswa;
           readln;
         end;
      6: writeln('Terima kasih. Program selesai.');
    else
      writeln('Pilihan tidak valid.');
      readln;
    end;
  until pilihan = 6;
end;

begin
  head := nil;
  Menu;
end.
