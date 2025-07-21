Return-Path: <linux-iio+bounces-21844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F56AB0CB33
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 21:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F9C17DF38
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 19:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58A623716B;
	Mon, 21 Jul 2025 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+2LElkb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C822F16C;
	Mon, 21 Jul 2025 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127709; cv=none; b=JTO16IFEeCaV++vqzOPEkCfvuCoObGQBTpRKmhnyvZyKbFKZo7xu/vobMcPzxpb9ed936UkgAVR4nX7BncnEP1kTLd3iM06sLvdhgFPIwvox5dTMxsDuqrjwnBNv5dUFnAoI5KY15b6TOuYFmD3B6xnEIoiAZwvygEZST/xLUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127709; c=relaxed/simple;
	bh=36sc+2rQOEbiC7h+soS3PwbETPbq7pjCVh7WYTk+tXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lkxag/bNiJ/Dn/UgA4R9E1jjpmeVtpkCdHHJpdqahV8PldvY/5tuCerscZ49Im2xOUprTkSE3p7dYdM01ptjrwNF2K+MPqCFjhY73X7Eh8Y9B+K0HaUXtvE6zEONwo+vWXV4kjSf/xVeJoaJItVOk3w24wKUZrCTqsC3PSA7cL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+2LElkb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234b9dfb842so39458155ad.1;
        Mon, 21 Jul 2025 12:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753127707; x=1753732507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2nMJpZVRXWba/G/41zaeR+U3GATl1oyyqdt2ZwTDv8=;
        b=I+2LElkbAsFXBqbpxrVDf2o0jRopiMui24zerZ5LpofEWpWFowph1rJbS0LthqJD1x
         8MulvQ0+CEJv64No8N9sqLoWaXVh9tYw28Kp92dA3r9QHMJoux71G5f7rmlymqnVXhFq
         LCisdS9nUSKSpEJtPTBRKA7ztnJYFylYSG+wIrqZG4OaWfMykUhtG+U7+CYtyLZcczuz
         wDgzSp/efEecNjH1VdUF78S9bKgMNxCBnPtstShnyJwReUCiiQmryylfR7NEce6YCN/H
         8C/zv0uN4jPbS1U5aEBnWlOVCZvm4TU6/VJbJWMtwY1hX97Uujnor9UFP4Pb3tq1/3wO
         HTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753127707; x=1753732507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2nMJpZVRXWba/G/41zaeR+U3GATl1oyyqdt2ZwTDv8=;
        b=jemRNWYYRg8YPCD9/jFPZb+4QpwHMgm+fFWElIwxpfgnIycWI4Ttb/WD+Aga+g/fwL
         t6eoavXRMlDT+NwxOKpxZeF7+d4ogZk3BzWHkTz5g/jaDRHGdIeArEONHZKq3JwvCC90
         Q1oBe5HOQ60PcyK5Wpma9TKRgHzTlRwroMNngn/7HlvM773YUDHFwLa90IMam/EuE+Ij
         cX/QwU/jq2wX0WfFotMFxd0meUNWWfL+EFjKHDY2mwn+jQfkFuBX4bVR4fwBcorlqxuP
         GN/pd78z/jr1OjRP4dtIH6qcj/UCdttDrDWWSn2WiZUqnVSQYSUL1fdpi9wPGaWE1dsZ
         oC0w==
X-Forwarded-Encrypted: i=1; AJvYcCUsKV+E/yjtw5VDBcLjeSxrWbh0NMotk9CaYs3h2pmUQcG8jP6i1pFwiqsh2a6IfYREYikCxUIynDSpuMdb@vger.kernel.org, AJvYcCWE0jeX/AbIXP0RjCEwkvtEuvR167rybQkHZ5QnhJBbFJn3AaNJOMYcyVgNM28DVatCUxnpHg8aTq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvn1PXY66eBsWGEi3VDw/opUEEt5nY4Lv5COPdy/bdCBXeCqVx
	I0Yi8cG8UYiRugsnWUctmPidnrh2mjqeNPYwUehfxJZ2x7OF+NjuKtKY
