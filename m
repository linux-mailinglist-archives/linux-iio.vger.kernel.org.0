Return-Path: <linux-iio+bounces-21843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F45B0CB31
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 21:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6998E7A64C7
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 19:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2F31DE8A8;
	Mon, 21 Jul 2025 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKfcHUZH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329022F14D;
	Mon, 21 Jul 2025 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127690; cv=none; b=dfKu005s6U7IssimbrFzRLfdzTHJPEAHDu2o0AUrgFod0j0lNmenxfD+RiyQNLUxpTB/ij+mY9vb/Y5hVVoHfu9pHYfxE8G7JoZom+DvFPe+lVX3z15kHpBnhiXfJQF33XxWySP80ehSX9Wk71zrkUHss1QcM1YK+q2OMO1rurw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127690; c=relaxed/simple;
	bh=vbcLmtsjPSXhBsHwJvO1O6rS/P8aQrLWIW9QTL34Flc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ng1TI+BdrDtFfeY+7aZDsJ8iwAtqm4ncMjJGs8LL65FheHFIIQ3m5fYjqbYlxQOGx6BiQgNNMVG9o92vVF2l/6p7NUs6mr2laSLUL5d19f5KV5c6OlJ6LeraPEripkPOK87mxiOehahUvw8WRnRoxPdubh6o1OvyxgIrPwMp/XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKfcHUZH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23c8f179e1bso47318935ad.1;
        Mon, 21 Jul 2025 12:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753127688; x=1753732488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6Jwt17X4c0zkRhqcjSNl6CntrzBfWAYIdwy/nu/w1Q=;
        b=JKfcHUZHIXtrqTCj7nJZOZRDIyHSYma/y4LAE0so9HKlUthWo4C6n6iEtRyMo6j0XB
         ImXYSXWBScuPraIB1zf0PLDnybww5OOz2ifA4F4rfy9W2eOxhSB23Td7ILPF4qrs709G
         qxq45Ne9b15uey9ALPEVFV3C4E8vNdsAKfMSzL1tsYqsfOLaE/y5qEZGNeItABB/WScA
         EbxpHIQg2n9jvGPwBzMApYExa+2ynV21uU8bop7loUE9d6DAsxM7dVJawntkJBptuF+m
         Lkz+dhj8/inoFVCQMrZMVw6awUMmqacLNmd948D9bI9gM01iYwo92AWsIEIV+PVL3Pnw
         x8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753127688; x=1753732488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6Jwt17X4c0zkRhqcjSNl6CntrzBfWAYIdwy/nu/w1Q=;
        b=lQgl5pnC0bQS641l+vUFO0COTbw8UkBLaOenTz88wrkgoVHOx+DyL4jS93LH1QUGg+
         5PNgy1TbvkIkRLExwaOCw0wHEBMTt0G/PQeeE40V4JKjpKFVvJJOyXbWv8pxoOXJT5IC
         r5i7ggkMfT7khvicoczTqDgZOfU1RDZdmh0gObFkJHJeIGQTPSHVDliDoXkDHsyMbZ5t
         Qu7W6YLrAJeMdHFj2GkMWohqW4sSzJS639jIpLzMhWe0v4BLjtop+eIIVa94XmWYUcqp
         zXiDDadmujAwS8qsebCuoa7o59eN+fBZesHY4BbsGUlZ2fd0reF2K2ejXs4YMKw9tJO6
         2VoA==
X-Forwarded-Encrypted: i=1; AJvYcCW1o0EDTDo4whcIQ+SWhMjNkdDapbGuw0zh/ueUOVyhJOWHuogOgoTZpcZm1TeoercvozopzB2EIore8Ld1@vger.kernel.org, AJvYcCWwW4wpDZdT7YpVDzZM3pl4K2qdLkYQEjtufd8yUsiZieEX/uXaA6eRZI4KeUBOfrXM3bsrnm2J+Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJA53w4as/SVGh6TA8cga8Qp3E68Yw1peP0FR1GZJDe09ImNbC
	fAkDyU5ySl8oxaQ9zpEnAJoX7O8KqAwDjHzEnzJJuk49q33rSSnJDMUG
