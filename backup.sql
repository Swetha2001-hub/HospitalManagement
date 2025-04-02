PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
INSERT INTO schema_migrations VALUES('20250318102928');
INSERT INTO schema_migrations VALUES('20250318102959');
INSERT INTO schema_migrations VALUES('20250318103234');
INSERT INTO schema_migrations VALUES('20250318103249');
INSERT INTO schema_migrations VALUES('20250318103301');
INSERT INTO schema_migrations VALUES('20250318103316');
INSERT INTO schema_migrations VALUES('20250318103340');
INSERT INTO schema_migrations VALUES('20250318104312');
INSERT INTO schema_migrations VALUES('20250318104928');
INSERT INTO schema_migrations VALUES('20250318115646');
INSERT INTO schema_migrations VALUES('20250318120447');
INSERT INTO schema_migrations VALUES('20250318120807');
INSERT INTO schema_migrations VALUES('20250319045446');
INSERT INTO schema_migrations VALUES('20250319054518');
INSERT INTO schema_migrations VALUES('20250319104506');
INSERT INTO schema_migrations VALUES('20250319113028');
INSERT INTO schema_migrations VALUES('20250319121655');
INSERT INTO schema_migrations VALUES('20250319122420');
INSERT INTO schema_migrations VALUES('20250319122933');
INSERT INTO schema_migrations VALUES('20250319171616');
INSERT INTO schema_migrations VALUES('20250320034926');
INSERT INTO schema_migrations VALUES('20250320041013');
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
INSERT INTO ar_internal_metadata VALUES('environment','development','2025-03-18 10:29:44.562266','2025-03-18 10:29:44.562269');
CREATE TABLE IF NOT EXISTS "departments" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
INSERT INTO departments VALUES(1,'caridology','2025-03-19 04:05:53.494818','2025-03-19 04:05:53.494818');
INSERT INTO departments VALUES(2,'neurology','2025-03-19 06:06:19.553441','2025-03-19 06:06:19.553441');
INSERT INTO departments VALUES(3,'radiology','2025-03-19 06:27:46.958973','2025-03-19 06:27:46.958973');
CREATE TABLE IF NOT EXISTS "doctors" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "department_id" integer NOT NULL, "qualifications" varchar, "experience" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "first_name" varchar /*application='HospitalManagementSystem'*/, "middle_name" varchar /*application='HospitalManagementSystem'*/, "last_name" varchar /*application='HospitalManagementSystem'*/, "photo" varchar /*application='HospitalManagementSystem'*/, "dob" date /*application='HospitalManagementSystem'*/, "contact_number" varchar /*application='HospitalManagementSystem'*/, "email" varchar /*application='HospitalManagementSystem'*/, "nationality" varchar /*application='HospitalManagementSystem'*/, "gender" varchar /*application='HospitalManagementSystem'*/, CONSTRAINT "fk_rails_899b01ef33"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
, CONSTRAINT "fk_rails_9949b76d4c"
FOREIGN KEY ("department_id")
  REFERENCES "departments" ("id")
);
INSERT INTO doctors VALUES(1,3,1,'MBBS','2','2025-03-19 05:47:49.118103','2025-03-19 05:47:49.118103','Ravi','Dev','Pal',NULL,'2025-03-20','8590134567','ravi@gmail.com','Indian','Male');
INSERT INTO doctors VALUES(2,5,1,'MBBS','2','2025-03-19 05:59:05.410704','2025-03-19 05:59:05.410704','Riya','Dev','D',NULL,'2025-03-02','8790654321','riya@gmail.com','Indian','Female');
INSERT INTO doctors VALUES(3,1,1,'mbbs','dfrt','2025-03-19 06:24:18.682993','2025-03-19 06:24:18.883552','vyuo','vbn','dfg',NULL,'2025-03-04','9087654323','dfg@gmil.com','indian','Male');
INSERT INTO doctors VALUES(4,12,1,'mbbs','2','2025-03-19 10:15:40.817007','2025-03-19 10:15:41.152489','gayathri','das','mk',NULL,'2025-03-12','9786654328','gayathri@gmail.com','indian','Female');
INSERT INTO doctors VALUES(5,13,1,'mbbs','3','2025-03-19 10:24:19.486775','2025-03-19 10:24:19.486775','anagha','stefen','g',NULL,'2025-03-04','8978675645','anagha@gmail.com','indian','Female');
CREATE TABLE IF NOT EXISTS "rooms" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "department_id" integer NOT NULL, "room_number" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_b3b7d14183"
FOREIGN KEY ("department_id")
  REFERENCES "departments" ("id")
);
CREATE TABLE IF NOT EXISTS "beds" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "room_id" integer NOT NULL, "bed_number" varchar, "status" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_d65c5f355a"
FOREIGN KEY ("room_id")
  REFERENCES "rooms" ("id")
);
CREATE TABLE IF NOT EXISTS "appointments" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "doctor_id" integer NOT NULL, "patient_id" integer NOT NULL, "date" datetime(6), "status" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_8db8e1e8a5"
FOREIGN KEY ("doctor_id")
  REFERENCES "doctors" ("id")
