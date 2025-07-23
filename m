Return-Path: <linux-iio+bounces-21899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A301AB0F18B
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 13:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2D41AA28DF
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 11:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BC826A0D5;
	Wed, 23 Jul 2025 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfaYhJH2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782BE1C6B4;
	Wed, 23 Jul 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753271254; cv=none; b=WfjGsF6dajGvti+7H/dpv6J2TupGF0c1OcXBRc74B0zTMHTj7Cz3fra1ndm0QhXn/LPMGd/vNbvmpOgRpfY3thoJm5G9jtFT48m4pyQ3eifOb6AXLcUqkBzGAlttljaR9Cum5rHL4S/UOfkVw5sDtd/1oDmYTJVT71lzmDx9Uiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753271254; c=relaxed/simple;
	bh=lkR71ykI2GGAkz9AeWJrbB6bF4tWrtLGNiYyOJqcXqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHqanIk5192BGYxxUPGGu+xyGJEGEglQSwN42DpMXn+wtE9F/LptGWsmFBiZu1IYHR3iflPPLKhx2ycdVUKtq/G4HK1Jxga8EhCx4sHb3kDwjjG6Tl8E2br5eM7UwB3IFNqWY8K8TRYHzY8v/Y5Qd7YYlBru5hvvDA3FzvzS9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfaYhJH2; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b34a71d9208so4592691a12.3;
        Wed, 23 Jul 2025 04:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753271251; x=1753876051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GE61PfecKBXANrthq5eeV8qbcqVbdmTy/WinYdWGDfY=;
        b=UfaYhJH2x2BjVCKhzFjj8ULAZiLbGWudOunNK+0JxNlCD6/jIJzMm8YH4lwXm8RlkU
         TS+J4BDJ22dw8Te8YBrXedG+rw5JUDCl+urHw9ZQJJSfdEZ9jjqWfxgUu5Du1HYIEZM7
         3piCUIv06cmQhmCtqtprZi5XUulO1J3wu60lxihHcanldIbGeCZ11VaoeFqmfBkUM602
         ikB3t4F/YveEXPKecbdHRjprzgxePv0s6eSINs2VVy9sCBXmSu6rE/S1u3C9zRAHNcBf
         HeAd4VS/PrCnF0JBXI+lFZKOIQWOf1+cy1TVnohYG9N9K1DReXXfBEnpOv3oSqCq3BDt
         0bLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753271251; x=1753876051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GE61PfecKBXANrthq5eeV8qbcqVbdmTy/WinYdWGDfY=;
        b=TPONYvOYpmI+pajiSjqUKqJkOqdasT9AJ1XX8NXmFdolmm1XwyzsU3gxqStwnqFGxK
         Edl0Ucc8ZLNJx2tddSZ/trsSjrS1roUXn3nceVdwFci9tA3cOUQdsCv4/8DTOJcUBZO2
         u1zaKo1QKKAh037Dmh898PZRHFt542QdrEaMchsOR/g/tTSOuzUukNOMf2RkpTMiMd+1
         ILbUD0P+eThMpizEClUMaqQN3+GUEcrO11TyTfz5kz+iYxMaeDj/nEuTSgLgChcHB0RD
         vLVvTmR4zZqXmTvuVxvZYpmfmw6JcDNojyo9bZ/QmLPCAoH3VDZmNAyED00z64sTe/Cw
         JjIA==
X-Forwarded-Encrypted: i=1; AJvYcCVb0nK8sKMjGwrnGTWVixLanI1r/jsfYGdA5Vw7lP67jmycq/SN+gDBhKFjKtPmL5sKKDDc6x69OPY=@vger.kernel.org, AJvYcCWYm4jNvsdNVQOtd5cXGmvvCaIlgiL6J6FjwpvRHt2ra6niM0pKQ4ZYgKCCVELGzekVAlrTvxelt29/VOR/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hlwaLYTaSErbcLBtSz4yyzsQlSU4kXNlWjoxo0WOlYEPiooo
	6e/DvbFUkp27pVK57LipI8mIcbyEi/ONdZpNuKP4LQXnQvylvfwBzgKl