X-Gm-Gg: ASbGncuuGT4cLTgH/CQHi1BfaPSdLL9HPAVKslww95Dlzh58oldwBYlCXmlp1Hp7bCq
	zseGkAEs3HiNarg0v4s3D6Bqbpkhedajp2PNzkVElhwmsizbIQoUEQar4wFXjzuqV0Bw/bZAiYu
	/gopl0GOf423M805zxL2M1VpYPy0OJ4FcvkLTwW7ZjyiW5Td+ut8F20Ssw8wILs90Ibhv6TYNwk
	METJCb2RquLrDwAdDXq84bBXHTljGI006+NodeKUAsEf6E5Ft2/TQ34WTnBwK6wridSVl/vmvXL
	7bVI+S6pYU6qawB2BahF+8YHOidaMaUdk61jg+FI5+dEObJLJ0qCv0v+M3O8ThwmOyYYj3PnpVE
	/KJdglWPEMv+I43+irP4ukTl2gRUIa9/CE2CBhg==
X-Google-Smtp-Source: AGHT+IEXieCOeo0zMRu9QoNl6zYYV3geoRKtYII1s1E3awQ4whMZVFai12NrmE++ffiBvguj3g/JwA==
X-Received: by 2002:a17:902:f64f:b0:23c:8f2d:5e24 with SMTP id d9443c01a7336-23e25699123mr319619155ad.5.1753127687659;
        Mon, 21 Jul 2025 12:54:47 -0700 (PDT)
