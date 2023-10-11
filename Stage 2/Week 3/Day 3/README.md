# Node Exporter, Prometheus & Grafana
Dengan merujuk dengan penggunaan **Ansible** sebelumnya, maka dapat dilakukan perintah:
```for i in "monitoring-gateway.yml monitoring-appserver.yml"; do ansible-playbook $i; done```

![20231011_8](/assets/images/20231011_8.png)

1. Setelah tahapan instalasi telah selesai, maka diisi dengan akun bawaan admin dengan kata sandi
**admin**. Ubah segera apabila terekspos ke jaringan internet.

![20231011_9](/assets/images/20231011_9.png)
![20231011_10](/assets/images/20231011_10.png)

2. Masuk ke bagian ```Home > Connections > Data sources``` untuk menyetel **Prometheus** agar
dapat dibaca dengan **Grafana**, pastikan tautan yang ada sudah benar juga agar pada saat disimpan
tidak ada notifikasi kesalahan *(Error)*.

![20231011_11](/assets/images/20231011_11.png)
![20231011_12](/assets/images/20231011_12.png)

3. Setelah **Node Exporter** dan **Prometheus** telah berjalan, maka dapat masuk ke bagian ```Home >
Dashboards > New dashboards > Edit panel``` atau menambahkan visualisasi *(Visualization)* pada
panel baru.

![20231011_13](/assets/images/20231011_13.png)

Kode **PromQL** yang digunakan untuk membaca *CPU Usage* adalah:

```promql
100 - (avg by(instance)(irate(node_cpu_seconds_total{mode="idle",job="appserver"}[5m])) * 100)
```

Sedangkan kode **PromQL** yang digunakan untuk membaca *RAM Usage* adalah:

```promql
100 * (1 - ((avg_over_time(node_memory_MemFree_bytes[10m]) + avg_over_time(node_memory_Buffers_bytes[10m])) / avg_over_time(node_memory_MemTotal_bytes[10m])))
```

![20231011_14](/assets/images/20231011_14.png)

4. Untuk mengirimkan notifikasi peringatan *(Alert)* dengan menggunakan **Telegram**, dapat masuk
ke bagian ```Home > Alerting```. Penulis menggunakan tutorial dari [blog](https://rithwik.hashnode.dev/low-disk-space-alert-using-grafana-prometheus-node-exporter) dan [catatan](https://gist.github.com/dl6nm/c312acbc6fddf1a56d749e045f040ca3) ini.

![20231011_15](/assets/images/20231011_15.png)
![20231011_16](/assets/images/20231011_16.png)

5. Setelah [Bot Telegram](https://core.telegram.org/bots) telah dibuat sesuai dengan perintah
sebelumnya, maka akan dikirimkan pesan notifikasi peringatan yang ada.

![20231011_17](/assets/images/20231011_17.png)

Berkas yang relevan untuk dilihat pada saat dilakukan perintah ```ansible-playbook``` adalah:
[monitoring-appserver.yml](./monitoring-appserver.yml)
[monitoring-gateway.yml](./monitoring-gateway.yml)
