# Docker

## 1. Gateway Server

1.1. Login ke Server yang digunakan sebagai Gateway terlebih dahulu. Lalu pasang Docker dengan
[Instruksi](https://docs.docker.com/desktop/install/ubuntu/) atau bisa dipasang dengan
[skrip](../Challenge/docker-installer-for-ubuntu.sh).

1.2. Pastikan [Certbot](https://certbot.eff.org/instructions) untuk Sertifikat
[Let's Encrypt](https://letsencrypt.org/) juga telah dipasang di Server Gateway.

1.3. Setelah **Certbot** telah terpasang dengan benar. Pasang konfigurasi *Reverse Proxy* dengan
format untuk **NGINX**:

```nginx
server {
    server_name #hyperlink_address#;

    location / {
             proxy_pass http://#app_ip_address#:#port_address#;
    }
}
```

Lalu lakukan perintah ```certbot --nginx```.

1.4. Setelah sertifikat *HTTPS* telah dibuat dan konfigurasi *reverse proxy* telah benar, salin
sertifikat dan konfigurasi *NGINX* yang baru tersebut ke lokasi lain untuk digunakan pada *docker
volume*

```shell
mkdir -p docker/nginx docker/ssl
sudo cp /etc/letsencrypt/archive/creapy.studentdumbways.my.id/fullchain1.pem docker/ssl/creapy.studentdumbways.my.id/fullchain.pem
sudo cp /etc/letsencrypt/archive/creapy.studentdumbways.my.id/privkey1.pem docker/ssl/creapy.studentdumbways.my.id/privkey.pem
sudo cp /etc/letsencrypt/archive/api.creapy.studentdumbways.my.id/fullchain1.pem docker/ssl/api.creapy.studentdumbways.my.id/fullchain.pem
sudo cp /etc/letsencrypt/archive/api.creapy.studentdumbways.my.id/privkey1.pem docker/ssl/api.creapy.studentdumbways.my.id/privkey.pem
sudo cp /etc/nginx/conf.d/dumbways.conf docker/nginx/rproxyfe.conf
```

![20231001_1](/assets/images/20231001_1.png)

1.5. Lakukan pengunduhan *image* dari **NGINX** dengan perintah ```docker run -d --name reverse_proxy_by_nginx -p 80:80 -p 443:443 -v ~/docker/ssl:/etc/letsencrypt/live -v ~/docker/nginx:/etc/nginx/conf.d nginx```

![20231001_2](/assets/images/20231001_2.png)

1.6. Cek https://creapy.studentdumbways.my.id/

# 2. App Server

2.1. Pastikan **Docker** telah terpasang di App Server yang digunakan seperti petunjuk diatas.

2.2. Unduh aplikasi *wayshub* dengan perintah:

```shell
git clone https://github.com/dumbwaysdev/wayshub-frontend.git
git clone https://github.com/dumbwaysdev/wayshub-backend.git
```

Lalu ubah berkas pada proyek Backend sesuai dengan Database yang digunakan, maupun proyek Frontend
sesuai dengan konfigurasi *Reverse Proxy* yang ada.

2.3. Buat berkas *Dockerfile* pada masing-masing aplikasi, baik itu Backend maupun Frontend
(Pastikan kembali konfigurasi yang ada di dalam proyek sudah benar).

```dockerfile
# Frontend (wayshub-frontend/Dockerfile)
FROM node:14-alpine

WORKDIR /app
COPY . .
RUN npm install

EXPOSE 3000

CMD ["npm","start"]

# Backend (wayshub-backend/Dockerfile)
FROM node:14-alpine

WORKDIR /app
COPY . .
RUN npm install
RUN npm install -g sequelize-cli
RUN sequelize db:create
RUN sequelize db:migrate

EXPOSE 5000

CMD ["npm","start"]
```

2.4. Untuk mengakses database yang dibuat, ubah berkas ```config/config.json``` pada wayshub-backend
.

![20231001_3](/assets/images/20231001_3.png)

2.5. Unduh *Image* **MySQL** dengan perintah:

```shell
docker run -d --name wayshub-db -p 3306:3306 -e MYSQL_ROOT_PASSWORD=kelompok2 mysql
```

![20231001_4](/assets/images/20231001_4.png)

2.6. Unggah image yang telah disiapkan dengan perintah:

```shell
docker build -t dioput12/wayshub-frontend . # Disesuaikan dengan proyek yang dikerjakan.
docker images # Cek ulang nama dan versi yang dihasilkan dari perintah ini.
docker login 
docker push dioput12/wayshub-frontend # Disesuaikan dengan proyek yang dikerjakan.
```

![20231001_5](/assets/images/20231001_5.png)

2.7. Menjalankan Docker Compose dengan cara:

```shell
cd $HOME
vim docker-compose.yml
docker compose up -d # Untuk Aktivasi
docker compose down # Untuk Deaktivasi
```

![20231001_6](/assets/images/20231001_6.png)

```yml
# docker-compose.yml
version: "3.8"
services:
  db:
    image: mysql
    container_name: wayshub-db
    ports:
      - "3306:3306"
    expose:
      - 3306
    volumes:
      - ~/wayshub-db:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=alfhabet14
      - MYSQL_USER=kelompok2
      - MYSQL_PASSWORD=kelompok2
      - MYSQL_DATABASE=wayshub-db
  backend:
    image: node:14-alpine
    depends_on:
      - db
    build: ./wayshub-backend
    container_name: wayshub-be
    stdin_open: true
    ports:
      - "5000:5000"

  frontend:
    image: node:14-alpine
    build: ./wayshub-frontend
    container_name: wayshub-fe
    stdin_open: true
    ports:
      - "3000:3000"
```

2.8. Ujicoba registrasi melalui https://creapy.studentdumbways.my.id/register

![20231001_7](/assets/images/20231001_7.png)
