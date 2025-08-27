Return-Path: <linux-iio+bounces-23330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD3CB38A22
	for <lists+linux-iio@lfdr.de>; Wed, 27 Aug 2025 21:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060687C08BF
	for <lists+linux-iio@lfdr.de>; Wed, 27 Aug 2025 19:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5518C2D6603;
	Wed, 27 Aug 2025 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfMAB+FN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E322EEBB;
	Wed, 27 Aug 2025 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756322377; cv=none; b=XlwSVIAoRWUzku1dHQwJN4H3MRDqFQOp2SU3EXFbimLEYzXa1es1h5LtGr3sB4MHHtbDxtS6gTw268mqKljT0j6aEqFsOyBv3W4JlJXG74GET6Rv9UBcZFxvNcU9NvC2joEf7pJ5su+jYXgVOoFRk5awX7v3qTTbKUJzs+tXFMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756322377; c=relaxed/simple;
	bh=R6K773nmtlbiIyFkfxyc2bZreNKCVIqp6v+irVh34EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kDq4STPZbkiLW4hxnsslIz1+At6RSFruZqGAWWxpO9VPCVohYZPqq2eo1qulm0LF3TuOU+DYMbpEJKp3UILXQnsfCi2R5RE5UqY8YeU/B7BKR/EgTi8mIR2zUwu3aoZ1tDdwVydI02UiQtHTYNCtZPjlI3ndrX4iSr545EqF7sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfMAB+FN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so204722b3a.1;
        Wed, 27 Aug 2025 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756322374; x=1756927174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QoME5MyOfQeCXcpWO0mnz7jdp+tlBslqqDpPNJrGhQs=;
        b=CfMAB+FN2bA97ZslnBowrPEQYw+K5vgMr82H8Zn5EQT5TLjdhPb6hk8/unQ54byo2u
         AB894KRVzd2+bRUN3Y83yXRwDd7u3tNluRoFHc3Ynvak54+AqxPQxmBHq+syw1tGW3qS
         nDoytRtaOOZK4NRMM5o+uZLMbo/k9tH8jjJbNRmtrbDp+FwbhhD2ty7YwaNjUwX2UMD9
         85aUf6+DnHUwukph1iRtRJd3NrkgqBMbr+x6dhllW+++USMtk2eCj2GYWucuMYrwO9UR
         7iqlL0OgcqBdUXl/2NWaHjceIpV28D6dyDIizFwVcWajsHte766RqsU8nFVPDJXnkKwz
         qfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756322374; x=1756927174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoME5MyOfQeCXcpWO0mnz7jdp+tlBslqqDpPNJrGhQs=;
        b=oo6eoFxX24/d9J4ZZR5qj8/d0tgNH11y3C2nYDXZjHsM61RqvEwP9hYCpV3P/YB0nU
         KE8FaC/r0Zty71WKjdJ/G6k8ONySvUFBaL2gKXS2oH252HOacgx265QIJb4LKkvLaN49
         w7s8U2Ocqvhe9fShXYqd/KMIexITC4yhilz718EHmVeHgej0RqM8n/Yz9OdCM2nhsIWT
         +o770goMd7m0WsuUNd1GDo3zLsaGHohCp8wJTi1p929s+evH+rTtyLX5kv39gtV7V9BN
         iNY/Tu6jxPpKnaJaKeXCjxip99er2Dtycp/mrVC9he/2hCwS9bDXSURU9lA29SE0Q5Lx
         9cuw==
X-Forwarded-Encrypted: i=1; AJvYcCUKpPFcA3j4/z5OqRhwiK0L12kfCYhAiFfV8HhBHYQEkL+sxAJKHHCo9f9votOQoHHwfQi+H02PszA=@vger.kernel.org, AJvYcCWgg3Unzlro/uSgQK0lak/suVOp0K9F1wog2irXFjuiq96qAd/dRpWVMKX6zlXT0LqjDEJRYG3i1u4UP280@vger.kernel.org
X-Gm-Message-State: AOJu0YyQEzVXxXg61pj9efjHxl0NQfNl/h4mWJUdsD5ffb8/A83bs4dL
	wzas1oaVF+2PqbusGISKoFls38vVhCa6svQHqv3PKPW1UD0kFTqH9HWV
X-Gm-Gg: ASbGncuV/MsbHe4W206mnoE0Q/zNrouJjq8PIZzhrnTmt6Dsp8wpHYxPCPjvMy7lS79
	aLobFEJfN07o/HkbtOG4cTR7b+IqjR5jiZZUX6oarM7fEPnIOVb6OzgI9pT4WWMmmsbYNo8HHkr
	JXfXcWZL7DVLKjyKDirA928RfLc79i54FuwIjcsb5dLtsriGt+4cZoovqq9arDmcr5cGIa/81hp
	MQhfa8TIVCCflhrtcU+VNPfuAxnW1aPQIAa8xPySlp00kdmfVJbAX4UCDDT8fSI1md/dW6sUGK2
	adGkxDjBNlPqmxPaHKzg7JAlUmoZEkKDpbtWprNiI0vayEHAo02z7k0d7btz9iJo7Qru9/RB5AM
	kCoS21anKNXiYs7hndeg1CpBk7J1xLelw2+PXj+cquU6w25Ub
