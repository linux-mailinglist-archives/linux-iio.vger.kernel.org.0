Return-Path: <linux-iio+bounces-23160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5131DB321F5
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 20:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9D2627889
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 18:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E1B29B8E5;
	Fri, 22 Aug 2025 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTQcLb/O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411361DFCE;
	Fri, 22 Aug 2025 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885836; cv=none; b=HB+Pyvb7xVzcwjOHDg7MYb5qXizCmeCjirdZ4hrqQvIX30W8Rx+Qq2EC74yVVJBL59jQ7XAoCsuy/2bdiYZ3dCfEXYsz3UQpQAyJ6JCdWbsmHAF9ts+rYpfFG2aRvYMznIUshBjNn5VOR3KKaj0OQit6UfhmepfuFcOK75YI4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885836; c=relaxed/simple;
	bh=kvs6r4FmwVHTWTfP166xYOjh8VLvSOyQFobFLc/d6ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lVB1oCxPdeaD0h196KMRcDGBzifDC1KpWwFHx7WzLRRQoIi+t1YKJzktcF+aEMaGrKk9hYAnqsNrRFhbesFpkpqT0MNSvMPXByjnZW37QBJdCE9pqthu+IN7Bfi3V0lFRJiuLKLlSCXkGx8128bcHUUVtEtSEMGss17uP3UAZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTQcLb/O; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so2371835b3a.1;
        Fri, 22 Aug 2025 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755885833; x=1756490633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=as7LjRJpjkVt1OriGivVfyvVIzUmrZ3h/KQJUKXbTxA=;
        b=QTQcLb/OaTP3kkw+AcGyO7Vh4zRsY0vzN5GCD8XZJZEOgqOJ8f/KPBAwhE/ezHBEiD
         GUcEi+CzTDXmi/715DtKxqOCVFJHpRWijStGoKRs/T27swyxeFbkmqcNeY/MHjx6QLRw
         lfcNmOJcxaNA7tRnU4U14aQr/a8Vlq8e7q6Ui89ckA9kx0eL2T0Ly41TFfVa9SfYnXwH
         UuQ5g8/z2XMkeyhBhwY1cmmFL7b0/G4njqV+Caq1p2mnN01oGNUbZzOx9tCMq6xQ+IP1
         /ufd9dnFSV6qXLfcBVO3y/BJT5WIjJliv9maRw/kOhLtcyc3s+aLGIU7zOFIVz8bVEuy
         8bGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885833; x=1756490633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=as7LjRJpjkVt1OriGivVfyvVIzUmrZ3h/KQJUKXbTxA=;
        b=LUvQmQ6ghgREx4GRqLcNxmSTIC1Dmn+uuH56WsAOduX80Tet3LWzkFzqZ5e5aJOVI2
         i3ikSnPjcWh5XMYrSkB/nykVbJEp1c4Ph1jD9clRtVzl96pmzNdDMj1ka8OcJXtYpM8t
         pTiMPkjE6QYB1dIMWu5PgaydQdZ0FdkJmrXggq+w/hK1rbEdRqwvqHvbnaQdkncZduK3
         GHLrOpsKLnvdenyhC4sMhlWK3nzBJm9hQUFWBS6+j6en04bj+UeVXDZAYfrLAO1fQjq8
         B+G1wrf65CoI12rY6AFCx5gWZ5sXv2F5bGcpIbXq7z2rdKKwX182mGDI3uTPU1jIp9OO
         ugAw==
X-Forwarded-Encrypted: i=1; AJvYcCUOvrPhs5qZxtYPAtTUdvmVWrZlerZxIUSVERuinNMX5rX+t2kPkYnalpCYClg9hhIeNKBRdIgEY9Q=@vger.kernel.org, AJvYcCUVmgg+U35rDvljUwwdxPgehRs0xMTq2on3dcM86ZdxC5CSRGO46XJ2PTzXT6dWLQmB/JiOj80WCD3k2hao@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd6D5AOAluALnwQZFbt6ZIWpdrSVqt44YHIBwJZMPzqEyh/mGx
	ltCqEP8baQi+1w0M393ZtKj4a53GCL2lQFRm2R9pP81VPhSDi8gYeNkxmjviiw==
