Return-Path: <linux-iio+bounces-23603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C33EB3EE02
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 20:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EDF87A8CC6
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 18:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA5E32A837;
	Mon,  1 Sep 2025 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0mTWK7k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BD034CDD;
	Mon,  1 Sep 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752171; cv=none; b=ViyQvHa2QtejmHgmj+ahu3I4ARvHvIRzyoCzSoh8dTvaUOGQUx0Xirsrwezee5SvkMJiDIjEKjTAJGFPYI/iN7qLni1SN4KXxrm1X7uCOc4zeCIklOmn9VolCgTUK5uP5os2SiKTOWgAAxHDz22NMavmWZUVadgaUS/sPQAtjSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752171; c=relaxed/simple;
	bh=2d52vighkED+vr/UGcFU31UN9cMFJZ/IPGMLNDxIPkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nI5ny2Yj5DJGUgAfpouLkwWGzOjd5pg6XfYqGVaGbVivHYP4T7cdKmBbMKEoss4CvIEQf723E1PDGixDphUyh2I6XYr2i9P0RXXz0H5j/F8zYJwqob2Az39ncqs/HrjypEYwDyLH4x7ylOVpfrWzHDc6DQ+U1VaqXHK/6z0pANo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0mTWK7k; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4c9a6d3fc7so2542078a12.3;
        Mon, 01 Sep 2025 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756752168; x=1757356968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wvdg41PM5HB8Nwly6FCzzDQZu3k4hdMyTbpLh9jPZ8I=;
        b=d0mTWK7kyaMzhAYXpjQqgihhgBaOSkFpLQu8YI+a91vKmJDOmsL0Yxt3ObwbogFdd4
         S6ntlTAyDdFWcke5Vgd8zW/a/4xXhb78UZboeElIh/atOR57YpphXmJtMZzmpHWVMDXC
         WhcQrwHYDGBTchuNKKP0DwkcRC2YcW7DKPf9vfyTA0krBNHtksgtqPts1Mw+quetUwV5
         Mcv/3VEF1fg0xaIGPd0+BLU1UFOdiIytbroFRQBxpG1pPtm5naqEGB87UZAVqzOD4LGn
         RdtwAllBr9ijLQyW1+oC7lAoxl7aXyv00SrW+tCfVBBkVGUWN1lLwfEBj+kgn7qP+UY6
         T8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756752168; x=1757356968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvdg41PM5HB8Nwly6FCzzDQZu3k4hdMyTbpLh9jPZ8I=;
        b=u2QA0vwZbRgU1EB4KYJ+A01ac9fAgy2FELe8c0CqiUuqxk0oxU4jlyr4p3VrsEfg7z
         ppBzrAIRgGAHID2+eNH37dhIGH+blQ7iaeisXpm3f23jGwEY2N/D79i5QELje++d/PbM
         FR1UBMd5ywnCCS25bbTAobM3Dyj598VIGxweRI/CzClbx12CBy/DMCYVrKbxIhZKGbud
         IS6aRx8G24JBhBXnDFyVpMJmOteY9YnCPciOX3tu6oM4VsGH/BzN50FgB1WlVDqbpNZB
         TQ7UkuAH2KXD6cGekFelM0e3EkKaG92tPWouTn0FQGMgar4G6tUu3TN4/usx5EQoBS8l
         sQRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF+7Sa7dhhzpVbPZJa6T7G7V7bR6+x3SbVaMbxV5CfscMQMfQmhAZ12HezQ9jjOsjN3UlF74jvKmLu49Vd@vger.kernel.org, AJvYcCWOhy0gdfHszGh12gl22z7NF96/MX+h3Zj55qI2ZpPn8R4Ig5SGDKYDbRaRTKv+Qmb5m4c44hO2ROY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVM/wmCRUGFD8eqXk9TNLvnw24BI8glwjwJQEH6IqxGaAqEqPB
	5/zsqVz6j4wE5pUG3AG3E3plQ2q5wxAPnZNWnM3bPKlj+VS5FJGrWRds