X-Google-Smtp-Source: AGHT+IFilpP76jvzaVKOFD5XivQ5eLQkn35VuURGeV5e8xWkKv31eKN/fRbCFbt9vJXsOQ5JKeJtoQ==
X-Received: by 2002:a05:6a20:bb08:b0:243:9587:a774 with SMTP id adf61e73a8af0-2439587aa2fmr6016231637.28.1756322374184;
        Wed, 27 Aug 2025 12:19:34 -0700 (PDT)
Received: from akshayaj-lenovo.. ([2401:4900:883a:884e:f736:2405:c2c2:1010])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771ead8f18bsm8037256b3a.4.2025.08.27.12.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 12:19:33 -0700 (PDT)
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
Subject: [PATCH v2] iio: light: ltr390: Implement runtime PM support
Date: Thu, 28 Aug 2025 00:49:17 +0530
Message-ID: <20250827191919.1361787-1-akshayaj.lkd@gmail.com>
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
-> Tested on Raspberrypi 4B. Following tests were performed.
1. Verified that /sys/bus/i2c/devices/i2c-1/1-0053/power/control contains ‘auto’ value.
2. Verified the /sys/bus/i2c/devices/i2c-1/1-0053/power/autosuspend_delay_ms contains 1000 which is assigned by the driver.
3. Changed the autosuspend_delay_ms value from 1000 to 2000ms and verified it.
        3.1 Verified through the timestamp that whatever autosuspend_delay_ms is set, it is being honoured.
4. Verified that runtime_suspend and runtime_resume callbacks are called whenever any IO is done on a channel attribute.
        4.1 Verified that power/runtime_status first becomes active and then becomes suspended.
        4.2 Verified that power/runtime_active_time keeps on increasing with a delta of autosuspend_delay_ms.

Interrupt Handling Verification:
--------------------------------
1. Verified that when interrupts are enabled on the device, then the device does not get put in standby mode and keeps sampling.
        a. As a result interrupts are delivered to the driver and are handled.
2. Verified that when interrupts are disabled, the device is put in standby mode and stops sampling.
        a.Since there is no sampling, so no IRQs will be generated. They are only generated when the device is resumed due to I/O
	on some sysfs attribute from userspace.
3. Did idempotency check for event enable or disable. This means that occurences like event enable or disable should not
	erroneously increase or decrease the refcount of the device. 

Module load/unload Verification:
--------------------------------
1. Tested that the refcount should reach 0 when events are enabled.
2. Did a test of load after unload.

 drivers/iio/light/ltr390.c | 230 ++++++++++++++++++++++++++++++++++---
 1 file changed, 212 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 2e1cf62e8201..d451bc4c8c7f 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/events.h>
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
+	int ret, retval;
+	struct ltr390_data *data = iio_priv(iio_device);
+	struct device *dev = &data->client->dev;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
+
+	retval = __ltr390_read_raw(iio_device, chan, val, val2, mask);
+
+	ret = pm_runtime_put_autosuspend(dev);
+	if (ret < 0)
+		dev_err(dev, "runtime PM failed to autosuspend: %d\n", ret);
+
+	return retval;
+}
+
 /* integration time in us */
 static const int ltr390_int_time_map_us[] = { 400000, 200000, 100000, 50000, 25000, 12500 };
 static const int ltr390_gain_map[] = { 1, 3, 6, 9, 18 };
@@ -415,7 +439,7 @@ static int ltr390_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec con
 	}
 }
 
-static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+static int __ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
 				int val, int val2, long mask)
 {
 	struct ltr390_data *data = iio_priv(indio_dev);
@@ -444,6 +468,26 @@ static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
 	}
 }
 
+static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			int val, int val2, long mask)
+{
+	int ret, retval;
+	struct ltr390_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
+
+	retval = __ltr390_write_raw(indio_dev, chan, val, val2, mask);
+
+	ret = pm_runtime_put_autosuspend(dev);
+	if (ret < 0)
+		dev_err(dev, "runtime PM failed to autosuspend: %d\n", ret);
+
+	return retval;
+}
+
 static int ltr390_read_intr_prst(struct ltr390_data *data, int *val)
 {
 	int ret, prst, samp_period;
@@ -527,7 +571,7 @@ static int ltr390_write_threshold(struct iio_dev *indio_dev,
 	}
 }
 
