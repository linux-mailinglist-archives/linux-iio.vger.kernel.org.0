Return-Path: <linux-iio+bounces-21983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D13CBB10DD5
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 16:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40963BF6B3
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E672E1741;
	Thu, 24 Jul 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2KZ/sce"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45A1632C8;
	Thu, 24 Jul 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368002; cv=none; b=rLDlY9rjc2+ietHGxP2pDibj/DTONlyZagBh0fuzTa/5NxkdUQTnNsm0JuAHs0s4L3olYnFX+cy8O1imwu4xAA7h/M0k9wvHudzRUTaySywOXTQk2bifEaQje6i9wfg9cEboRY1P1gGY70FhqdTRhfd22kT/6wrS+d2XvOB3UtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368002; c=relaxed/simple;
	bh=o+kEQhU3S2pcGCxHCuqO5OWwudSoEGKiLAfLUH0NSXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kTaphXeGwCPp7bkXEk513qysGm9Q36QsMZ2iSrYNEBQE/om9WvI8eYTGBt64xq3R02B8X3zmmhnVzuiaIAbno7R81gk7b5gSd/TKwa2YmZiZz3Etj6nhL0a94YBvIcNsYOBzXa+pHZ8eTligrs0Q9MGF08l3ZgbzKUkuMPf1HAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2KZ/sce; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b34c068faf8so1157728a12.2;
        Thu, 24 Jul 2025 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753368000; x=1753972800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iV+Dvei1P7nUZxWaxTa8jdfKWi1saPTrRj8PFk5mfwY=;
        b=E2KZ/sceYjQkd5FdMVoUrxPNgdZqcUAn+eQUohizKsNlDdSuTnHohmE9nuF/oVijzI
         JLRUtJqJgEE1o+DIHDvJ/ztf7CTqIp2Di+wO4h7Yc/vsEK8WIlYmDuoOm4hU/hjxF62v
         hFthpmQ4AI9Hp3axR6G03+ERVsduXxXRqP6gxuesyhsXZyh9L2rozDdj7RZwYcPjUTru
         4RdGqaeyD5Ik4b/m3tapUP3/0uqpIpxtuybVim5+UHraUURP7SYH1e3OY4a0jSiSmhev
         ia2+plnJy8lBDqdmhH4CiqjI2Fvw7qx/Hmlvdb7zFq7GYF0Gn9VLgZUChYmHCFCHH5qv
         c9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753368000; x=1753972800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iV+Dvei1P7nUZxWaxTa8jdfKWi1saPTrRj8PFk5mfwY=;
        b=kYMDHwZxa4C7v7dJFUdB3kjU2tIZ8f3zYSI2WFjQuxm7x78zyDP8A5yK9HWOXOQIpy
         IVgTekJ2FEEpPLsdszhKuQsaqpvIfz3pNNs0p2HTRVq0z6JSIhQRFLYOnLMopxmY0RqU
         NFoIwcSIg7FCFSwo0VI9WpiUoa+Ygcs3Q6pZEualmKZFnOTqgMbutuJX0UtP4X+34HZq
         hVLMtcjymc0UzqAstyaga5newz6lzpMw+heFJNslQDfYQzpTlluEOVMVo1YPYk+OIobn
         LyS1tVun8xxMEOuJvdMBYC09F3vMx/qinKCkHB7dSKi9/z6EX8mvm88kihgdqQRPePVs
         2/3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDwz7G3lZckWqiLJZ0l1zTu942sp1VthEbynxRAquO6CIM2HD9FW5xt2ZWZ08q48cPYEM3VHiNZei+6uHj@vger.kernel.org, AJvYcCX/Hn0+tq1YWGL9F/X55+LYRGj9tGUxGVqlOFJAFbh4ImuIqOSvdGAch/OzkpcrVnYCMjaTDbUWZJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDo8vvxiECSRFkZJfhdMZCHy8Qo/JyRSKEIQ6kx92ud/4R/4u
	1ZdimzV4nLgRJNS+9xZVaQSnmKqQPIpfgpFdwxtCGDmdVcVwfaxdoo0O0DNBNA==
X-Gm-Gg: ASbGnctp2CmJ2cVombOzR6bStfCll/Gjc4ccNPvmWDen6dPctCYybR3XdhiPBGmYO+l
	TXTmJQ2dYzcQhTrki5RIcccr6NEMLhM/74OIYDg5oykm7Q1wONZw1xr+CMbwHWm2IMISyQE+M4w
	t02waRM/SG9ow8XQB9+Q6z9WIk8pLVocDIwNGwiE4wgGqm3ItQZ++nvMiEhIa/9FbcyNw87845B
	Owxpvb58Huk6vldAnwd8sOY9OC+WaHyK9cucrT8LxH6WI9sVHwTKySMxC6lPvLHDbPn4dDxYB/z
	7JqLkAms0V2AyfdWqWzPrlVgpS/u+jAQb2sbEgWX9CgaiKUs5nZq0erij0tnlMb4XZmqy640xG4
	Sj2pr/gdOSNWq2opbsEqvo1EsR7VK49rkfJcI
