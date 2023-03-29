## ТЗ для DevOps

С помощью <b>Terraform</b> + <b>Ansible</b> написать инфраструктуру состоящую из <b>AWS EC2</b> Instance на <b>Ubuntu 18.04</b> c двумя сетевыми интерфейсами.

После <b>terraform apply</b> инфраструктура должна быть в таком состоянии:
   >1-й сетевой интерфейс публично доступный (<b>public</b>)   
   >2-й сетевой интерфейс для работы только внутри VPC (<b>private</b>)

К инстансу должна быть привязана роль, разрешающая <b>s3:PutObject</b> по пути <b>test-bucket/some/path</b>

На хосте должен быть установлен и запущен <b>Docker</b>.  

В Docker должен работать контейнер с <b>prometheus node_exporter</b>, который должен быть доступен внутри <b>VPC</b> но не из паблика.
