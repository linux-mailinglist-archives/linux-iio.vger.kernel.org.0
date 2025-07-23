Return-Path: <linux-iio+bounces-21926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D2FB0F9F7
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 20:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC243B931C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 18:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C040F1FA272;
	Wed, 23 Jul 2025 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcL57z8j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781DC2E0;
	Wed, 23 Jul 2025 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293908; cv=none; b=n2DhBMatcB7FS97Zn7mrnzC18egbTZwOhmWSmDWtEYxtlah4pZ1uJOeyMR4Orc2bBuKAKu70IE7UN1nni2YQf6JPROwuqY1TxTqsjSUhHVvU4uKa8DTfaHH6sowWkkm+VqTzGXUuWzHWN4bqgdAU/k4Dc3Tl9lqCbO6KyuY1LW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293908; c=relaxed/simple;
	bh=u7GVxT2RYawBIdHa3a6kihghiksZVYyf0zQoc5idxI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GOAal5EVrhiE3qMkbamZzN7q+u+SrVP9M9iD5BQKy2+xx5iMLy2O6OZ0B0QKdGwu9bDdxEYBKN+dyriXaXAm9aGxh+umtBd4x/1TQzZBWZp/jpelXhH2SvPvZTfYB378rdCGEli2wkmhd1UQf6TMVmo+DLYy1w8LD5yOaBfx9a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcL57z8j; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso258356a12.2;
        Wed, 23 Jul 2025 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753293906; x=1753898706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YRRQxHGB+9SsoaZj6Fupkuk2dhJLaPIsp4PZrc5vEYA=;
        b=CcL57z8jgLNVz82v0YZciqclr3Fke8Z0IIPrxOHMdQ+9suzEUpXmLMypstmmKraHh3
         GQq+ENTlyvLguyIguUNbeUL96TSu+U8lFjqWZkhxwVcUuLD+LMEbP6dwieoBtRbN4xix
         X8QU9V5AVe8k0zq0s6fpwdjkzK3r7j0ogMVlVyX37ngVoKPWtjlNROriHWCzaGPeysAj
         ii3Me6Z78CbaGFEixq+T1/v9CgFD9290KnPQdnhNMq1lMq+gI3C9xqpL+FcahvpaFRPh
         2UT2A5m/VVA3cMq7sGDKNOyQdkzvMz0n3y8FYkNI+Dczu7gyeN7NNATuxBnIIUrmbo2P
         ClDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753293906; x=1753898706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRRQxHGB+9SsoaZj6Fupkuk2dhJLaPIsp4PZrc5vEYA=;
        b=QJE6MmyNKnVWCf9DlRKuI/Fx4TRp5AEFvcMb60qmjFYGxcGAebRIccAB1xVv4OkgZx
         BZD9F6Jq+vJoD53EJmaFrodliWTxOXE2ykq2EWqW8pjMmQiN/IJdEl/3ju3ukjCMe65E
         ak1zo0qU7HrJUSRZTjh3B8/zegGq2JTwsMFIVEaSU5BX6gTvPyUIAbr8OGzjHP1+ElVw
         w4gmAotdkWMtlJCWthJp3gGuw2Q+gJjjhATtLiop9ZuVyCFz2uHtx1p0BIKdp85IBHIf
         AaW2nh+rN5jhcnEsyCPkuPE3zgpsHieRkS1U2NxEM+Xl/+PR5twVe2AHYk/VtWfomsnl
         IshA==
X-Forwarded-Encrypted: i=1; AJvYcCV60uuPqAN6ISEVfWnEjazfVhFT2YTSPR7qr/jTIUxlKBef+F9aSqqOobTpB0DeoVipewHS837Fgxy/ekFn@vger.kernel.org, AJvYcCVF8E/Ydbwmsp09BiixTwyb8RgRmHytdM3O3LoWo1e0CtfsnsRow3wfDthqjTQ+XuqNYdncG9bnyt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dG/Vs9Qxjm1r9hHhiXFS2O4JKPuFcgbQSYg4q8vWf1ZQn+1r
	Qg/IGRfsH1RwZWoXo4WaL6Zu3jt/X520KhNIpAZmKsMFzkyZoDb/KAaT