X-Gm-Gg: ASbGncsPwP03rOcTUaL+sJ4tEK6T/+EkP3sVjkcOcZh26qGHmYif+R/lCirEYktOlGy
	0i1Acj0JZ68CmmWJyScxYUDGbt7ZtiEf/2QMlTM7VqLr8xhpObzVIUwePCGnoM1VrhpGoJ7cGKS
	KfL+ZP6rt3rPQwsrielzkN4Y9Ap6RB9uEXec+fBA97xRtimdK92iQ+slJa+itIvVz8fUM5VODzC
	s22CEDJUy8gblFAwk95ajaQOG+VSVD7eRsl20A3jyttqOMCZvAMC/EKtCJNYc0SNHbAFSVh/JYJ
	MaXwrJYopT68ZGiyAHzfsmk6RZ6lBHznNbShvoSzhlXQb0Bd0KHVbhOeRDlZ/wD9sI4Zr1R3rXw
	E8/Uqhykvd+S5vQE2GglbDzDXX2rElewuiyV7P/SYecEtN8ET
X-Google-Smtp-Source: AGHT+IGncUksVT1kiARASZH8QUiBs3oGOVrxCWOMrQIbKUx3znC0CbWx9PAvS2Hu17P7zkFgl3ZxQg==
X-Received: by 2002:a17:902:db04:b0:248:f736:1ebb with SMTP id d9443c01a7336-24944b45cdfmr111513155ad.47.1756752168437;
        Mon, 01 Sep 2025 11:42:48 -0700 (PDT)
Received: from akshayaj-lenovo.. ([2401:4900:883a:e1ca:2a30:298b:7776:d1af])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065b73f1sm108712645ad.133.2025.09.01.11.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 11:42:47 -0700 (PDT)
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
Subject: [PATCH v4] iio: light: ltr390: Implement runtime PM support
Date: Tue,  2 Sep 2025 00:12:36 +0530
Message-ID: <20250901184238.34335-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement runtime power management for the LTR390 sensor. The device
autosuspends after 1s of idle time, reducing current consumption from
100 µA in active mode to 1 µA in standby mode as per the datasheet.

Ensure that interrupts continue to be delivered with runtime PM.
Since the LTR390 cannot be used as a wakeup source during runtime
suspend, therefore increment the runtime PM refcount when enabling
events and decrement it when disabling events or powering down.
This prevents event loss while still allowing power savings when IRQs
are unused.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---

Changes since v3:
=================
1. Jonathan's feedback:
-> Keep runtime PM calls only in read_raw, write_event_config and powerdown.
-> Updated Testing details for the changes.

2. Andy's feedback:
-> Move include of pm_runtime.h above include of regmap.h

Changes since v2:
=================
1. Andy's feedback:
-> Check return value of pm_runtime_resume_and_get().
-> Do not check return value of pm_runtime_put_autosuspend().

2. Set data->irq_enabled = true after checking return value of pm_runtime_resume_and_get() only.

Changes since v1:
================
1. Andy's feedback:
-> Refactor iio_info callbacks.
-> Preserve the order of header file includes.
-> Avoid redundant usage of pm_runtime_mark_last_busy.
-> Dissolve the ltr390_set_power_state(data, [true|false]) function.
-> Avoid macro usage which is internal to header file.
-> Update changelog with reason of not using wakeup as a source
capability.

2. David's feedback:
-> Update Changelog with stats of power savings mentioned in datasheet.
-> Dissolve ltr390_set_power_state() function.

3. Jonathan's feedback:
-> Adopt the approach of increment refcount when event enable and
vice-versa.
-> Use devm_pm_runtime_set_active_enabled() function.
-> Better error handling.

4. Testing changes:
-> Add a test section for module load/unload while event is enabled or disabled.
-> Add an idempotency check in the Interrupt Handling Verification subsection.

5. Change the heading word from Add-->Implement.

Testing summary:
================

Extra Testing for v4:
---------------------
1. Verified no change in refcount while:
-> write_raw(): did write on in_illuminance_scale sysfs attribute.
-> read_event_value(): did read the interrupt threshold & interrupt period sysfs attributes.
-> read_event_config(): did read on interrupt_en sysfs attributes.
-> write_event_value(): did write on interrupt threshold & period sysfs attributes.