-static int ltr390_read_event_value(struct iio_dev *indio_dev,
+static int __ltr390_read_event_value(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
 				enum iio_event_direction dir,
@@ -546,7 +590,32 @@ static int ltr390_read_event_value(struct iio_dev *indio_dev,
 	}
 }
 
-static int ltr390_write_event_value(struct iio_dev *indio_dev,
+static int ltr390_read_event_value(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int *val, int *val2)
+{
+	int ret, retval;
+	struct ltr390_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
+
+	retval = __ltr390_read_event_value(indio_dev, chan, type, dir,
+					info, val, val2);
+
+	ret = pm_runtime_put_autosuspend(dev);
+	if (ret < 0)
+		dev_err(dev, "runtime PM failed to autosuspend: %d\n", ret);
+
+	return retval;
+}
+
+static int __ltr390_write_event_value(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
 				enum iio_event_direction dir,
@@ -571,22 +640,56 @@ static int ltr390_write_event_value(struct iio_dev *indio_dev,
 	}
 }
 
+static int ltr390_write_event_value(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	int ret, retval;
+	struct ltr390_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
+
+	retval = __ltr390_write_event_value(indio_dev, chan, type, dir,
+					info, val, val2);
+
+	ret = pm_runtime_put_autosuspend(dev);
+	if (ret < 0)
+		dev_err(dev, "runtime PM failed to autosuspend: %d\n", ret);
+
+	return retval;
+}
+
 static int ltr390_read_event_config(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
 				enum iio_event_direction dir)
 {
 	struct ltr390_data *data = iio_priv(indio_dev);
-	int ret, status;
+	struct device *dev = &data->client->dev;
+	int ret, retval, status;
 
-	ret = regmap_read(data->regmap, LTR390_INT_CFG, &status);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
-		return ret;
+		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
+
+	retval = regmap_read(data->regmap, LTR390_INT_CFG, &status);
+
+	ret = pm_runtime_put_autosuspend(dev);
+	if (ret < 0)
+		dev_err(dev, "runtime PM failed to autosuspend: %d\n", ret);
 
+	if (retval < 0)
+		return retval;
 	return FIELD_GET(LTR390_LS_INT_EN, status);
 }
 
-static int ltr390_write_event_config(struct iio_dev *indio_dev,
+static int __ltr390_write_event_config(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
 				enum iio_event_direction dir,
@@ -623,18 +726,58 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
+static int ltr390_write_event_config(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				bool state)
+{
+	int ret, retval;
+	struct ltr390_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+
+	if (state && !data->irq_enabled) {
+		data->irq_enabled = true;
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0)
+			dev_err(dev, "runtime PM failed to resume: %d\n", ret);
+	}
+
+	retval = __ltr390_write_event_config(indio_dev, chan, type, dir, state);
+
+	if (!state && data->irq_enabled) {
+		data->irq_enabled = false;
+		ret = pm_runtime_put_autosuspend(dev);
+		if (ret < 0)
+			dev_err(dev, "runtime PM failed to autosuspend: %d\n", ret);
+	}
+
+	return retval;
+}
+
 static int ltr390_debugfs_reg_access(struct iio_dev *indio_dev,
 						unsigned int reg, unsigned int writeval,
 						unsigned int *readval)
 {
 	struct ltr390_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+	int ret, retval;
 
-	guard(mutex)(&data->lock);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
 
+	guard(mutex)(&data->lock);
 	if (readval)
-		return regmap_read(data->regmap, reg, readval);
+		retval = regmap_read(data->regmap, reg, readval);
+	else
+		retval = regmap_write(data->regmap, reg, writeval);
+
+	ret = pm_runtime_put_autosuspend(dev);
+	if (ret < 0)
+		dev_err(dev, "runtime PM failed to autosuspend: %d\n", ret);
 
-	return regmap_write(data->regmap, reg, writeval);
+	return retval;
 }
 
 static const struct iio_info ltr390_info = {
@@ -683,19 +826,44 @@ static irqreturn_t ltr390_interrupt_handler(int irq, void *private)
 static void ltr390_powerdown(void *priv)
 {
 	struct ltr390_data *data = priv;
+	int ret;
 
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
+		ret = pm_runtime_put_autosuspend(&data->client->dev);
+		if (ret < 0)
+			dev_err(&data->client->dev,
+				"runtime PM failed to autosuspend\n");
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
@@ -708,6 +876,8 @@ static int ltr390_probe(struct i2c_client *client)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	i2c_set_clientdata(client, indio_dev);
+
 	data = iio_priv(indio_dev);
 	data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
 	if (IS_ERR(data->regmap))
@@ -721,6 +891,8 @@ static int ltr390_probe(struct i2c_client *client)
 	data->gain = 3;
 	/* default mode for ltr390 is ALS mode */
 	data->mode = LTR390_SET_ALS_MODE;
+	/* default value of irq_enabled is false*/
+	data->irq_enabled = false;
 
 	mutex_init(&data->lock);
 
@@ -763,6 +935,7 @@ static int ltr390_probe(struct i2c_client *client)
 					     "request irq (%d) failed\n", client->irq);
 	}
 
+	ltr390_pm_init(data);
 	return devm_iio_device_register(dev, indio_dev);
 }
 
@@ -784,7 +957,28 @@ static int ltr390_resume(struct device *dev)
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
@@ -802,7 +996,7 @@ static struct i2c_driver ltr390_driver = {
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