X-Google-Smtp-Source: AGHT+IEUAIWPIMFIyJTKIvhkHOz23j0nXCw2/i5Dk42uzRSNt8zQozTXG9pVq/7CZoJTt56nQxvoSw==
X-Received: by 2002:a17:903:3d0f:b0:238:2437:ada8 with SMTP id d9443c01a7336-23f981d581cmr98407485ad.48.1753367999733;
        Thu, 24 Jul 2025 07:39:59 -0700 (PDT)
Received: from akshayaj-lenovo.. ([2401:4900:883b:7064:100f:e691:b91:3524])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc89bsm17306035ad.103.2025.07.24.07.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:39:59 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: anshulusr@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: light: ltr390: Add debugfs register access support
Date: Thu, 24 Jul 2025 20:09:39 +0530
Message-ID: <20250724143945.636380-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for debugfs_reg_access through the driver's iio_info structure
to enable low-level register read/write access for debugging.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---

Changes since v2:
================
- merged the regmap_range of LTR390_UP_THRESH with LTR390_LOW_THRESH.

Changes since v1:
=================
- Replaced _[0|1|2] macros with a respective common parameterized macro.
- Retained base macros to avoid churn.
- Swapped regmap_write with regmap_read to avoid negate operator.
- Simplified debugfs function by directly returning return value of
  regmap_[read|write].
- Replaced [readable|writeable]_reg with regmap ranges by using
  [rd|wr]_table property of regmap_config.
- Updated the testing details with v2 changes.
 
Testing details (done for v2):
==============================
-> Tested on Raspberrypi 4B. Follow for more details.

akshayajpi@raspberrypi:~ $ uname -r
6.12.35-v8+
akshayajpi@raspberrypi:~ $ uname -a
Linux raspberrypi 6.12.35-v8+ #5 SMP PREEMPT Tue Jul 15 17:38:06 IST 2025 aarch64 GNU/Linux

-> Sensor Detection, overlaying of device tree and Driver loading
akshayajpi@raspberrypi:~ $ i2cdetect -y 1
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- 53 -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

akshayajpi@raspberrypi:~ $ sudo dtoverlay i2c-sensor ltr390
akshayajpi@raspberrypi:~ $ lsmod|grep ltr390
ltr390                 16384  0
industrialio          110592  1 ltr390
regmap_i2c             12288  1 ltr390


1. Disable sensor via debugfs, verify from i2cget and debugfs.
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x0 | sudo tee direct_reg_access
0x0
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
0x2
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x0 0x0 | sudo tee direct_reg_access
0x0 0x0
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
0x0
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ i2cget -f -y 1 0x53 0x0
0x00

2. Disable sensor via debugfs and read data status via debugfs.
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
603
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
603
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
603
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ i2cget -f -y 1 0x53 0x7
0x28
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ i2cget -f -y 1 0x53 0x7
0x00
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x7 | sudo tee direct_reg_access
0x7
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
0x0

3. Re-enable sensor via debugfs and read data status via debugfs.
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x0 0x2 | sudo tee direct_reg_access
0x0 0x2
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
0x2
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
608
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
614
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
601
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x7 | sudo tee direct_reg_access
0x7
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
0x8

4. Enable interrupts via sysfs and verify via debugfs.
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 1 | sudo tee /sys/bus/iio/devices/iio\:device0/events/in_illuminance_thresh_either_en
1
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ i2cget -f -y 1 0x53 0x19
0x14
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x19 | sudo tee direct_reg_access 
0x19
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
0x14

5. Write falling threshold via debugfs, verify the threshold written via sysfs.
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x24 0x32 | sudo tee direct_reg_access 
0x24 0x32
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
0x32
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x25 0x0 | sudo tee direct_reg_access 
0x25 0x0
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
0x0
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x26 0x0 | sudo tee direct_reg_access 
0x26 0x0
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
0x0
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/events/in_illuminance_thresh_falling_value 
50
final value = 0x0 << 16 | 0x0 << 8 | 0x32 = 50

6. Block light and verify interrupts getting generated.
-> Before blocking light
cat /proc/interrupts|grep ltr390
 58:         0          0          0          0  pinctrl-bcm2835   4 Edge      ltr390_thresh_event

->After blocking light
58:         63          0          0          0  pinctrl-bcm2835   4 Edge      ltr390_thresh_event

7. write value to a non-writeable reg via debugfs.
-> LTR390_ALS_DATA_0|1|2 are non-writeable registers. Writing to them gives I/O error as expected.
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0xd 0x1 | sudo tee direct_reg_access
0xd 0x1
tee: direct_reg_access: Input/output error
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0xe 0x1 | sudo tee direct_reg_access
0xe 0x1
tee: direct_reg_access: Input/output error
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0xf 0x1 | sudo tee direct_reg_access
0xf 0x1
tee: direct_reg_access: Input/output error

8. read value from a non-readable reg via debugfs.
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x2 |sudo tee direct_reg_access 
0x2
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
cat: direct_reg_access: Input/output error

