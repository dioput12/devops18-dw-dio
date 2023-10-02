# Jenkins
1. Setelah mengunduh *(Download)* Jenkins melalui Docker (Penulis menggunakan versi *lts-jdk17*)
. Ketikkan perintah:

```shell
docker run -d -p 8080:8080 -p 50000:50000 --name jenkins_ci jenkins/jenkins:lts-jdk17 # Jenkins
docker logs jenkins_ci # Melihat aktivasi Jenkins yang berjalan
```

![20231002_1](/assets/images/20231002_1.png)

2. Akan ditanyakan kata sandi *(Password)* untuk akun **admin** dalam sesi tahap awal instalasi 
Jenkins. Kata sandi ini berada dalam berkas ```/var/jenkins_home/secrets/initialAdminPassword```
di dalam Kontainer *(Container)* Jenkins yang bekerja.

![20231002_2](/assets/images/20231002_2.png)

3. Pada tahap pemasangan program tambahan *(Plugin)* di dalam Jenkins, pilih **Install suggested
plugins** jika ingin memasang semua *Plugins* yang direkomedasikan oleh komunitas Jenkins atau
pilih **Select plugins to install** jika ingin beberapa *Plugins* yang dipasang di dalam Jenkins.

![20231002_3](/assets/images/20231002_3.png)

4. Disini Penulis hanya ingin menambahkan **SSH Agents and SSH Build Agents** di dalam Jenkins yang
berjalan.

![20231002_4](/assets/images/20231002_4.png)

5. Pada saat tampilan ini muncul, berarti Jenkins sedang memasang *Plugins* yang akan digunakan.
Perhatikan selain dari **SSH Agents**, pastikan terdapat **GitHub Plugins** untuk penyambung
Akun *GitHub* dengan Repositori Perangkat Lunak *(Software Repository)* yang akan digunakan.

![20231002_5](/assets/images/20231002_5.png)

6. Isi bagian ini sesuai dengan data yang ada atau lewati bagian ini jika hanya butuh akun *admin*
bawaan *(Default)*.

![20231002_6](/assets/images/20231002_6.png)

7. Isi bagian ini dengan format ```http://<jenkins_ip_or_url>:<port>```.

![20231002_7](/assets/images/20231002_7.png)

8. Pemasangan Jenkins telah selesai, akan langsung masuk dengan akun *admin*.

![20231002_8](/assets/images/20231002_8.png)

9. Ini adalah tampilan Jenkins saat pertama kali dipasang. Isi konfigurasi dan kredensial repositori
dengan benar dan teliti.

![20231002_9](/assets/images/20231002_9.png)

10. Pada saat konfigurasi dan kredensial repositori telah dipasang di dalam Jenkins, masuk ke
repositori *GitHub* dari proyek yang ada agar dikirim perintah *(Request)* oleh *GitHub*. Lalu isi
*Webhook* dengan format:
```http://<jenkins_ip_or_url>:<port>/github-webhook/```

![20231002_10](/assets/images/20231002_10.png)

