# 1. Deploy Wayshub

## 1.1. Pembuatan VM di IDCloudHost
Berikut adalah spesifikasi VM [IDCloudHost](https://console.idcloudhost.com/hub/login) yang
digunakan:

> Processor: 2 vCPU,
> 
> Memory: 2GB RAM,
>
> Storage: 20GB,
> 
> Operating System: Ubuntu 20.04 LTS

![20230925_1](/assets/images/20230925_1.png)
![20230925_2](/assets/images/20230925_2.png)

## 1.2. Pemasangan Aplikasi di VM
Disini menggunakan ```fnm``` yang skripnya berada di[sini](https://fnm.vercel.app/install) (Pastikan
**curl** dan **unzip** telah terpasang). Sesi terminal dapat dimuat ulang dengan:

```shell
source $HOME/.bashrc
```

Langsung bisa dipasang **NodeJS** versi 14 agar digunakan pada aplikasi Wayshub.

```shell
fnm install 14 && \
fnm default 14
```

![20230925_3](/assets/images/20230925_3.png)

## 1.3. Instalasi PM2 dan Penggunaan PM2
Program **PM2** *(JavaScript)* digunakan untuk menangani sesi program yang berjalan agar lebih
tertata rapi. Dipasang dengan cara:

```shell
npm install -g pm2
```

Lalu menjalankan:

```shell
pm2 ecosystem simple; \
pm2 start
```

Agar bisa tertata dengan rapi, aturlah berkas ```ecosystem.config.js``` pada aplikasi
[wayshub-backend](https://github.com/dumbwaysdev/wayshub-backend) dan
[wayshub-frontend](https://github.com/dumbwaysdev/wayshub-frontend) sesuai kebutuhan.

![20230925_4](/assets/images/20230925_4.png)
![20230925_5](/assets/images/20230925_5.png)

## 1.4. Installasi MySQL (Database)
Setelah pemasangan dan pengamanan MySQL dengan cara:

```shell
sudo apt install mysql-server; \
sudo mysql_secure_installation; \
sudo mysql -u root
```
![20230925_6](/assets/images/20230925_6.png)
![20230925_7](/assets/images/20230925_7.png)

Maka masuklah untuk sementara waktu di akun Pangkalan Data *(Database)* dengan akses penuh untuk
menjalankan perintah ini:
(**PERINGATAN**: Berhati-hatilah dalam menggunakan akun *root* karena bisa sangat berbahaya jika
tidak digunakan secara bijak dan peninjauan ulang)

```mysql
CREATE USER 'dio'@'%' IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON *.* TO 'dio'@'%' WITH GRANT OPTION;
```

![20230925_8](/assets/images/20230925_8.png)

## 1.5. Menyetel API dan Menyiapkan ORM pada Aplikasi Wayshub
Setelah menjalankan ```npm install```, maka ubah berkas ```src/config/api.js``` agar diubah ke
alamat yang diinginkan. Disini penulis menggunakan *api[dot]dio[dot]studentdumbways[dot]my[dot]id*
sebagai alamat dari backend.

![20230925_9](/assets/images/20230925_9.png)

Lalu untuk backend, ubah berkas ```config/config.json``` mirip seperti ini:

```json
"username": "dio",
"password": "password",
"database": "db-wayshub",
```

![20230925_10](/assets/images/20230925_10.png)

Untuk persiapan untuk instalasi *ORM (Object-Relational Mapping)* dengan **Sequelize**, pasang
dengan:

```shell
npm install -g sequelize-cli
```

Untuk inisialiasi Pangkalan Data *(Database)*, lakukan perintah:

```shell
sequelize db:create && \
sequelize db:migrate
```

![20230925_11](/assets/images/20230925_11.png)

# 2. Gateway NGINX

## 2.1. Pembuatan VM di IDCloudHost
Berikut adalah spesifikasi VM [IDCloudHost](https://console.idcloudhost.com/hub/login) yang
digunakan:

> Processor: 2 vCPU,
> 
> Memory: 2GB RAM,
>
> Storage: 20GB,
> 
> Operating System: Ubuntu 20.04 LTS

## 2.2. Pemasangan NGINX
Setelah melakukan perintah:

```shell
sudo apt install nginx
```

Maka yang diperlukan adalah konfigurasi yang bisa dibaca oleh **nginx**, seperti menyetel berkas
```/etc/nginx/nginx.conf``` atau langsung membuat berkas pada direktori ```/etc/nginx/conf.d/```.

![20230925_12](/assets/images/20230925_12.png)
![20230925_13](/assets/images/20230925_13.png)

```nginx
server {
    server_name #hyperlink_address#;

    location / {
             proxy_pass http://#app_ip_address#:#port_address#;
    }
}
```

## 2.3. Menambahkan DNS pada Cloudflare
Agar dapat diakses dengan [Cloudflare](https://dash.cloudflare.com/login), maka tambahkan alamat IP
Publik dari VM Gateway yang dibuat.

![20230925_14](/assets/images/20230925_14.png)
![20230925_15](/assets/images/20230925_15.png)

## 2.4. Memasang Certbot
[Certbot](https://certbot.eff.org/instructions) berguna untuk memasang sertifikat
[Let's Encrypt](https://letsencrypt.org) yang mengamankan trafik aplikasi yang terkoneksi dengan
internet via jalur aman **(HTTPS)**. Program ini dapat dipasang melalui:

```shell
sudo snap install --classic certbot; \
sudo ln -s /snap/bin/certbot /usr/bin/certbot; \
sudo certbot --nginx
```

![20230925_16](/assets/images/20230925_16.png)
![20230925_17](/assets/images/20230925_17.png)