2. Debugfs testing:
-> did write from debugfs into INT_PST (0x1a) register. Verified the value change by reading processed value from interrupt period.
No change in refcount observed.

3. Refcount change only observed when following are triggered:
-> read_raw(): reading in_illuminance_raw, in_illuminance_scale
-> write_event_config(): enabling or disabling interrupts.
-> powerdown(): drops from 1 to 0, if events were enabled before rmmod, else remains 0.

Testing done till v3 (repeated for v4):
---------------------------------------
-> Tested on Raspberrypi 4B. Following tests were performed.
1. Verified that /sys/bus/i2c/devices/i2c-1/1-0053/power/control contains ‘auto’ value.
2. Verified the /sys/bus/i2c/devices/i2c-1/1-0053/power/autosuspend_delay_ms contains 1000 which is assigned by the driver.
3. Changed the autosuspend_delay_ms value from 1000 to 2000ms and verified it.
        3.1 Verified through the timestamp that whatever autosuspend_delay_ms is set, it is being honoured.
4. Verified that runtime_suspend and runtime_resume callbacks are called whenever any IO is done on a channel attribute.
        4.1 Verified that power/runtime_status first becomes active and then becomes suspended.
        4.2 Verified that power/runtime_active_time keeps on increasing with a delta of autosuspend_delay_ms.

Interrupt Handling Verification (repeated for v4 ):
--------------------------------------------------
1. Verified that when interrupts are enabled on the device, then the device does not get put in standby mode and keeps sampling.
        a. As a result interrupts are delivered to the driver and are handled.
2. Verified that when interrupts are disabled, the device is put in standby mode and stops sampling.
        a.Since there is no sampling, so no IRQs will be generated. They are only generated when the device is resumed due to I/O
	on some sysfs attribute from userspace.
3. Did idempotency check for event enable or disable. This means that occurences like event enable or disable should not
	erroneously increase or decrease the refcount of the device. 

Module load/unload Verification (repeated for v4):
--------------------------------------------------
1. Tested that the refcount should reach 0 when events are enabled.
2. Did a test of load after unload.

 drivers/iio/light/ltr390.c | 121 ++++++++++++++++++++++++++++++++++---
 1 file changed, 111 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 2e1cf62e8201..2cb72cc463ef 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -26,6 +26,7 @@
 #include <linux/math.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
@@ -105,6 +106,7 @@ struct ltr390_data {
 	enum ltr390_mode mode;
 	int gain;
 	int int_time_us;
+	bool irq_enabled;
 };
 
 static const struct regmap_range ltr390_readable_reg_ranges[] = {
@@ -215,9 +217,10 @@ static int ltr390_get_samp_freq_or_period(struct ltr390_data *data,
 	return ltr390_samp_freq_table[value][option];
 }
 
-static int ltr390_read_raw(struct iio_dev *iio_device,
-			   struct iio_chan_spec const *chan, int *val,
-			   int *val2, long mask)
+
+static int __ltr390_read_raw(struct iio_dev *iio_device,
+			struct iio_chan_spec const *chan, int *val,
+			int *val2, long mask)
 {
 	int ret;
 	struct ltr390_data *data = iio_priv(iio_device);
@@ -280,6 +283,27 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 	}
 }
 
+static int ltr390_read_raw(struct iio_dev *iio_device,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	int ret;
+	struct ltr390_data *data = iio_priv(iio_device);
+	struct device *dev = &data->client->dev;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
+		return ret;
+	}
+
+	ret = __ltr390_read_raw(iio_device, chan, val, val2, mask);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
 /* integration time in us */
 static const int ltr390_int_time_map_us[] = { 400000, 200000, 100000, 50000, 25000, 12500 };
 static const int ltr390_gain_map[] = { 1, 3, 6, 9, 18 };
@@ -586,7 +610,7 @@ static int ltr390_read_event_config(struct iio_dev *indio_dev,
 	return FIELD_GET(LTR390_LS_INT_EN, status);
 }
 
