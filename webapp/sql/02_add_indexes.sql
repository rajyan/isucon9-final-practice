alter table `train_timetable_master` add index idx_dtsd(`date`,`train_name`, `station`, `departure`);
alter table `reservations` add index idx_dcn(`date`,`train_class`, `train_name`);
alter table `reservations` add index idx_u(`user_id`);
alter table `train_master` add index idx_dcn(`date`,`train_class`, `train_name`);
alter table `seat_reservations` add index idx_r(`reservation_id`);
alter table `users` add index idx_r(`email`);