X-Gm-Gg: ASbGnctXibiui6ZyspWI2jIaJd6OWEXkk0JZRc3KebND+pGmyCp3d5PxTANx72ib8zH
	SZ/ytWBzGHD8ZxUN3T0QTYx+hsakgWMzq75/CguuzFNExFkohGHqaP/21yW2phQQP8QqjaDojMy
	K/BAH8p4D1Ipp+cMJjgVADZ/ycN2iYuemqHzo+YbP7FJr4eWjU9G/sLTtrwcLZ6KFQlgxr0iHCH
	/x/PJ1hyPwBk/toH4z/bGBW1PII+yp09EOBOK9RzZLG4i3C5Dm0R/fSMllBwucskLQcpwVRBDSh
	5wg9EuflU0lgLDY7Xdzk5gnrIuO757WnA3YiGvskHm1iDMqCQXFpSR9gZxeOmQ7kCUjYqA8SZN2
	HeDfW5mCU9YUEEFaCyWY5PuuB6rs2yoxIELmg3UqMHSrT6Yo=
X-Google-Smtp-Source: AGHT+IF8Hee14fYadrlZRlhceQheuKuRw8Kd+48z+O+jXjMYiO3CWOSzSrtzoyz8wd/Hv/BBDVE1Gg==
X-Received: by 2002:a05:6a20:258c:b0:220:3870:c61e with SMTP id adf61e73a8af0-23d48fe819emr7004096637.4.1753293905930;
        Wed, 23 Jul 2025 11:05:05 -0700 (PDT)
Received: from akshayaj-lenovo.. ([2401:4900:883b:7064:9811:2a6:32b8:82ac])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d4efsm10155622b3a.107.2025.07.23.11.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:05:05 -0700 (PDT)
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
Subject: [PATCH v2] iio: light: ltr390: Add debugfs register access support
Date: Wed, 23 Jul 2025 23:34:54 +0530
Message-ID: <20250723180457.629833-1-akshayaj.lkd@gmail.com>
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

Changes since v1:
=================
- Replaced _[0|1|2] macros with a respective common parameterized macro.
- Retained base macros to avoid churn.
- Swapped regmap_write with regmap_read to avoid negate operator.
- Simplified debugfs function by directly returning return value of
  regmap_[read|write].
- Replaced [readable|writeable]_reg with regmap ranges by using
  [rd|wr]_table property of regmap_config.
 
Testing details(updated):
========================
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

 drivers/iio/light/ltr390.c | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index ee59bbb8aa09..b63301648689 100644
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
@@ -98,11 +107,42 @@ struct ltr390_data {
 	int int_time_us;
 };
 
+static const struct regmap_range ltr390_readable_reg_ranges[] = {
+	regmap_reg_range(LTR390_MAIN_CTRL, LTR390_MAIN_CTRL),
+	regmap_reg_range(LTR390_ALS_UVS_MEAS_RATE, LTR390_MAIN_STATUS),
+	regmap_reg_range(LTR390_ALS_DATA_BYTE(0), LTR390_ALS_DATA_BYTE(2)),
+	regmap_reg_range(LTR390_UVS_DATA_BYTE(0), LTR390_UVS_DATA_BYTE(2)),
+	regmap_reg_range(LTR390_INT_CFG, LTR390_INT_PST),
+	regmap_reg_range(LTR390_THRESH_UP_BYTE(0), LTR390_THRESH_UP_BYTE(2)),
+	regmap_reg_range(LTR390_THRESH_LOW_BYTE(0), LTR390_THRESH_LOW_BYTE(2)),
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
+	regmap_reg_range(LTR390_THRESH_UP_BYTE(0), LTR390_THRESH_UP_BYTE(2)),
+	regmap_reg_range(LTR390_THRESH_LOW_BYTE(0), LTR390_THRESH_LOW_BYTE(2)),
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
@@ -586,6 +626,20 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
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
@@ -594,6 +648,7 @@ static const struct iio_info ltr390_info = {
 	.read_event_config = ltr390_read_event_config,
 	.write_event_value = ltr390_write_event_value,
 	.write_event_config = ltr390_write_event_config,
+	.debugfs_reg_access = ltr390_debugfs_reg_access,
 };
 
 static irqreturn_t ltr390_interrupt_handler(int irq, void *private)
-- 
2.43.0


