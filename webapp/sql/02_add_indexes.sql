alter table `train_timetable_master` add index idx_ddts(`date`,`departure`, `train_name`, `station`);
alter table `reservations` add index idx_dcn(`date`,`train_class`, `train_name`);
alter table `train_master` add index idx_dcn(`date`,`train_class`, `train_name`);