, CONSTRAINT "fk_rails_c63da04ab4"
FOREIGN KEY ("patient_id")
  REFERENCES "patients" ("id")
);
CREATE TABLE IF NOT EXISTS "active_storage_blobs" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "key" varchar NOT NULL, "filename" varchar NOT NULL, "content_type" varchar, "metadata" text, "service_name" varchar NOT NULL, "byte_size" bigint NOT NULL, "checksum" varchar, "created_at" datetime(6) NOT NULL);
INSERT INTO active_storage_blobs VALUES(1,'6vrtk118w8m8f8pw815ca3wm0dpu','WEST-BENGAL.jpg','image/jpeg','{"identified":true,"analyzed":true}','local',75299,'/Ato98i/fXcH7QS6ZsvZgw==','2025-03-19 06:24:18.744934');
INSERT INTO active_storage_blobs VALUES(2,'7nyzu7tn2lg2rpd8os0pi6wr994y','profile_pic.webp','image/webp','{"identified":true,"analyzed":true}','local',60600,'lEM//kIDxCmb4Tt53hdDhQ==','2025-03-19 10:15:40.861521');
INSERT INTO active_storage_blobs VALUES(3,'awlqgtf3dv8effzgzbpcbgz2wpee','WEST-BENGAL.jpg','image/jpeg','{"identified":true,"analyzed":true}','local',75299,'/Ato98i/fXcH7QS6ZsvZgw==','2025-03-20 04:17:57.068728');
CREATE TABLE IF NOT EXISTS "active_storage_attachments" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "record_type" varchar NOT NULL, "record_id" bigint NOT NULL, "blob_id" bigint NOT NULL, "created_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_c3b3935057"
FOREIGN KEY ("blob_id")
  REFERENCES "active_storage_blobs" ("id")
);
INSERT INTO active_storage_attachments VALUES(1,'photo','Doctor',3,1,'2025-03-19 06:24:18.751931');
INSERT INTO active_storage_attachments VALUES(2,'photo','Doctor',4,2,'2025-03-19 10:15:40.869812');
INSERT INTO active_storage_attachments VALUES(3,'photo','Patient',1,3,'2025-03-20 04:17:57.072861');
CREATE TABLE IF NOT EXISTS "active_storage_variant_records" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "blob_id" bigint NOT NULL, "variation_digest" varchar NOT NULL, CONSTRAINT "fk_rails_993965df05"
FOREIGN KEY ("blob_id")
  REFERENCES "active_storage_blobs" ("id")
);
CREATE TABLE IF NOT EXISTS "availabilities" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "doctor_id" integer NOT NULL, "start_time" datetime(6), "end_time" datetime(6), "slot_duration" integer, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_b9830dab2f"
FOREIGN KEY ("doctor_id")
  REFERENCES "doctors" ("id")
);
INSERT INTO availabilities VALUES(1,1,'2025-03-19 11:04:00','2025-03-28 11:04:00',9,'2025-03-19 11:04:22.612346','2025-03-19 11:04:22.612346');
INSERT INTO availabilities VALUES(2,5,'2025-03-19 11:04:00','2025-03-30 11:04:00',4,'2025-03-19 11:05:08.039300','2025-03-19 11:05:08.039300');
CREATE TABLE IF NOT EXISTS "patients" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "date_of_birth" date, "address" varchar, "contact_number" varchar, "gender" varchar, "blood_group" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "first_name" varchar, "middle_name" varchar, "last_name" varchar, "photo" varchar, CONSTRAINT "fk_rails_623f05c630"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
);
INSERT INTO patients VALUES(1,16,'2005-03-20','bangalore','8767899876','Female','O+','2025-03-20 04:17:57.030627','2025-03-20 04:17:57.154045','aswathi','e','p',NULL);
CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "reset_password_token" varchar, "reset_password_sent_at" datetime(6), "remember_created_at" datetime(6), "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "role" integer DEFAULT 0 NOT NULL);
INSERT INTO users VALUES(1,'admin@example.com','$2a$12$cf9vXdp8aG6zpn3xDFvbpuFDFE4DJaI3eV6l4wxB7l0zWmT5IqZbO',NULL,NULL,NULL,'2025-03-18 12:25:12.976198','2025-03-19 07:20:34.712496',0);
INSERT INTO users VALUES(2,'ashok@gmail.com','$2a$12$fr6.mlNtkmgrm7p6l2LmLOmYQhjgtvB/GCdGVQOAqvCEPecera2o6',NULL,NULL,NULL,'2025-03-19 05:43:10.588958','2025-03-19 05:43:10.588958',1);
INSERT INTO users VALUES(3,'ravi@gmail.com','$2a$12$gH80PjldDsjfs7IhCF7m9elRUK9P1AstIEwRJDV.gue86C9i96/SO',NULL,NULL,NULL,'2025-03-19 05:46:34.538307','2025-03-19 05:46:34.538307',1);
INSERT INTO users VALUES(4,'sayath@gmail.com','$2a$12$pcHI29ECBIA9IjELhINiQ.Stl/2iP3afbiwr75umGb4.K7oMuOybS',NULL,NULL,NULL,'2025-03-19 05:50:56.520099','2025-03-19 05:50:56.520099',1);
INSERT INTO users VALUES(5,'riya@gmail.com','$2a$12$QgRN8cjmO2it0iVqu.ijQeClN0fRFDdt/2/HMvHulcZ4r/fW.Uzq6',NULL,NULL,NULL,'2025-03-19 05:54:22.643129','2025-03-19 05:54:22.643129',1);
INSERT INTO users VALUES(6,'swethakal@gmail.com','$2a$12$NnwVDd4dTtsw5dNGzZA9luSDNsDAdOTb0ugZy.L/dXBUhSFinSd2S',NULL,NULL,NULL,'2025-03-19 09:32:34.208596','2025-03-19 09:32:34.208596',1);
INSERT INTO users VALUES(7,'swe@gmail.com','$2a$12$WHOja5OW59d1YEaawpyl.eY9vIw9tNKV8wvwKfMG98F67CQdNM/Km',NULL,NULL,NULL,'2025-03-19 09:33:04.103306','2025-03-19 09:33:04.103306',1);
INSERT INTO users VALUES(8,'sana@gmail.com','$2a$12$eDbQcsheyH7.fN5f8B2dV.O9jaE9jlWUFR3ZB8nJofcYFh6ozcVc6',NULL,NULL,NULL,'2025-03-19 09:51:47.203187','2025-03-19 09:51:47.203187',1);
INSERT INTO users VALUES(9,'preethi@gmail.com','$2a$12$jeKsNldKwIv8inNYWAVUBe/8Wq8lVUy1NT5iPo3RsErthGGS5Fblq',NULL,NULL,NULL,'2025-03-19 09:58:11.754666','2025-03-19 09:58:11.754666',1);
INSERT INTO users VALUES(10,'abc@gmail.com','$2a$12$MszIx36Zw25xmkz1truY.upSo73IDFe.CWxBDFW5b6Cu4nYSHK85O',NULL,NULL,NULL,'2025-03-19 10:01:49.406572','2025-03-19 10:01:49.406572',1);
INSERT INTO users VALUES(11,'athira@gmail.com','$2a$12$LMSIF75KjmLkGPLJFHz1qepWHgc741bxXi1R8kDaPC/k5jkJtssw.',NULL,NULL,NULL,'2025-03-19 10:05:57.495648','2025-03-19 10:05:57.495648',1);
INSERT INTO users VALUES(12,'gayathri@gmail.com','$2a$12$F2uIc0Vgr6XBRVXCvKjMxuMvx6NZJsyaWbLIk4XntYp6UvTSWLVTK',NULL,NULL,NULL,'2025-03-19 10:15:40.810530','2025-03-19 10:15:40.810530',1);
INSERT INTO users VALUES(13,'anagha@gmail.com','$2a$12$yVWwo1zCX8H3KH5FS2T3LOMKghvP527Gi.CcRiN9TILYpUf/WcUHu',NULL,NULL,NULL,'2025-03-19 10:24:19.480161','2025-03-19 10:24:19.480161',1);
INSERT INTO users VALUES(14,'diya@gmail.com','$2a$12$hVyOf6bFQvY19Nt2ag6u0.JlRWBWc8mAP/jYycS2DgBscVdG/TKZK',NULL,NULL,NULL,'2025-03-20 04:12:32.088047','2025-03-20 04:12:32.088047',0);
INSERT INTO users VALUES(15,'reenu@gmail.com','$2a$12$iqiYYegIwNy/tHfc/pswrOwTce.XQNluA.sPWbks1RuZgUjkuBRyq',NULL,NULL,NULL,'2025-03-20 04:15:34.223700','2025-03-20 04:15:34.223700',0);
INSERT INTO users VALUES(16,'aswathi@gmail.com','$2a$12$ePLZMVbztKrQlbGw8tZlPO3lTPwXQjdyEMOQKeBPiLOxTOEbn3d.i',NULL,NULL,NULL,'2025-03-20 04:17:56.978343','2025-03-20 04:17:56.978343',0);
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('departments',3);
INSERT INTO sqlite_sequence VALUES('doctors',5);
INSERT INTO sqlite_sequence VALUES('active_storage_blobs',3);
INSERT INTO sqlite_sequence VALUES('active_storage_attachments',3);
INSERT INTO sqlite_sequence VALUES('availabilities',2);
INSERT INTO sqlite_sequence VALUES('patients',1);
INSERT INTO sqlite_sequence VALUES('users',16);
CREATE INDEX "index_doctors_on_user_id" ON "doctors" ("user_id") /*application='HospitalManagementSystem'*/;
CREATE INDEX "index_doctors_on_department_id" ON "doctors" ("department_id") /*application='HospitalManagementSystem'*/;
CREATE INDEX "index_rooms_on_department_id" ON "rooms" ("department_id") /*application='HospitalManagementSystem'*/;
CREATE INDEX "index_beds_on_room_id" ON "beds" ("room_id") /*application='HospitalManagementSystem'*/;
CREATE INDEX "index_appointments_on_doctor_id" ON "appointments" ("doctor_id") /*application='HospitalManagementSystem'*/;
CREATE INDEX "index_appointments_on_patient_id" ON "appointments" ("patient_id") /*application='HospitalManagementSystem'*/;
CREATE UNIQUE INDEX "index_active_storage_blobs_on_key" ON "active_storage_blobs" ("key") /*application='HospitalManagementSystem'*/;
CREATE INDEX "index_active_storage_attachments_on_blob_id" ON "active_storage_attachments" ("blob_id") /*application='HospitalManagementSystem'*/;
CREATE UNIQUE INDEX "index_active_storage_attachments_uniqueness" ON "active_storage_attachments" ("record_type", "record_id", "name", "blob_id") /*application='HospitalManagementSystem'*/;
CREATE UNIQUE INDEX "index_active_storage_variant_records_uniqueness" ON "active_storage_variant_records" ("blob_id", "variation_digest") /*application='HospitalManagementSystem'*/;
CREATE INDEX "index_availabilities_on_doctor_id" ON "availabilities" ("doctor_id") /*application='HospitalManagementSystem'*/;
CREATE INDEX "index_patients_on_user_id" ON "patients" ("user_id") /*application='HospitalManagementSystem'*/;
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email") /*application='HospitalManagementSystem'*/;
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token") /*application='HospitalManagementSystem'*/;
COMMIT;
