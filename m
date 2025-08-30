Return-Path: <linux-iio+bounces-23443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED01B3CA9B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 13:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A023B55C0
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 11:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E8C26D4E5;
	Sat, 30 Aug 2025 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+PuYwey"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D522156A;
	Sat, 30 Aug 2025 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756553716; cv=none; b=ozVHrOAtVDVbQqPkclPCX4P5zgSNTtSW2R6Ajvt1r7iSHRpDTJZ2+UsWX/HV5pMiwJJ4J0yF91Mx0WBhWqHzbzSUKYpf0kBTcCO/N8FQQEYkd1WKXj+deSteuzGoqwJ+v7frlvt6juRRY5WBFDSNUcGsRM9Pd5cCY4FM7Lv4kXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756553716; c=relaxed/simple;
	bh=z8fj2vpxtLn2I6arWaw0NLKbpyvmshuBm+lXpdtaY6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oYqDcwgPTG2fJ89DjlCC+AqAfkbCg88pKno6g0MiYu2d6Ll9HuOU9o0CyMFlJJ+szndsNk7aGKKnGqIuchu3f3jXPt2n0oeQCM3NZOL2caWXZW/Go/lGskQ5Z7t19IJjtbuFqR6XFqK+l4Jon/tCez608RyRWmV4oNSpxd22q1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+PuYwey; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-327f87275d4so1279555a91.1;
        Sat, 30 Aug 2025 04:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756553713; x=1757158513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xwqpb2a4IQQNgbG8Ha8BquFfm5HfQcVJzXAC3P7c0f0=;
        b=k+PuYweyU2nh058rWrgWlpgww8abSR3PR1ZzbsZoiIQIdZ4k8ccFopoM849dZlFgNR
         9SoOcIDdqbBZAsdiMOypTFD4z5VUckzFQBPSbJiJ5IQd3dVYlfi0lTEIyXtc2sT6tuPf
         dhxyl1JoqrGh5lbPQeecjUxPIwR1ipSwHr+KpCfvACdg19USMuRiFdCp4tZApMxqpGcw
         RE3CeFQU8RwNLAZhVpvwuwVecU+Ixk3PJSGzIGENrX5Ge5Dncz/NqqUQfZPBkUFssRdn
         OdSoTwSjOvgi2lapnqydX74imOEFNOAK/2CriINzHCHWjGL2bgjgEtkDVjQkxP79a2TL
         z1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756553713; x=1757158513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwqpb2a4IQQNgbG8Ha8BquFfm5HfQcVJzXAC3P7c0f0=;
        b=ZMTZ+0+bF4wFXNc48SmhoUmCutnT+7l63SIsaUG9noljhb9geMZlvGiNpfRQyH5cnR
         hf1y4o7O3L+BHCm1yvXCW8vg9ckTrheRlFXeNjobP5j0mke+9oPe5mf1yktZXyOBfECT
         Z42uTLtThc/qdpvB18i+1fp26i+LwWRPIVTj72XM0f3X24zLK2x+GfCx8hBzXO26ZyXw
         ILtB/f7rMtcGg4ClMqh/jvSAhnHdPCk1wHl9RWEXCf0VTOvZCRtnYPmDiCOUL/JjZcSd
         nK0ivl+98klFGJqHJHtWpsrwErEwnkmqcdGLxdmA6Q7FM99VkhzXkHzUsFtruKbu4Up/
         SPyg==
X-Forwarded-Encrypted: i=1; AJvYcCVYZapxenVTGi8gRWXK0itq8JoIGhONeugac/mi/vsrrmVSey+/wCGnXDo6ob4SVRHvHyFrO0m2l8f8alob@vger.kernel.org, AJvYcCXpmCQOoe5Ynf9+U/Qe3KrgiNu9VR9VpZFBO4gsYu2k0ngFv+Nezqs9LNQUwgBjix7TGrJG4xjj8/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YywphCkzQuSzb5LNRhoPNdT2sIqQ54REFroZLZif2Nk4tB29Lvb
	82Hsobrvu9/Xsdki7Tn2/d6Moujmp0vV9wyYXc8JJ0GsGCv+2JJRXG7u
X-Gm-Gg: ASbGncvNHD90Npu1clW6xCXrA9G8rx5IgpPXw6wG7Ry42K2KaydDlPolQGut1fe1N+O
	r/Fc6vMi2hGYYSay4U1ICdXx+qtRLCyZYMe+yUXMieHKjY4xW1Yh6i3/hnIgrp4zQXEJayeA4nH
	HxC4/E+kl8UVVAN6+6TB2spC525MJrpZpRORyrEfeoonWpdPLFuH1r0hnnHiBhI9aHkLkI6Vl4r
	SZVr9qt4QK2kjV1JB4Ds+b6M8/xYo8WhD2RN9/y9RUCnWmsFHRpdiWOG1UPWRzEn897MY1+eRrj
	miOBXlOY+15t52cuiBgdS2mtIVanAPHd9XjSqewQ5ovn7OjS96gD6hv3CB31PGrDutPbLgXhFO3
	rb38J+l2e6DbF9G0KqQKVYKH67ATjhBHzJvOMLw==