9. do simple raw reads from debugfs.
-> reading raw value via sysfs:
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
627
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
622
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
616

-> reading via debugfs (should be in the same ballpark of sysfs)
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0xd | sudo tee direct_reg_access
0xd
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access 
0xC7
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0xe | sudo tee direct_reg_access
0xe
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access 
0x2
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0xf | sudo tee direct_reg_access
0xf
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access 
0x0
final value = 0x0 << 16 | 0x2 << 8 | 0x70 = 624

10. Testing reads on registers beyond max_register.
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x27 | sudo tee direct_reg_access 
0x27
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access 
cat: direct_reg_access: Input/output error
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x28 | sudo tee direct_reg_access 
0x28
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access 
cat: direct_reg_access: Input/output error

 drivers/iio/light/ltr390.c | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index ee59bbb8aa09..b1028d027e1b 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -38,12 +38,21 @@
 #define LTR390_ALS_UVS_GAIN		0x05
 #define LTR390_PART_ID			0x06
 #define LTR390_MAIN_STATUS		0x07
+
 #define LTR390_ALS_DATA			0x0D
+#define LTR390_ALS_DATA_BYTE(n)		((LTR390_ALS_DATA) + (n))
+
 #define LTR390_UVS_DATA			0x10
+#define LTR390_UVS_DATA_BYTE(n)		((LTR390_UVS_DATA) + (n))
+
 #define LTR390_INT_CFG			0x19
 #define LTR390_INT_PST			0x1A
+
 #define LTR390_THRESH_UP		0x21
+#define LTR390_THRESH_UP_BYTE(n)	((LTR390_THRESH_UP) + (n))
+
 #define LTR390_THRESH_LOW		0x24
+#define LTR390_THRESH_LOW_BYTE(n)	((LTR390_THRESH_LOW) + (n))
 
 #define LTR390_PART_NUMBER_ID		0xb
 #define LTR390_ALS_UVS_GAIN_MASK	GENMASK(2, 0)
@@ -98,11 +107,40 @@ struct ltr390_data {
 	int int_time_us;
 };
 
+static const struct regmap_range ltr390_readable_reg_ranges[] = {
+	regmap_reg_range(LTR390_MAIN_CTRL, LTR390_MAIN_CTRL),
+	regmap_reg_range(LTR390_ALS_UVS_MEAS_RATE, LTR390_MAIN_STATUS),
+	regmap_reg_range(LTR390_ALS_DATA_BYTE(0), LTR390_ALS_DATA_BYTE(2)),
+	regmap_reg_range(LTR390_UVS_DATA_BYTE(0), LTR390_UVS_DATA_BYTE(2)),
+	regmap_reg_range(LTR390_INT_CFG, LTR390_INT_PST),
+	regmap_reg_range(LTR390_THRESH_UP_BYTE(0), LTR390_THRESH_LOW_BYTE(2)),
+};
+
+static const struct regmap_access_table ltr390_readable_reg_table = {
+	.yes_ranges = ltr390_readable_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ltr390_readable_reg_ranges),
+};
+
+static const struct regmap_range ltr390_writeable_reg_ranges[] = {
+	regmap_reg_range(LTR390_MAIN_CTRL, LTR390_MAIN_CTRL),
+	regmap_reg_range(LTR390_ALS_UVS_MEAS_RATE, LTR390_ALS_UVS_GAIN),
+	regmap_reg_range(LTR390_INT_CFG, LTR390_INT_PST),
+	regmap_reg_range(LTR390_THRESH_UP_BYTE(0), LTR390_THRESH_LOW_BYTE(2)),
+};
+
+static const struct regmap_access_table ltr390_writeable_reg_table = {
+	.yes_ranges = ltr390_writeable_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ltr390_writeable_reg_ranges),
+};
+
 static const struct regmap_config ltr390_regmap_config = {
 	.name = "ltr390",
 	.reg_bits = 8,
 	.reg_stride = 1,
 	.val_bits = 8,
+	.max_register = LTR390_THRESH_LOW_BYTE(2),
+	.rd_table = &ltr390_readable_reg_table,
+	.wr_table = &ltr390_writeable_reg_table,
 };
 
 /* Sampling frequency is in mili Hz and mili Seconds */
@@ -586,6 +624,20 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
+static int ltr390_debugfs_reg_access(struct iio_dev *indio_dev,
+						unsigned int reg, unsigned int writeval,
+						unsigned int *readval)
+{
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->lock);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+
+	return regmap_write(data->regmap, reg, writeval);
+}
+
 static const struct iio_info ltr390_info = {
 	.read_raw = ltr390_read_raw,
 	.write_raw = ltr390_write_raw,
@@ -594,6 +646,7 @@ static const struct iio_info ltr390_info = {
 	.read_event_config = ltr390_read_event_config,
 	.write_event_value = ltr390_write_event_value,
 	.write_event_config = ltr390_write_event_config,
+	.debugfs_reg_access = ltr390_debugfs_reg_access,
 };
 
 static irqreturn_t ltr390_interrupt_handler(int irq, void *private)
-- 
2.43.0