X-Gm-Gg: ASbGncsDo1IAGpgdOs9/GZ2MholFUXKuYtrNUxTdsD5gRxtQLqxhdAFJ1Zd4y4zy+fO
	UVgYWBSGOyJ4N7JS5xTiicQRuFESI6+cpQtcA0TtEltAqbO45Hz5nOYpBQwi7Gc7IVuiv81ST1d
	XaQ12b/xSbd1DmZMfvHCmJa065YP7zaYw4MOYgiAqsaLXYRKg2exsKf1VbOhOMPr8sBrtHOr9gi
	8Xki4hMAkQbkFNav67M4DXPhXyNMfWqvNbxsVy9Z8mS95cHof0fDEg/nG4s2vwQ41phnFGlpxff
	HYStrQPmsGad4Cm/8gIglaRQL3sGkbrNatNc+BcmTVFZhSkBqpHC8THzYogUFzVXgJWQEZjofDH
	GLAlbtSzeK/mkj4PhnnIDcslcl4L+jTDT4SFKKQ==
X-Google-Smtp-Source: AGHT+IFUjqt7ot5kjjqAB6htTsXdyhPSX7nHr8w+gMcbwjy+v93NQmq/NRGZAdsufaEBS5aapjQVSA==
X-Received: by 2002:a05:6a20:3ca8:b0:240:7ed:4018 with SMTP id adf61e73a8af0-24340d8bbb7mr5423943637.15.1755885833237;
        Fri, 22 Aug 2025 11:03:53 -0700 (PDT)
Received: from akshayaj-lenovo.. ([2401:4900:8838:dd7a:1a46:348e:25e0:d970])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ec65fsm488118b3a.76.2025.08.22.11.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:03:52 -0700 (PDT)
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
Subject: [PATCH] iio: light: ltr390: Add runtime PM support
Date: Fri, 22 Aug 2025 23:33:26 +0530
Message-ID: <20250822180335.362979-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement runtime power management for the LTR390 sensor.
The device would now autosuspend after 1s of idle time.
This would save the overall power consumption by the sensor.

Ensure that interrupts continue to be delivered during
runtime suspend by disabling the sensor only when no
interrupts are enabled. This prevents loss of events
while still allowing power savings when IRQs are unused.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---

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
	a.Since there is no sampling, so no IRQs will be generated. They are only generated when the device is resumed due to I/O on some sysfs attribute from userspace.

 drivers/iio/light/ltr390.c | 246 +++++++++++++++++++++++++++++--------
 1 file changed, 193 insertions(+), 53 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 2e1cf62e8201..9e2f33a401f2 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -30,6 +30,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/events.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/unaligned.h>
 
@@ -105,6 +106,7 @@ struct ltr390_data {
 	enum ltr390_mode mode;
 	int gain;
 	int int_time_us;
+	bool irq_enabled;
 };
 
 static const struct regmap_range ltr390_readable_reg_ranges[] = {
@@ -154,6 +156,25 @@ static const int ltr390_samp_freq_table[][2] = {
 		[7] = { 500, 2000 },
 };
 
+static int ltr390_set_power_state(struct ltr390_data *data, bool on)
+{
+	struct device *dev = &data->client->dev;
+	int ret = 0;
+
+	if (on) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
+			dev_err(dev, "failed to resume runtime PM: %d\n", ret);
+			return ret;
+		}
+	} else {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
+
+	return ret;
+}
+
 static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
 {
 	struct device *dev = &data->client->dev;
@@ -223,61 +244,76 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 	struct ltr390_data *data = iio_priv(iio_device);
 
 	guard(mutex)(&data->lock);
+
+	ltr390_set_power_state(data, true);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_UVINDEX:
 			ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
 			if (ret < 0)
-				return ret;
+				goto handle_pm;
 
 			ret = ltr390_register_read(data, LTR390_UVS_DATA);
 			if (ret < 0)
-				return ret;
+				goto handle_pm;
 			break;
 
 		case IIO_LIGHT:
 			ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
 			if (ret < 0)
-				return ret;
+				goto handle_pm;
 
 			ret = ltr390_register_read(data, LTR390_ALS_DATA);
 			if (ret < 0)
-				return ret;
+				goto handle_pm;
 			break;
 
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			goto handle_pm;
 		}
 		*val = ret;
-		return IIO_VAL_INT;
+		ret = IIO_VAL_INT;
+		break;
+
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_UVINDEX:
 			*val = LTR390_WINDOW_FACTOR * LTR390_FRACTIONAL_PRECISION;
 			*val2 = ltr390_counts_per_uvi(data);