-static int ltr390_write_event_config(struct iio_dev *indio_dev,
+static int __ltr390_write_event_config(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
 				enum iio_event_direction dir,
@@ -598,7 +622,6 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
 	if (!state)
 		return regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
 
-	guard(mutex)(&data->lock);
 	ret = regmap_set_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
 	if (ret < 0)
 		return ret;
@@ -623,6 +646,37 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
+static int ltr390_write_event_config(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				bool state)
+{
+	int ret;
+	struct ltr390_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+
+	guard(mutex)(&data->lock);
+
+	if (state && !data->irq_enabled) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0) {
+			dev_err(dev, "runtime PM failed to resume: %d\n", ret);
+			return ret;
+		}
+		data->irq_enabled = true;
+	}
+
+	ret = __ltr390_write_event_config(indio_dev, chan, type, dir, state);
+
+	if (!state && data->irq_enabled) {
+		data->irq_enabled = false;
+		pm_runtime_put_autosuspend(dev);
+	}
+
+	return ret;
+}
+
 static int ltr390_debugfs_reg_access(struct iio_dev *indio_dev,
 						unsigned int reg, unsigned int writeval,
 						unsigned int *readval)
@@ -687,15 +741,36 @@ static void ltr390_powerdown(void *priv)
 	guard(mutex)(&data->lock);
 
 	/* Ensure that power off and interrupts are disabled */
-	if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
-				LTR390_LS_INT_EN) < 0)
-		dev_err(&data->client->dev, "failed to disable interrupts\n");
+	if (data->irq_enabled) {
+		if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
+					LTR390_LS_INT_EN) < 0)
+			dev_err(&data->client->dev,
+					"failed to disable interrupts\n");
+		data->irq_enabled = false;
+
+		pm_runtime_put_autosuspend(&data->client->dev);
+	}
 
 	if (regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL,
 			LTR390_SENSOR_ENABLE) < 0)
 		dev_err(&data->client->dev, "failed to disable sensor\n");
 }
 
+static int ltr390_pm_init(struct ltr390_data *data)
+{
+	int ret;
+	struct device *dev = &data->client->dev;
+
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+					"failed to enable runtime PM\n");
+
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
+	return 0;
+}
+
 static int ltr390_probe(struct i2c_client *client)
 {
 	struct ltr390_data *data;
@@ -708,6 +783,8 @@ static int ltr390_probe(struct i2c_client *client)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	i2c_set_clientdata(client, indio_dev);
+
 	data = iio_priv(indio_dev);
 	data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
 	if (IS_ERR(data->regmap))
@@ -721,6 +798,8 @@ static int ltr390_probe(struct i2c_client *client)
 	data->gain = 3;
 	/* default mode for ltr390 is ALS mode */
 	data->mode = LTR390_SET_ALS_MODE;
+	/* default value of irq_enabled is false*/
+	data->irq_enabled = false;
 
 	mutex_init(&data->lock);
 
@@ -763,6 +842,7 @@ static int ltr390_probe(struct i2c_client *client)
 					     "request irq (%d) failed\n", client->irq);
 	}
 
+	ltr390_pm_init(data);
 	return devm_iio_device_register(dev, indio_dev);
 }
 
@@ -784,7 +864,28 @@ static int ltr390_resume(struct device *dev)
 				LTR390_SENSOR_ENABLE);
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(ltr390_pm_ops, ltr390_suspend, ltr390_resume);
+static int ltr390_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	return regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL,
+				LTR390_SENSOR_ENABLE);
+}
+
+static int ltr390_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	return regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
+				LTR390_SENSOR_ENABLE);
+}
+
+static const struct dev_pm_ops ltr390_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(ltr390_suspend, ltr390_resume)
+	RUNTIME_PM_OPS(ltr390_runtime_suspend, ltr390_runtime_resume, NULL)
+};
 
 static const struct i2c_device_id ltr390_id[] = {
 	{ "ltr390" },
@@ -802,7 +903,7 @@ static struct i2c_driver ltr390_driver = {
 	.driver = {
 		.name = "ltr390",
 		.of_match_table = ltr390_of_table,
-		.pm = pm_sleep_ptr(&ltr390_pm_ops),
+		.pm = pm_ptr(&ltr390_pm_ops),
 	},
 	.probe = ltr390_probe,
 	.id_table = ltr390_id,
-- 
2.43.0