X-Gm-Gg: ASbGncuVwG78IV9x5gwtQaUh/Bj3Yomm/WafDz5rP8kEd8OvJ/kfgHKuQoKxTlB61nY
	9bOpQY3aUOyeCZfrL3d8b2b3m3MHCOqJFvTpOuU+IYDx5GLC64N68VwqUyItQT1qIpoKQMBK/U+
	QptiL3zoXeEgcBqlMRtAZJE8KIlWldL5/Wnw/qPg5/xN1EzmA90emsk/+nAyuHi/VkqbKJacUWg
	Aiv+cZXsISadifkIXwMXcgOy8w3YzBR0KVBmIAEQt9tn0T8v9jo80nDHLS4gmKHIaOVtDEO6v9h
	mwwa//gXz7rCkG/fYZWQeAtgnykw3hEEz1rf5COUsLqKgQE1fuYUgb3BY+6w76krj2A8WHG8CG9
	EpcVvISpprCAd/ddjQtDijjqXgQJPLunWMdBTvA==
X-Google-Smtp-Source: AGHT+IGfNM67A4dDLJlWRGKcQ7v5mzRt28XCC69PdtxpLQZxOV0eLRK+et91FjmelFBcpTJGsPW1rw==
X-Received: by 2002:a05:6a21:a49:b0:222:d817:2f4a with SMTP id adf61e73a8af0-23d490405f0mr4172005637.17.1753271251369;
        Wed, 23 Jul 2025 04:47:31 -0700 (PDT)