-			return IIO_VAL_FRACTIONAL;
+			ret = IIO_VAL_FRACTIONAL;
+			break;
 
 		case IIO_LIGHT:
 			*val = LTR390_WINDOW_FACTOR * 6 * 100;
 			*val2 = data->gain * data->int_time_us;
-			return IIO_VAL_FRACTIONAL;
+			ret = IIO_VAL_FRACTIONAL;
+			break;
 
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
 		}
+		break;
 
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = data->int_time_us;
-		return IIO_VAL_INT;
+		ret = IIO_VAL_INT;
+		break;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = ltr390_get_samp_freq_or_period(data, LTR390_GET_FREQ);
-		return IIO_VAL_INT;
+		ret = IIO_VAL_INT;
+		break;
 
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+handle_pm:
+	ltr390_set_power_state(data, false);
+	return ret;
 }
 
 /* integration time in us */
@@ -418,30 +454,43 @@ static int ltr390_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec con
 static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
 				int val, int val2, long mask)
 {
+	int ret;
 	struct ltr390_data *data = iio_priv(indio_dev);
 
+	ltr390_set_power_state(data, true);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		if (val2 != 0)
-			return -EINVAL;
-
-		return ltr390_set_gain(data, val);
+		if (val2 != 0) {
+			ret = -EINVAL;
+			goto handle_pm;
+		}
 
+		ret = ltr390_set_gain(data, val);
+		break;
 	case IIO_CHAN_INFO_INT_TIME:
-		if (val2 != 0)
-			return -EINVAL;
-
-		return ltr390_set_int_time(data, val);
+		if (val2 != 0) {
+			ret = -EINVAL;
+			goto handle_pm;
+		}
 
+		ret = ltr390_set_int_time(data, val);
+		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val2 != 0)
-			return -EINVAL;
-
-		return ltr390_set_samp_freq(data, val);
+		if (val2 != 0) {
+			ret = -EINVAL;
+			goto handle_pm;
+		}
 
+		ret = ltr390_set_samp_freq(data, val);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+handle_pm:
+	ltr390_set_power_state(data, false);
+	return ret;
 }
 
 static int ltr390_read_intr_prst(struct ltr390_data *data, int *val)
