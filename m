Return-Path: <linux-iio+bounces-24880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A02C0BCA648
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 19:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 841B54F94C0
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 17:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B9E2517A5;
	Thu,  9 Oct 2025 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ctw6rRYY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1070245033
	for <linux-iio@vger.kernel.org>; Thu,  9 Oct 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031377; cv=none; b=DztGBULD3Jm06zrJiGv2NPlnkmQw+fUxtRTjbYkSZqVZeGX4Xr6B0Av+FzGtGPH+VCj/sJzAg0AGmNJ1MShKHolDtr+54+3kHBt4xM+uwF0LurJAenNKc0edK3V5kJVj1QtE+UbwGIcN5xWdXNnLiX2xjViBWzFAmGC9PO3GEw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031377; c=relaxed/simple;
	bh=662BiyGdXv2W9DnviRmUVMwteKePLQpJjJoJLBRK16s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fBZqhhaLxo0f+83AL3fKxz6rKQt+JbDD8J3lnRe0hQlg3Cg8RkZUeUAvz1huV7JYkW/afkYibsxDVHTCOHwqDChyoCpULBjjLkPuZfKlDLmueQY0CC86jLTCrip32UtAKbN8IOfTzHnne9667X4iFX1srDKTTVyGq1oOUtgy6f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ctw6rRYY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b40f11a1027so217023966b.2
        for <linux-iio@vger.kernel.org>; Thu, 09 Oct 2025 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760031373; x=1760636173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoTylyozS+A8FmhwbVNYmrXgdsEgCAS7YMtlxoSU5ak=;
        b=Ctw6rRYYWzkJZPF7DufMU0VWVBUJIq58Z7kmsFLgUa6tF2FQrGMYpvZqtUfYvAHcjP
         cm0KJ6kcDoXGg2sy6qt2UKxZ85rox9JJYQxeJKI1LTIglAd27IMJz9g2At6KPZJp9be1
         aHRNYuGOiomtb1XHg1ymSxTSX9PLHsmUoBril/Zy/H+iIlm4ynLLCnlil50t8KULMiY0
         ZUVq8rI4vgRpaubzS2jgvLU76+0PqPtI9OS0wB2J6LvWNEdjqkp2wHasALMW1pf2B3NL
         GJfPujgMfj1aNWPhgaEtcSSc8T82gefbVNO6uhe4IZQRdsb8KDfvdgDdrQVNpL5NRwo9
         oufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760031373; x=1760636173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoTylyozS+A8FmhwbVNYmrXgdsEgCAS7YMtlxoSU5ak=;
        b=CLVuH+iinzXD5LIyQfbx74FqJmYWr5eAyCwgh2SYi2P/RRsU/GqsPgMvpKQg9Vq8W3
         RTIGHIq5pkJ1tF8S7W27hRV4Wyzef0VVvtUjOpBV1Dg7uJ4Tt6PLxFzo0/xgMIY8tCAH
         L5lmPdNrTenqooADmWwAWpUOOSnr3eWCSja2lAc9lkM6SLiFlEz+3KVCCxLV2pYLRaaa
         vpMkBxFd/5m8t6XzyQ056bKib/GYUo/O06ymK/UqfcNGTcVqCCu0nDkrTO5uv5ZeSpYc
         xK27niVRVO1LMrmZ+k1Uk7y0zsbzUoOgPh/1mt0q97cY/1vOQkT8xSHf1t+NudjmaC1U
         8DLw==
X-Forwarded-Encrypted: i=1; AJvYcCXNkNA2WIONI6iiNqhNlwYq5QWwiZ7yRH3s7vr2Y09HCftDRMdNrGb4kVGTGhKQw6SXIRIRwKWAcrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfz0LlT1IzopImkf/ofv8USmarL3dQWiZwbci+Q9zpMAroNtYJ
	bN9H3rfL6BdXr2sxG+s8ZkqGRGesGrhDwcSgV2yMw3cJ9CTc3CunM8wXEeaPDZPiW+4=
X-Gm-Gg: ASbGnctDkSh2sbe/yLxGTZYlkm0VvJIB/RCrhGbMLPSSGolYF2ADODXe+X2sdqe/fZf
	FLVqRrbh8Q1zVYoqYgQbEJ5wY1c1Zwc3u0xctGaHIEXhqF7BcpGdNJwrAFYHoK8nkPYyXB27HJk
	N+7QAgMl6wD80KZSO5t79ihBudMWwS4H49EBTqiHOLAMFJfwDcE3KYXzd8ST4Oqi+cvPV3osSXU
	WvAlNOFdaFmmJVvxOE+3TCdkRQ8ffk1JokmDj8lrsSuNkEgV5ZMx33JzwzCKhRLGZmTYvdem2Z5
	Xei0jwWnaDgHW5MnEuOf6fABIo/iD5PrH1DhLKXylFEyKKuxFeDP6u7EklOl8QoyO7RP7pYcOtO
	hG5bPGzVANhIe6B1YJg==
