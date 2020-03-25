# apache_failfix.service
systemd unit.service and bash script to fix and restart apache after failed start/state

[![Lizenz](https://img.shields.io/github/license/lfkdev/apache_failfix.service)](https://github.com/lfkdev/apache_failfix.service)

<p align="center">
  <img src="https://github.com/lfkdev/apache_failfix.service/blob/master/illustration_img.png?raw=true" alt="illustration"/>
</p>

Either use an override file or just place the onFailure line in your apache2.service
```
$ systemctl edit (--full) apache2.service
```

After that just place the script in /usr/local/bin/ (or wherever you like) and create the apache_failfix.service
```
$ systemctl --full --force apache_failfix.service
```
and paste the content in it (or copy the file from the repo to /etc/systemd/system/apache_failfix.service (debian/ubntu))
now after an apache restart, next time your apache fails it will restart automatically

note: if you want to recieve an email when this unit got triggered you have to adjust the bash file (where the mail comment is)