X-Gm-Gg: ASbGncsIA+FZAGrkkHSru/fyaWYb1SJ/dW/pPJ+tCxpxstMvPALkMhwOukwAILg3biQ
	8/mHkozOmNTlQnNZzImkbMbS6XHQnZY2QrHfcPs3fDfcuuD8YYhuMgOWs0dbBV0L1KP2bF6QHeX
	zmEPXgcVFs8ppvJD/8kPA24zfDJwfVZ+Q6vfGp0McabD4Ya4n5kWZOo36X6nJoA5vAyUmYg5bZY
	MShoL/HFZXynE6MG5lKgg0myMuhYPCccGoGjV9Q5FZkIgImupHtmeeIaSTcIT7M3aoIQetqgtnP
	qOMSblcNbI1kLj2Twj+WV41eY3G6yNJq5wqueHk9BxqUBYDPVV2n3K4GKDu8rVhvHevK4fWOJaW
	p/aglmFmSBTuYKdhLwQZjgbv+R4qdGo+4vnSucQ==
X-Google-Smtp-Source: AGHT+IGx7yYM9s11IgwlGe8dna0dcaEjOn3RAgzGFMHMPsfQ+TZHeJN6Cjt3qFAcPdtdmoHyxxdV/A==
X-Received: by 2002:a17:902:c944:b0:234:8a4a:adac with SMTP id d9443c01a7336-23e256b741amr307676475ad.20.1753127707072;
        Mon, 21 Jul 2025 12:55:07 -0700 (PDT)
Received: from akshayaj-lenovo.. ([2401:4900:883b:7064:9455:3de4:d7bb:505e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b60ed4dsm62035295ad.61.2025.07.21.12.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:55:06 -0700 (PDT)
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
Subject: [PATCH 2/2] iio: light: ltr390: Add conditional data freshness check with sysfs control
Date: Tue, 22 Jul 2025 01:24:19 +0530
Message-ID: <20250721195419.526920-2-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721195419.526920-1-akshayaj.lkd@gmail.com>
References: <20250721195419.526920-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add logic to check the sensor’s data freshness status bit before reading
data, and skip reads if the data is stale.

Introduce a new boolean sysfs attribute, `data_fresh_check_enable`, to allow
users to enable or disable this behavior at runtime:

  - 1: Enable data freshness check (default)
  - 0: Disable data freshness check

This provides flexibility to choose between ensuring fresh data and allowing
faster reads when occasional staleness is acceptable.

Document the new attribute under Documentation/ABI/testing/sysfs-bus-iio.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---
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
-rw-r--r-- 1 root root 4.0K Jul 21 23:52 uevent
-r--r--r-- 1 root root 4.0K Jul 21 23:52 name
-r--r--r-- 1 root root 4.0K Jul 21 23:52 waiting_for_supplier
lrwxrwxrwx 1 root root    0 Jul 21 23:52 subsystem -> ../../../../../../../bus/iio
-r--r--r-- 1 root root 4.0K Jul 21 23:52 scale_available
-r--r--r-- 1 root root 4.0K Jul 21 23:52 sampling_frequency_available
-rw-r--r-- 1 root root 4.0K Jul 21 23:52 sampling_frequency
drwxr-xr-x 2 root root    0 Jul 21 23:52 power
lrwxrwxrwx 1 root root    0 Jul 21 23:52 of_node -> ../../../../../../../firmware/devicetree/base/soc/i2c@7e804000/ltr390@53
-rw-r--r-- 1 root root 4.0K Jul 21 23:52 in_uvindex_scale
-rw-r--r-- 1 root root 4.0K Jul 21 23:52 in_uvindex_raw
-r--r--r-- 1 root root 4.0K Jul 21 23:52 integration_time_available
-rw-r--r-- 1 root root 4.0K Jul 21 23:52 integration_time
-rw-r--r-- 1 root root 4.0K Jul 21 23:52 in_illuminance_scale
-rw-r--r-- 1 root root 4.0K Jul 21 23:52 in_illuminance_raw
drwxr-xr-x 2 root root    0 Jul 21 23:52 events
-r--r--r-- 1 root root 4.0K Jul 21 23:52 dev
-rw-r--r-- 1 root root 4.0K Jul 21 23:52 data_fresh_check_enable<-----
-r--r--r-- 1 root root 4.0K Jul 21 23:52 data_fresh

-> Default value 1 for data_fresh_check_enable
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh
1
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh_check_enable 
1

-> Disable fresh measurement in the sensor
akshayajpi@raspberrypi:~ $ i2cset -f -y 1 0x53 0x0 0x0
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh_check_enable 
1
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh_check_enable 
1
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
647
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh
0

-> Since data_fresh_enable_check is enabled by default, driver skips
   stale data read and emits -EAGAIN.
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
cat: '/sys/bus/iio/devices/iio:device0/in_illuminance_raw': Resource temporarily unavailable
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
cat: '/sys/bus/iio/devices/iio:device0/in_illuminance_raw': Resource temporarily unavailable
akshayajpi@raspberrypi:~ $ 

-> Disable data_fresh_check_en
akshayajpi@raspberrypi:~ $ echo 0 | sudo tee /sys/bus/iio/devices/iio\:device0/data_fresh_check_enable
0
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh_check_enable
0
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh
0

-> Since freshness check is disabled, driver reads and prints stale
   data.
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
647
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
647
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
647

-> Re-enabling freshness check, results in driver emitting -EAGAIN.
akshayajpi@raspberrypi:~ $ echo 1 | sudo tee /sys/bus/iio/devices/iio\:device0/data_fresh_check_enable
1
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fresh_check_enable
1
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
cat: '/sys/bus/iio/devices/iio:device0/in_illuminance_raw': Resource temporarily unavailable
akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
cat: '/sys/bus/iio/devices/iio:device0/in_illuminance_raw': Resource temporarily unavailable

 Documentation/ABI/testing/sysfs-bus-iio | 12 ++++++
 drivers/iio/light/ltr390.c              | 55 ++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5d176d46c15d..da881e16ee3d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2397,3 +2397,15 @@ Description:
 
 		Provides userspace visibility into data_freshness status which
 		can be used for debugging and informational use.
+
+What:		/sys/.../iio:deviceX/data_fresh_check_enable
+KernelVersion:	6.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-write boolean attribute controlling whether the driver
+		checks the data freshness status bit before reading sensor data.
+
+		0 - Freshness check disabled
+		1 - Enable check; driver will skip reading stale data (default)
+
+		This flag affects the behavior of data reads.
diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 5af0ffd3df1d..b13f01835aeb 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -98,6 +98,7 @@ struct ltr390_data {
 	enum ltr390_mode mode;
 	int gain;
 	int int_time_us;
+	bool data_fresh_check_en;
 };
 
 static const struct regmap_config ltr390_regmap_config = {
@@ -199,10 +200,40 @@ static ssize_t data_fresh_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", !!(status & LTR390_DATA_STATUS_MASK));
 }
 
+static ssize_t data_fresh_check_enable_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct ltr390_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	guard(mutex)(&data->lock);
+
+	return sysfs_emit(buf, "%d\n", data->data_fresh_check_en);
+}
+
+static ssize_t data_fresh_check_enable_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	int ret;
+	bool data_fresh_check_en;
+	struct ltr390_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	ret = kstrtobool(buf, &data_fresh_check_en);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&data->lock);
+
+	data->data_fresh_check_en = data_fresh_check_en;
+	return len;
+}
+
 static IIO_DEVICE_ATTR_RO(data_fresh, 0);