@@ -534,16 +583,24 @@ static int ltr390_read_event_value(struct iio_dev *indio_dev,
 				enum iio_event_info info,
 				int *val, int *val2)
 {
+	int ret;
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	ltr390_set_power_state(data, true);
+
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
-		return ltr390_read_threshold(indio_dev, dir, val, val2);
-
+		ret = ltr390_read_threshold(indio_dev, dir, val, val2);
+		break;
 	case IIO_EV_INFO_PERIOD:
-		return ltr390_read_intr_prst(iio_priv(indio_dev), val);
-
+		ret = ltr390_read_intr_prst(iio_priv(indio_dev), val);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+	ltr390_set_power_state(data, false);
+	return ret;
 }
 
 static int ltr390_write_event_value(struct iio_dev *indio_dev,
@@ -553,22 +610,35 @@ static int ltr390_write_event_value(struct iio_dev *indio_dev,
 				enum iio_event_info info,
 				int val, int val2)
 {
+	int ret;
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	ltr390_set_power_state(data, true);
+
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
-		if (val2 != 0)
-			return -EINVAL;
-
-		return ltr390_write_threshold(indio_dev, dir, val, val2);
+		if (val2 != 0) {
+			ret = -EINVAL;
+			goto handle_pm;
+		}
 
+		ret = ltr390_write_threshold(indio_dev, dir, val, val2);
+		break;
 	case IIO_EV_INFO_PERIOD:
-		if (val2 != 0)
-			return -EINVAL;
-
-		return ltr390_write_intr_prst(iio_priv(indio_dev), val);
+		if (val2 != 0) {
+			ret = -EINVAL;
+			goto handle_pm;
+		}
 
+		ret = ltr390_write_intr_prst(iio_priv(indio_dev), val);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+handle_pm:
+	ltr390_set_power_state(data, false);
+	return ret;
 }
 
 static int ltr390_read_event_config(struct iio_dev *indio_dev,
@@ -579,7 +649,12 @@ static int ltr390_read_event_config(struct iio_dev *indio_dev,
 	struct ltr390_data *data = iio_priv(indio_dev);
 	int ret, status;
 
+	ltr390_set_power_state(data, true);
+
 	ret = regmap_read(data->regmap, LTR390_INT_CFG, &status);
+
+	ltr390_set_power_state(data, false);
+
 	if (ret < 0)
 		return ret;
 
@@ -595,32 +670,43 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
 	struct ltr390_data *data = iio_priv(indio_dev);
 	int ret;
 
-	if (!state)
-		return regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
+	ltr390_set_power_state(data, true);
 
 	guard(mutex)(&data->lock);
+
+	if (!state) {
+		ret = regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
+		data->irq_enabled = false;
+		goto handle_pm;
+	}
+
 	ret = regmap_set_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
 	if (ret < 0)
-		return ret;
+		goto handle_pm;
+	data->irq_enabled = true;
 
 	switch (chan->type) {
 	case IIO_LIGHT:
 		ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
 		if (ret < 0)
-			return ret;
-
-		return regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_SEL_UVS);
+			goto handle_pm;
 
+		ret = regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_SEL_UVS);
+		break;
 	case IIO_UVINDEX:
 		ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
 		if (ret < 0)
-			return ret;
-
-		return regmap_set_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_SEL_UVS);
+			goto handle_pm;
 
+		ret = regmap_set_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_SEL_UVS);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+handle_pm:
+	ltr390_set_power_state(data, false);
+	return ret;
 }
 
 static int ltr390_debugfs_reg_access(struct iio_dev *indio_dev,
@@ -628,13 +714,19 @@ static int ltr390_debugfs_reg_access(struct iio_dev *indio_dev,
 						unsigned int *readval)
 {
 	struct ltr390_data *data = iio_priv(indio_dev);
+	int ret;
 
 	guard(mutex)(&data->lock);
 
+	ltr390_set_power_state(data, true);
+
 	if (readval)
-		return regmap_read(data->regmap, reg, readval);
+		ret = regmap_read(data->regmap, reg, readval);
+	else
+		ret = regmap_write(data->regmap, reg, writeval);
 
-	return regmap_write(data->regmap, reg, writeval);
+	ltr390_set_power_state(data, false);
+	return ret;
 }
 
 static const struct iio_info ltr390_info = {
@@ -690,12 +782,32 @@ static void ltr390_powerdown(void *priv)
 	if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
 				LTR390_LS_INT_EN) < 0)
 		dev_err(&data->client->dev, "failed to disable interrupts\n");
+	data->irq_enabled = false;
 
 	if (regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL,
 			LTR390_SENSOR_ENABLE) < 0)
 		dev_err(&data->client->dev, "failed to disable sensor\n");
 }
 
+static int ltr390_pm_init(struct ltr390_data *data)
+{
+	int ret;
+	struct device *dev = &data->client->dev;
+
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+					"failed to enable powermanagement\n");
+
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
+	return 0;
+}
+
 static int ltr390_probe(struct i2c_client *client)
 {
 	struct ltr390_data *data;
@@ -708,6 +820,8 @@ static int ltr390_probe(struct i2c_client *client)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	i2c_set_clientdata(client, indio_dev);
+
 	data = iio_priv(indio_dev);
 	data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
 	if (IS_ERR(data->regmap))
@@ -721,6 +835,8 @@ static int ltr390_probe(struct i2c_client *client)
 	data->gain = 3;
 	/* default mode for ltr390 is ALS mode */
 	data->mode = LTR390_SET_ALS_MODE;
+	/* default irq_enabled is false */
+	data->irq_enabled = false;
 
 	mutex_init(&data->lock);
 
@@ -763,6 +879,7 @@ static int ltr390_probe(struct i2c_client *client)
 					     "request irq (%d) failed\n", client->irq);
 	}
 
+	ltr390_pm_init(data);
 	return devm_iio_device_register(dev, indio_dev);
 }
 
@@ -784,7 +901,30 @@ static int ltr390_resume(struct device *dev)
 				LTR390_SENSOR_ENABLE);
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(ltr390_pm_ops, ltr390_suspend, ltr390_resume);
+static int ltr390_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->lock);
+	if (data->irq_enabled)
+		return 0;
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
+static _DEFINE_DEV_PM_OPS(ltr390_pm_ops,
+		ltr390_suspend, ltr390_resume,
+		ltr390_runtime_suspend, ltr390_runtime_resume, NULL);
 
 static const struct i2c_device_id ltr390_id[] = {
 	{ "ltr390" },
@@ -802,7 +942,7 @@ static struct i2c_driver ltr390_driver = {
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


