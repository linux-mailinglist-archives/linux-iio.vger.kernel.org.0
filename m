Return-Path: <linux-iio+bounces-23909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F664B5068F
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 21:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165A41C63E2D
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 19:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BFE303A1A;
	Tue,  9 Sep 2025 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQd6sjqn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D8D236437;
	Tue,  9 Sep 2025 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447233; cv=none; b=NwtEpgwWq0e87jl6YbIgdW9FflA49PhgVAe2GSMrycDaVINoJBO+g8uit96pLAGmKKskJrgCYkVAigLTG1GiH5jTNoaJF4GsPD+TUCayFNcJHs/OdpfTxJNdJ+erSEtIl/SdlSRBHlVvP1WlYdZ8FXDqq1mFRG9SRCYVh2rHV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447233; c=relaxed/simple;
	bh=blr2JsUwfJTG6j8i777wT0PvTRhIAx9eiDAi8Pac/mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bciULfKQ42YCbvKnCV/ApZrJ3ZccNDoZzIVKN8Jo8bGhizpb6Iu4TJukqxC2VcMpnBnSaY5u/OAYGnpMX9eRfJoM8uB7rknBPAVOaAOMv1YmzGoVV78Wh2epgD1YLxahGZ+VdlfPGH/ktkCCyQdui0xbzc1ZPPafN4N0z8HdO1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQd6sjqn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-251ace3e7caso46939785ad.2;
        Tue, 09 Sep 2025 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757447230; x=1758052030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2Jw4IbrDKGZif5Bmabb998y3P9H+RiSbvQDf3HtJz0=;
        b=fQd6sjqnspc3khM5QKclD9wUoHrZy3OCW4POiw+TcQTLFeX96NbVXgKWyQqY3auXiG
         vgCdr6+Ze1+WoF1e0+Qa8maEm0KKCWepJy5Pig9cGpnGFz2RH67wjtjHJhQCLJCcV3mh
         fv2ZIgrc/ejm6OeH6ecdfGWxPr4mBzrFyt2sXwReigu6MKRDMTwKLE+Hx9ey8QSivq2c
         llk+hG5H/1Ximrev/MSImsX7wLs2/eobGXr/IavxRyUD9V8Vj+BWpciVREGCsVfenVcw
         gKjdxBLHkS5AsBCBL/JnT5ZkEXcaCTSJg0hLk6vWS0NZnPUWWCNPCVTV5/JJ16acs2hD
         rHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757447230; x=1758052030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2Jw4IbrDKGZif5Bmabb998y3P9H+RiSbvQDf3HtJz0=;
        b=Rg5+JkVowhZVA5UcFuRXhC32hdquYiNfLrJkTqr0l2PaGhM1uYvpikDHl+UW50ydVN
         QvAgYfThurQsAlPlSWinwkhYvizNL1O6p2JxbQkfClmX+kxq+FIAJNdGei9vaaTd/bqO
         oriHkBAnkBBLAunSVQxpn/I5eVKlcIeqjziD1N8DynkxZRze1gdrmuKrsSnbf8K2wp2G
         fS8KcLI527KMM9N7HQPYHB++FSp4MD872eqO4NtalWW/ygO9gQKJLirtFSeB86kxYc2N
         gsBfE5iXBcjolVCn/R9tD3XF3CdATNt/aTnpwFyXnG+bLckj+/5kfl3Ohw4TrFkznQkC
         eQcA==
X-Forwarded-Encrypted: i=1; AJvYcCUq+rTBkiIvwCxoaVkekc3D1zhI4Bmqm95X4Eg8/OxeQi/WHsZBmiOHoDR9HO+DfYSsqkQRpShitKqwRI8Q@vger.kernel.org, AJvYcCVnEkg2S/5k4GZoO4fZUBe40YAxZXnSh1FjF5qigii8CdqI6vHC/bHw0566gioPzC2MKB9ZyD6ajjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzui4JVJ7v8jjZP0dBxzEjRie9QRbN0Y84NRoPsWscQxdxBDAKa
	i3EVmM/mYF1aYZeFnXL5BpcAMnu1X+7hD4hz/7DCq/PGBI5xzSVTYaoN
X-Gm-Gg: ASbGncuxwlDEc0VRncVkK8d5KZJ6MtNGnlaQf4EUnB+3kqyJAtIHjwUjLR8tRkby3Rc
	UQoXliczRGOjCsaB9fRddXbMWwIdOQBTWdDKh6shUwCuFXZXBlwRhYJfl6wfymFrktcRUz1/AQh
	2Yiakxpy5TssvQG6q87KiYBuGZUQm/tboXGF6jyON4URxCXhd+3HWNau6NXh6WnPQ1jFiZ5NdVD
	mV5pduCNlewXcRBuGqBhenvAIzHaZE7p7/grTmT/u2Jaf49dUeF/EB26tHQpwBuWXJahy6kGv4I
	+y4/O0RvNx5oo29KhZ5T4Bmns5jCcve96VKZ5s12Ij0EzhFidrA8zOur3EAT0p7L8HHmqQCElA1
	bD9iaWixJ8mCbCeIsLq6m4BFY6g4yEZfsl0u0D5AICbP0hMe8oGumQJAGpQ==
