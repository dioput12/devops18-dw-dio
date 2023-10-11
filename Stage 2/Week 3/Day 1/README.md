# Terraform
Pemasangan **Terraform** dapat merujuk pada [dokumentasi](https://developer.hashicorp.com/terraform/tutorials/docker-get-started/install-cli) disini.
Setelah terpasang dengan baik, bisa digunakan untuk mengunduh proyek *WaysHub*.
1. Setelah berkas [main.tf](./main.tf) telah dibuat, maka lakukan perintah ```terraform init```
untuk proses awal inisialisasi proyek dengan **Terraform**.

![20231011_1](/assets/images/20231011_1.png)

2. Perencanaan dengan opsi-opsi untuk menjalankan proyek dapat dilakukan dengan perintah
```terraform plan```.

![20231011_2](/assets/images/20231011_2.png)

3. Setelah yakin tidak ada perubahan yang diperlukan, maka lakukan perintah ```terraform apply```
dan mengetik **yes** pada saat ditanykan oleh **Terraform**.

![20231011_3](/assets/images/20231011_3.png)
![20231011_4](/assets/images/20231011_4.png)

4. Masuk ke program Penjelah *(Browser)* Internet dengan alamat http://localhost:3000

![20231011_5](/assets/images/20231011_5.png)

5. Setelah proyek yang dijalankan **Terraform** hendak dihancurkan, dapat dilakukan perintah
```terraform destroy```.

![20231011_6](/assets/images/20231011_6.png)