Received: from akshayaj-lenovo.. ([2401:4900:883b:7064:9455:3de4:d7bb:505e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b60ed4dsm62035295ad.61.2025.07.21.12.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:54:47 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: anshulusr@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akshay Jindal <akshayaj.lkd@gmail.com>
Subject: [PATCH 1/2] iio: light: ltr390: Add sysfs attribute to report data freshness
Date: Tue, 22 Jul 2025 01:24:18 +0530
Message-ID: <20250721195419.526920-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some IIO sensors provide a status bit indicating whether the current data
register holds freshly measured data or stale data previously read.

Expose this status via a new read-only sysfs attribute, 'data_fresh',
which returns:
  - 1 if the data is freshly sampled
  - 0 if the data is stale

This attribute allows userspace to observe data freshness directly, which
can be useful for debugging or application-level filtering.

Document the attribute under Documentation/ABI/testing/sysfs-bus-iio.

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

-> Sysfs Attribute Creation validation
akshayajpi@raspberrypi:~ $ ls -ltrh /sys/bus/iio/devices/iio\:device0/
total 0
-rw-r--r-- 1 root root 4.0K Jul 21 21:41 uevent
-r--r--r-- 1 root root 4.0K Jul 21 21:41 name
lrwxrwxrwx 1 root root    0 Jul 21 21:42 of_node -> ../../../../../../../firmware/devicetree/base/soc/i2c@7e804000/ltr390@53
-rw-r--r-- 1 root root 4.0K Jul 21 21:42 integration_time
-r--r--r-- 1 root root 4.0K Jul 21 21:42 waiting_for_supplier
lrwxrwxrwx 1 root root    0 Jul 21 21:42 subsystem -> ../../../../../../../bus/iio
-r--r--r-- 1 root root 4.0K Jul 21 21:42 scale_available
-r--r--r-- 1 root root 4.0K Jul 21 21:42 sampling_frequency_available
-rw-r--r-- 1 root root 4.0K Jul 21 21:42 sampling_frequency
drwxr-xr-x 2 root root    0 Jul 21 21:42 power
-rw-r--r-- 1 root root 4.0K Jul 21 21:42 in_uvindex_scale
-rw-r--r-- 1 root root 4.0K Jul 21 21:42 in_uvindex_raw
-r--r--r-- 1 root root 4.0K Jul 21 21:42 integration_time_available
-rw-r--r-- 1 root root 4.0K Jul 21 21:42 in_illuminance_scale
-rw-r--r-- 1 root root 4.0K Jul 21 21:42 in_illuminance_raw
drwxr-xr-x 2 root root    0 Jul 21 21:42 events
-r--r--r-- 1 root root 4.0K Jul 21 21:42 dev
-r--r--r-- 1 root root 4.0K Jul 21 21:42 data_fresh<-----

-> Disabled Bit 1 in MAIN_CTRL (reg 0x0) register to stop fresh measurements
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
609
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
603
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh
1
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh
1
akshayajpi@raspberrypi:~ $ i2cget -f -y 1 0x53 0x0
0x02
akshayajpi@raspberrypi:~ $ i2cset -f -y 1 0x53 0x0 0x0
akshayajpi@raspberrypi:~ $ i2cget -f -y 1 0x53 0x0
0x00

-> data_status bit cleared after reading
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh
1
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh
0
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh
0
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
605
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
605

-> Re-enabled sensor and fresh measurements reported
akshayajpi@raspberrypi:~ $ i2cset -f -y 1 0x53 0x0 0x2
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh
1
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh
1
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
607
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
622

 Documentation/ABI/testing/sysfs-bus-iio | 14 +++++++++++
 drivers/iio/light/ltr390.c              | 33 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 190bfcc1e836..5d176d46c15d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2383,3 +2383,17 @@ Description:
 		Value representing the user's attention to the system expressed
 		in units as percentage. This usually means if the user is
 		looking at the screen or not.
+
+What:		/sys/.../iio:deviceX/data_fresh
+KernelVersion:	6.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute indicating whether the sensor data currently
+		available in the device is freshly measured or stale.
+
+		Returns:
+			1 - Data is freshly measured
+			0 - Data is stale (previously read or not yet updated)
+
+		Provides userspace visibility into data_freshness status which
+		can be used for debugging and informational use.
diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index ee59bbb8aa09..5af0ffd3df1d 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -30,6 +30,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/events.h>
+#include <linux/iio/sysfs.h>
 
 #include <linux/unaligned.h>
 
@@ -61,6 +62,7 @@
 
 #define LTR390_FRACTIONAL_PRECISION 100
 
+#define LTR390_DATA_STATUS_MASK		BIT(3)
 /*
  * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
  * the sensor are equal to 1 UV Index [Datasheet Page#8].
@@ -178,6 +180,36 @@ static int ltr390_get_samp_freq_or_period(struct ltr390_data *data,
 	return ltr390_samp_freq_table[value][option];
 }
 
+/*
+ * Indicates whether the most recent sensor data read from the device
+ * was freshly measured (1) or stale/old (0). This is based on ltr390's
+ * internal data status bit.
+ */
+static ssize_t data_fresh_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	int ret, status;
+	struct ltr390_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	ret = ltr390_register_read(data, LTR390_MAIN_STATUS);
+	if (ret < 0)
+		return ret;
+
+	status = ret;
+	return sysfs_emit(buf, "%d\n", !!(status & LTR390_DATA_STATUS_MASK));
+}
+
+static IIO_DEVICE_ATTR_RO(data_fresh, 0);
+
+static struct attribute *ltr390_attributes[] = {
+	&iio_dev_attr_data_fresh.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ltr390_attribute_group = {
+	.attrs = ltr390_attributes,
+};
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -594,6 +626,7 @@ static const struct iio_info ltr390_info = {
 	.read_event_config = ltr390_read_event_config,
 	.write_event_value = ltr390_write_event_value,
 	.write_event_config = ltr390_write_event_config,
+	.attrs = &ltr390_attribute_group,
 };
 
 static irqreturn_t ltr390_interrupt_handler(int irq, void *private)
-- 
2.43.0