X-Google-Smtp-Source: AGHT+IHM7IQ7P25iVf9M/DG1RNHv6hDcx+5FbCkwa9HPBwhuiD+105B6Sn3ORVz0IZNmoq1sxJkbjA==
X-Received: by 2002:a17:902:ccce:b0:248:a1d1:28ae with SMTP id d9443c01a7336-24944a9af16mr26443205ad.39.1756553713424;
        Sat, 30 Aug 2025 04:35:13 -0700 (PDT)
Received: from akshayaj-lenovo.. ([2401:4900:883a:e1ca:4a10:7152:c624:1f18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490373a3a9sm50048225ad.50.2025.08.30.04.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:35:12 -0700 (PDT)
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
Subject: [PATCH v3] iio: light: ltr390: Implement runtime PM support
Date: Sat, 30 Aug 2025 17:05:00 +0530
Message-ID: <20250830113502.83102-1-akshayaj.lkd@gmail.com>
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

 drivers/iio/light/ltr390.c | 223 ++++++++++++++++++++++++++++++++++---
 1 file changed, 206 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 2e1cf62e8201..155aa4cfa7e5 100644
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
+	int ret;
+	struct ltr390_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
+		return ret;
+	}
+
+	ret = __ltr390_write_raw(indio_dev, chan, val, val2, mask);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
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
@@ -546,7 +590,31 @@ static int ltr390_read_event_value(struct iio_dev *indio_dev,
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
+	int ret;
+	struct ltr390_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
+		return ret;
+	}
+
+	ret = __ltr390_read_event_value(indio_dev, chan, type, dir,
+					info, val, val2);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static int __ltr390_write_event_value(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
 				enum iio_event_direction dir,
@@ -571,22 +639,55 @@ static int ltr390_write_event_value(struct iio_dev *indio_dev,
 	}
 }
 
+static int ltr390_write_event_value(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	int ret;
+	struct ltr390_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
+		return ret;
+	}
+
+	ret = __ltr390_write_event_value(indio_dev, chan, type, dir,
+					info, val, val2);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
 static int ltr390_read_event_config(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
 				enum iio_event_direction dir)
 {
 	struct ltr390_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
 	int ret, status;
 
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
+		return ret;
+	}
+
 	ret = regmap_read(data->regmap, LTR390_INT_CFG, &status);
+
+	pm_runtime_put_autosuspend(dev);
+
 	if (ret < 0)
 		return ret;
-
 	return FIELD_GET(LTR390_LS_INT_EN, status);
 }
 
-static int ltr390_write_event_config(struct iio_dev *indio_dev,
+static int __ltr390_write_event_config(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
 				enum iio_event_direction dir,
@@ -598,7 +699,6 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
 	if (!state)
 		return regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
 
-	guard(mutex)(&data->lock);
 	ret = regmap_set_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
 	if (ret < 0)
 		return ret;
@@ -623,18 +723,60 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
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
 {
 	struct ltr390_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+	int ret;
 
-	guard(mutex)(&data->lock);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
+		return ret;
+	}
 
+	guard(mutex)(&data->lock);
 	if (readval)
-		return regmap_read(data->regmap, reg, readval);
+		ret = regmap_read(data->regmap, reg, readval);
+	else
+		ret = regmap_write(data->regmap, reg, writeval);
 
-	return regmap_write(data->regmap, reg, writeval);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
 }
 
 static const struct iio_info ltr390_info = {
@@ -687,15 +829,36 @@ static void ltr390_powerdown(void *priv)
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
@@ -708,6 +871,8 @@ static int ltr390_probe(struct i2c_client *client)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	i2c_set_clientdata(client, indio_dev);
+
 	data = iio_priv(indio_dev);
 	data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
 	if (IS_ERR(data->regmap))
@@ -721,6 +886,8 @@ static int ltr390_probe(struct i2c_client *client)
 	data->gain = 3;
 	/* default mode for ltr390 is ALS mode */
 	data->mode = LTR390_SET_ALS_MODE;
+	/* default value of irq_enabled is false*/
+	data->irq_enabled = false;
 
 	mutex_init(&data->lock);
 
@@ -763,6 +930,7 @@ static int ltr390_probe(struct i2c_client *client)
 					     "request irq (%d) failed\n", client->irq);
 	}
 
+	ltr390_pm_init(data);
 	return devm_iio_device_register(dev, indio_dev);
 }
 
@@ -784,7 +952,28 @@ static int ltr390_resume(struct device *dev)
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
@@ -802,7 +991,7 @@ static struct i2c_driver ltr390_driver = {
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