X-Google-Smtp-Source: AGHT+IFmxDGt6FXqvjdYCSXcyIfS/wMr9nu2X+1B9vWJgYAkVjGNhpz2arl3G2RT399y3eUcR/cyeQ==
X-Received: by 2002:a17:902:f54c:b0:24c:99bd:52bb with SMTP id d9443c01a7336-25171cbfb72mr175204355ad.30.1757447230030;
        Tue, 09 Sep 2025 12:47:10 -0700 (PDT)
Received: from akshayaj-lenovo.. ([2401:4900:8839:3f87:8479:931:d4b0:7db6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a274229basm5812605ad.15.2025.09.09.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 12:47:09 -0700 (PDT)
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
Subject: [PATCH v7] iio: light: ltr390: Implement runtime PM support
Date: Wed, 10 Sep 2025 01:16:46 +0530
Message-ID: <20250909194649.10512-1-akshayaj.lkd@gmail.com>
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
Changes since v6:
=================
1. Jonathan's feedback:
-> Check return value of ltr390_pm_init() and act accordingly.

Changes since v5:
=================
1. Andy's feedback:
-> Fix indentation of parameters.
-> Make dev_err single lined.
-> Ensure proper spacing in the comments.

Changes since v4:
=================
1. Andy's feedback:
-> Fix indentation at various places.
-> Enhance readability of the code by:
--->putting regmap API from multiple lines to a single line.
--->using dev instead of &data->client->dev in dev_info.

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

 drivers/iio/light/ltr390.c | 136 ++++++++++++++++++++++++++++++++-----
 1 file changed, 119 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 2e1cf62e8201..2d8449aeab18 100644
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
+static int ltr390_do_read_raw(struct iio_dev *iio_device,
+			      struct iio_chan_spec const *chan, int *val,
+			      int *val2, long mask)
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
+	ret = ltr390_do_read_raw(iio_device, chan, val, val2, mask);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
 /* integration time in us */
 static const int ltr390_int_time_map_us[] = { 400000, 200000, 100000, 50000, 25000, 12500 };
 static const int ltr390_gain_map[] = { 1, 3, 6, 9, 18 };
@@ -586,11 +610,11 @@ static int ltr390_read_event_config(struct iio_dev *indio_dev,
 	return FIELD_GET(LTR390_LS_INT_EN, status);
 }
 
-static int ltr390_write_event_config(struct iio_dev *indio_dev,
-				const struct iio_chan_spec *chan,
-				enum iio_event_type type,
-				enum iio_event_direction dir,
-				bool state)
+static int ltr390_do_event_config(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  enum iio_event_type type,
+				  enum iio_event_direction dir,
+				  bool state)
 {
 	struct ltr390_data *data = iio_priv(indio_dev);
 	int ret;
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
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     bool state)
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
+	ret = ltr390_do_event_config(indio_dev, chan, type, dir, state);
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
@@ -683,17 +737,38 @@ static irqreturn_t ltr390_interrupt_handler(int irq, void *private)
 static void ltr390_powerdown(void *priv)
 {
 	struct ltr390_data *data = priv;
+	struct device *dev = &data->client->dev;
+	int ret;
 
 	guard(mutex)(&data->lock);
 
 	/* Ensure that power off and interrupts are disabled */
-	if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
-				LTR390_LS_INT_EN) < 0)
-		dev_err(&data->client->dev, "failed to disable interrupts\n");
+	if (data->irq_enabled) {
+		ret = regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
+		if (ret < 0)
+			dev_err(dev, "failed to disable interrupts\n");
+
+		data->irq_enabled = false;
+		pm_runtime_put_autosuspend(&data->client->dev);
+	}
+
+	ret = regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
+	if (ret < 0)
+		dev_err(dev, "failed to disable sensor\n");
+}
+
+static int ltr390_pm_init(struct ltr390_data *data)
+{
+	int ret;
+	struct device *dev = &data->client->dev;
+
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable runtime PM\n");
 
-	if (regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL,
-			LTR390_SENSOR_ENABLE) < 0)
-		dev_err(&data->client->dev, "failed to disable sensor\n");
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
+	return 0;
 }
 
 static int ltr390_probe(struct i2c_client *client)
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
+	/* default value of irq_enabled is false */
+	data->irq_enabled = false;
 
 	mutex_init(&data->lock);
 
@@ -763,6 +842,10 @@ static int ltr390_probe(struct i2c_client *client)
 					     "request irq (%d) failed\n", client->irq);
 	}
 
+	ret = ltr390_pm_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize runtime PM\n");
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 
@@ -784,7 +867,26 @@ static int ltr390_resume(struct device *dev)
 				LTR390_SENSOR_ENABLE);
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(ltr390_pm_ops, ltr390_suspend, ltr390_resume);
+static int ltr390_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	return regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
+}
+
+static int ltr390_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	return regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
+}
+
+static const struct dev_pm_ops ltr390_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(ltr390_suspend, ltr390_resume)
+	RUNTIME_PM_OPS(ltr390_runtime_suspend, ltr390_runtime_resume, NULL)
+};
 
 static const struct i2c_device_id ltr390_id[] = {
 	{ "ltr390" },
@@ -802,7 +904,7 @@ static struct i2c_driver ltr390_driver = {
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