+static IIO_DEVICE_ATTR_RW(data_fresh_check_enable, 0);
 
 static struct attribute *ltr390_attributes[] = {
 	&iio_dev_attr_data_fresh.dev_attr.attr,
+	&iio_dev_attr_data_fresh_check_enable.dev_attr.attr,
 	NULL
 };
 
@@ -214,7 +245,7 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
 {
-	int ret;
+	int ret, status;
 	struct ltr390_data *data = iio_priv(iio_device);
 
 	guard(mutex)(&data->lock);
@@ -226,6 +257,16 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 			if (ret < 0)
 				return ret;
 
+			if (data->data_fresh_check_en) {
+				ret = ltr390_register_read(data, LTR390_MAIN_STATUS);
+				if (ret < 0)
+					return ret;
+
+				status = ret;
+				if (!(status & LTR390_DATA_STATUS_MASK))
+					return -EAGAIN;
+			}
+
 			ret = ltr390_register_read(data, LTR390_UVS_DATA);
 			if (ret < 0)
 				return ret;
@@ -236,6 +277,16 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 			if (ret < 0)
 				return ret;
 
+			if (data->data_fresh_check_en) {
+				ret = ltr390_register_read(data, LTR390_MAIN_STATUS);
+				if (ret < 0)
+					return ret;
+
+				status = ret;
+				if (!(status & LTR390_DATA_STATUS_MASK))
+					return -EAGAIN;
+			}
+
 			ret = ltr390_register_read(data, LTR390_ALS_DATA);
 			if (ret < 0)
 				return ret;
@@ -687,6 +738,8 @@ static int ltr390_probe(struct i2c_client *client)
 	data->gain = 3;
 	/* default mode for ltr390 is ALS mode */
 	data->mode = LTR390_SET_ALS_MODE;
+	/* default value for data_fresh_check_en is 1 */
+	data->data_fresh_check_en = 1;
 
 	mutex_init(&data->lock);
 
-- 
2.43.0