X-Google-Smtp-Source: AGHT+IECXQsPVZsJ1vwB/FI0Fbvge/Nu/eIo282pruMpUqeY1GNHAGbfE3u1dgTRp5uHxf8RrgnQTw==
X-Received: by 2002:a17:906:af09:b0:b3d:b251:cdec with SMTP id a640c23a62f3a-b50abfd5e91mr769738866b.37.1760031372661;
        Thu, 09 Oct 2025 10:36:12 -0700 (PDT)
Received: from localhost ([151.35.157.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d9a4054fsm20861666b.89.2025.10.09.10.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:36:12 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate
Date: Thu,  9 Oct 2025 19:36:09 +0200
Message-Id: <20251009173609.992452-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009173609.992452-1-flavra@baylibre.com>
References: <20251009173609.992452-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8237; i=flavra@baylibre.com; h=from:subject; bh=662BiyGdXv2W9DnviRmUVMwteKePLQpJjJoJLBRK16s=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo5/JF0/zE7bUAgiArKHuvRfIYia9JPAZe2DGpA QTKh3f75buJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaOfyRQAKCRDt8TtzzpQ2 X8b7DACEzYtzZ8wMSkuBAmiOv9BZCw69tF35aQmA9AKjWBI7cHEyA02jrjQNcnRSN73oBS8J/+N tKWbKBKm7nBTICGSz/y6NaY1QVKZiiQqlhbOACPCWK5aZf7E6xOf7THojnMphu2DtwmXQryGaMi LF8HsJ0QkllRBqmW6ZL12L55HQS0by3UWKjPfby0AnrxkX77YfFC71amB39Ln3OumjLOLRFG2de G6aDIJ671q9hEkLl6iO4G8Gku6N5Chtkwg+7ShZ06wpQnumAsbuDUvPQPwV2QUKQ0JMex2/00C5 0kfehSCZDuCE6ljgdYV9g3csZ8piKXsXqADk8q8lVmvVa+L/UiESlZcKQdzRD9Ayrxb3RNCHm+Q xi1DDITGsntMQogL/PDNh4nAbI1uEfvfyEXyltT9Ck7cEM5AaSYou0umqZpoKwKKwUIvU+AGCbd X8jVQ20RMCovetPpmwwh/Oc3iHs8UrUCmamSZmJuhqD2HfcR5M+fiGuCcynMfSAz1d4as=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The rate at which accelerometer or gyroscope sensor samples are fed
to the hardware FIFO (batch data rate, or BDR) does not have to
coincide with the sensor sampling frequency (output data rate, or
ODR); the only requirement is for the BDR to not be greater than
the ODR. Having a BDR lower than the ODR is useful in cases where
an application requires a high sampling rate for accurate detection
of motion events (e.g. wakeup events), but wants to read sensor
sample values from the device buffer at a lower data rate.
To support the above use case, add a sampling_frequency sysfs
attribute to the buffer directory of st_lsm6dsx IIO devices, which
controls the BDR for a given sensor independently from the "main"
sampling_frequency attribute (which controls the ODR); introduce a
new `bdr` field in struct st_lsm6dsx_sensor to keep track of the
current BDR value, and use this field instead of the `odr` field in
the code that deals with the FIFO data rate. In the sensor hub
driver, make the bdr value always mirror the odr value, since there
is no separate configuration setting to control the BDR for data
produced by the sensor hub functionality.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 +
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 64 ++++++++++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  9 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  4 +-
 4 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index bd366c6e282a..dc4aeea3a3b8 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -366,6 +366,7 @@ enum st_lsm6dsx_fifo_mode {
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  * @gain: Configured sensor sensitivity.
  * @odr: Output data rate of the sensor [mHz].
+ * @bdr: Batch data rate [mHz]
  * @samples_to_discard: Number of samples to discard for filters settling time.
  * @watermark: Sensor watermark level.
  * @decimator: Sensor decimation factor.
@@ -380,6 +381,7 @@ struct st_lsm6dsx_sensor {
 
 	u32 gain;
 	u32 odr;
+	u32 bdr;
 
 	u16 samples_to_discard;
 	u16 watermark;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 8a9d2593576a..5912ea76d493 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -56,6 +56,7 @@
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/sysfs.h>
 #include <linux/regmap.h>
 #include <linux/bitfield.h>
 
@@ -105,7 +106,7 @@ static int
 st_lsm6dsx_get_decimator_val(struct st_lsm6dsx_sensor *sensor, u32 max_odr)
 {
 	const int max_size = ARRAY_SIZE(st_lsm6dsx_decimator_table);
-	u32 decimator =  max_odr / sensor->odr;
+	u32 decimator =  max_odr / sensor->bdr;
 	int i;
 
 	if (decimator > 1)
@@ -136,14 +137,14 @@ static void st_lsm6dsx_get_max_min_odr(struct st_lsm6dsx_hw *hw,
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
 
-		*max_odr = max_t(u32, *max_odr, sensor->odr);
-		*min_odr = min_t(u32, *min_odr, sensor->odr);
+		*max_odr = max_t(u32, *max_odr, sensor->bdr);
+		*min_odr = min_t(u32, *min_odr, sensor->bdr);
 	}
 }
 
 static u8 st_lsm6dsx_get_sip(struct st_lsm6dsx_sensor *sensor, u32 min_odr)
 {
-	u8 sip = sensor->odr / min_odr;
+	u8 sip = sensor->bdr / min_odr;
 
 	return sip > 1 ? round_down(sip, 2) : sip;
 }
@@ -231,7 +232,7 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 		if (enable) {
 			int err;
 
-			err = st_lsm6dsx_check_odr(sensor, sensor->odr,
+			err = st_lsm6dsx_check_odr(sensor, sensor->bdr,
 						   &data);
 			if (err < 0)
 				return err;
@@ -713,7 +714,7 @@ st_lsm6dsx_update_samples_to_discard(struct st_lsm6dsx_sensor *sensor)
 
 	data = &hw->settings->samples_to_discard[sensor->id];
 	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++) {
-		if (data->val[i].milli_hz == sensor->odr) {
+		if (data->val[i].milli_hz == sensor->bdr) {
 			sensor->samples_to_discard = data->val[i].samples;
 			return;
 		}
@@ -799,6 +800,52 @@ static const struct iio_buffer_setup_ops st_lsm6dsx_buffer_ops = {
 	.postdisable = st_lsm6dsx_buffer_postdisable,
 };
 
+static ssize_t st_lsm6dsx_bdr_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_to_iio_dev(dev));
+	u32 bdr = sensor->bdr;
+
+	return sysfs_emit(buf, "%d.%03d\n", bdr / 1000, bdr % 1000);
+}
+
+static ssize_t st_lsm6dsx_bdr_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct iio_dev *iio_dev = dev_to_iio_dev(dev);
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+	int integer, fract;
+	int ret;
+	u32 bdr;
+	u8 data;
+
+	ret = iio_str_to_fixpoint(buf, 100, &integer, &fract);
+	if (ret)
+		return ret;
+	bdr = integer * 1000 + fract;
+	ret = st_lsm6dsx_check_odr(sensor, bdr, &data);
+	if (ret < 0)
+		return ret;
+	bdr = ret;
+	if (!iio_device_claim_direct(iio_dev))
+		return -EBUSY;
+	/* the batch data rate must not exceed the sensor output data rate */
+	if (bdr <= sensor->odr)
+		sensor->bdr = bdr;
+	else
+		ret = -EINVAL;
+	iio_device_release_direct(iio_dev);
+	return (ret < 0) ? ret : len;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(0664, st_lsm6dsx_bdr_show, st_lsm6dsx_bdr_store);
+
+static const struct iio_dev_attr *st_lsm6dsx_buffer_attrs[] = {
+	&iio_dev_attr_sampling_frequency,
+	NULL
+};
+
 int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 {
 	int i, ret;
@@ -807,8 +854,9 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 		if (!hw->iio_devs[i])
 			continue;
 
-		ret = devm_iio_kfifo_buffer_setup(hw->dev, hw->iio_devs[i],
-						  &st_lsm6dsx_buffer_ops);
+		ret = devm_iio_kfifo_buffer_setup_ext(hw->dev, hw->iio_devs[i],
+						      &st_lsm6dsx_buffer_ops,
+						      st_lsm6dsx_buffer_attrs);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c65ad49829e7..e4922578329e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1847,10 +1847,13 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 
 		val = val * 1000 + val2 / 1000;
 		val = st_lsm6dsx_check_odr(sensor, val, &data);
-		if (val < 0)
+		if (val < 0) {
 			err = val;
-		else
+		} else {
 			sensor->odr = val;
+			/* the batch data rate must not exceed the sensor ODR */
+			sensor->bdr = min_t(u32, sensor->bdr, sensor->odr);
+		}
 		break;
 	}
 	default:
@@ -2383,7 +2386,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	sensor = iio_priv(iio_dev);
 	sensor->id = id;
 	sensor->hw = hw;
-	sensor->odr = hw->settings->odr_table[id].odr_avl[0].milli_hz;
+	sensor->odr = sensor->bdr = hw->settings->odr_table[id].odr_avl[0].milli_hz;
 	sensor->gain = hw->settings->fs_table[id].fs_avl[0].gain;
 	sensor->watermark = 1;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 3c5e65dc0f97..01d73002e888 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -639,7 +639,7 @@ __st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
 			return odr;
 
 		sensor->ext_info.slv_odr = val;
-		sensor->odr = odr;
+		sensor->odr = sensor->bdr = odr;
 		return 0;
 	}
 	case IIO_CHAN_INFO_SCALE:
@@ -745,7 +745,7 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	sensor = iio_priv(iio_dev);
 	sensor->id = id;
 	sensor->hw = hw;
-	sensor->odr = hw->settings->odr_table[ref_id].odr_avl[0].milli_hz;
+	sensor->odr = sensor->bdr = hw->settings->odr_table[ref_id].odr_avl[0].milli_hz;
 	sensor->ext_info.slv_odr = info->odr_table.odr_avl[0].milli_hz;
 	sensor->gain = info->fs_table.fs_avl[0].gain;
 	sensor->ext_info.settings = info;
-- 
2.39.5