Received: from akshayaj-lenovo.. ([2401:4900:883b:7064:95f6:1448:c7f3:2f4d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e25besm9429171b3a.2.2025.07.23.04.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:47:30 -0700 (PDT)
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
Subject: [PATCH] iio: light: ltr390: Add debugfs register access support
Date: Wed, 23 Jul 2025 17:16:38 +0530
Message-ID: <20250723114645.596648-1-akshayaj.lkd@gmail.com>
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
Testing details:
================
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
715
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
715
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
715
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
715
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
718
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
727
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
58:         92          0          0          0  pinctrl-bcm2835   4 Edge      ltr390_thresh_event

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
705
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
695
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
711

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
final value = 0x0 << 16 | 0x2 << 8 | 0xc7 = 711

10. Testing reads on registers beyond max_register.
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x27 | sudo tee direct_reg_access 
0x27
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access 
cat: direct_reg_access: Input/output error
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x28 | sudo tee direct_reg_access 
0x28
akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access 
cat: direct_reg_access: Input/output error

 drivers/iio/light/ltr390.c | 99 ++++++++++++++++++++++++++++++++++----
 1 file changed, 89 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index ee59bbb8aa09..1f6ee0fd6d19 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -38,12 +38,20 @@
 #define LTR390_ALS_UVS_GAIN		0x05
 #define LTR390_PART_ID			0x06
 #define LTR390_MAIN_STATUS		0x07
-#define LTR390_ALS_DATA			0x0D
-#define LTR390_UVS_DATA			0x10
+#define LTR390_ALS_DATA_0		0x0D
+#define LTR390_ALS_DATA_1		0x0E
+#define LTR390_ALS_DATA_2		0x0F
+#define LTR390_UVS_DATA_0		0x10
+#define LTR390_UVS_DATA_1		0x11
+#define LTR390_UVS_DATA_2		0x12
 #define LTR390_INT_CFG			0x19
 #define LTR390_INT_PST			0x1A
-#define LTR390_THRESH_UP		0x21
-#define LTR390_THRESH_LOW		0x24
+#define LTR390_THRESH_UP_0		0x21
+#define LTR390_THRESH_UP_1		0x22
+#define LTR390_THRESH_UP_2		0x23
+#define LTR390_THRESH_LOW_0		0x24
+#define LTR390_THRESH_LOW_1		0x25
+#define LTR390_THRESH_LOW_2		0x26
 
 #define LTR390_PART_NUMBER_ID		0xb
 #define LTR390_ALS_UVS_GAIN_MASK	GENMASK(2, 0)
@@ -98,11 +106,62 @@ struct ltr390_data {
 	int int_time_us;
 };
 
+static bool ltr390_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case LTR390_MAIN_CTRL:
+	case LTR390_ALS_UVS_MEAS_RATE:
+	case LTR390_ALS_UVS_GAIN:
+	case LTR390_PART_ID:
+	case LTR390_MAIN_STATUS:
+	case LTR390_ALS_DATA_0:
+	case LTR390_ALS_DATA_1:
+	case LTR390_ALS_DATA_2:
+	case LTR390_UVS_DATA_0:
+	case LTR390_UVS_DATA_1:
+	case LTR390_UVS_DATA_2:
+	case LTR390_INT_CFG:
+	case LTR390_INT_PST:
+	case LTR390_THRESH_UP_0:
+	case LTR390_THRESH_UP_1:
+	case LTR390_THRESH_UP_2:
+	case LTR390_THRESH_LOW_0:
+	case LTR390_THRESH_LOW_1:
+	case LTR390_THRESH_LOW_2:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ltr390_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case LTR390_MAIN_CTRL:
+	case LTR390_ALS_UVS_MEAS_RATE:
+	case LTR390_ALS_UVS_GAIN:
+	case LTR390_INT_CFG:
+	case LTR390_INT_PST:
+	case LTR390_THRESH_UP_0:
+	case LTR390_THRESH_UP_1:
+	case LTR390_THRESH_UP_2:
+	case LTR390_THRESH_LOW_0:
+	case LTR390_THRESH_LOW_1:
+	case LTR390_THRESH_LOW_2:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct regmap_config ltr390_regmap_config = {
 	.name = "ltr390",
 	.reg_bits = 8,
 	.reg_stride = 1,
 	.val_bits = 8,
+	.max_register = LTR390_THRESH_LOW_2,
+	.readable_reg = ltr390_is_readable_reg,
+	.writeable_reg = ltr390_is_writeable_reg,
 };
 
 /* Sampling frequency is in mili Hz and mili Seconds */
@@ -194,7 +253,7 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 			if (ret < 0)
 				return ret;
 
-			ret = ltr390_register_read(data, LTR390_UVS_DATA);
+			ret = ltr390_register_read(data, LTR390_UVS_DATA_0);
 			if (ret < 0)
 				return ret;
 			break;
@@ -204,7 +263,7 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 			if (ret < 0)
 				return ret;
 
-			ret = ltr390_register_read(data, LTR390_ALS_DATA);
+			ret = ltr390_register_read(data, LTR390_ALS_DATA_0);
 			if (ret < 0)
 				return ret;
 			break;
@@ -454,14 +513,14 @@ static int ltr390_read_threshold(struct iio_dev *indio_dev,
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
-		ret = ltr390_register_read(data, LTR390_THRESH_UP);
+		ret = ltr390_register_read(data, LTR390_THRESH_UP_0);
 		if (ret < 0)
 			return ret;
 		*val = ret;
 		return IIO_VAL_INT;
 
 	case IIO_EV_DIR_FALLING:
-		ret = ltr390_register_read(data, LTR390_THRESH_LOW);
+		ret = ltr390_register_read(data, LTR390_THRESH_LOW_0);
 		if (ret < 0)
 			return ret;
 		*val = ret;
@@ -480,10 +539,10 @@ static int ltr390_write_threshold(struct iio_dev *indio_dev,
 	guard(mutex)(&data->lock);
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
-		return regmap_bulk_write(data->regmap, LTR390_THRESH_UP, &val, 3);
+		return regmap_bulk_write(data->regmap, LTR390_THRESH_UP_0, &val, 3);
 
 	case IIO_EV_DIR_FALLING:
-		return regmap_bulk_write(data->regmap, LTR390_THRESH_LOW, &val, 3);
+		return regmap_bulk_write(data->regmap, LTR390_THRESH_LOW_0, &val, 3);
 
 	default:
 		return -EINVAL;
@@ -586,6 +645,25 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
+static int ltr390_debugfs_reg_access(struct iio_dev *indio_dev,
+						unsigned int reg, unsigned int writeval,
+						unsigned int *readval)
+{
+	int ret;
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->lock);
+
+	if (!readval)
+		return regmap_write(data->regmap, reg, writeval);
+
+	ret = regmap_read(data->regmap, reg, readval);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static const struct iio_info ltr390_info = {
 	.read_raw = ltr390_read_raw,
 	.write_raw = ltr390_write_raw,
@@ -594,6 +672,7 @@ static const struct iio_info ltr390_info = {
 	.read_event_config = ltr390_read_event_config,
 	.write_event_value = ltr390_write_event_value,
 	.write_event_config = ltr390_write_event_config,
+	.debugfs_reg_access = ltr390_debugfs_reg_access,
 };
 
 static irqreturn_t ltr390_interrupt_handler(int irq, void *private)
-- 
2.43.0


