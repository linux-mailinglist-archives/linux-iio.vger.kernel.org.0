Return-Path: <linux-iio+bounces-25160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5343BE4D4C
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 19:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280365E0B0E
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 17:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5B7328B5A;
	Thu, 16 Oct 2025 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qWzbMaPT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E4831B11E
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635293; cv=none; b=qFUFQG8KQdPu5nlZWWSXfTVH+Fm/5P3iLDvdrpFG0rtw0E0o6RQN/CYobFojrgMDlXvyXX69/siFwR5CV2U1f6+fY/p6tYXok+p3iBSSEP/kXDUac4w7h35s2B71nPiggh1tZWYaDFGrZyI6wHFwEUYpvf1VJKQa6p0rOf/MeAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635293; c=relaxed/simple;
	bh=OWmMaB3SrzHnfCDh9K18vjCvQJ2hdy4J/JH+EhrXHlQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=roqXBTQe4H42fpffTs8HzdeY7pwkiLLUVn8r6MbowAwMhdCKQcxBUKbONytomN+gOspv8d2RM0zpkcwZqNGS2MLJD0Ckiek/ssnhIv/oM/PVRCsYWk6GD3SM9hT3UolpcR7V+jRAUKlrRGz9C8nhEs2s3+FtIyMO8S6bKgb4HYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qWzbMaPT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so693667f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760635289; x=1761240089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2Z2ncf+NA62rVuWxzs3s0fNmnAI48xeZMjz51I4PYQ=;
        b=qWzbMaPTGcNzGwdVDGsznXEWjv0U8K9rTbNIwlaJqSZ+66RYBX1t14X1+XhU4RAIQQ
         RqTdzTmsnJBa7trLZuTbBjgLnDpi3pQhYUi+f3GbOvCIGskEel/wrCaLFvJo046oGaJx
         9/LWNq+SeYE8+fYVF8tiM8LzNn2EJ8dMrryIv6i+cdT0ZywtWoHhxni3ESJZhv7p623O
         Ban5UiV5/Re4/MSBn/gQu6Lk0xGPzgFNjP9du2xL51eAzCm8yYxtbrbCpN/GEfG8mUva
         o1fRERZVPJbQTFFfygdWkOOpsVlXxjauuFII9qo9O0p3ZkuvwR0wJmenPRaiyBfN0Vqh
         Lmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635289; x=1761240089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2Z2ncf+NA62rVuWxzs3s0fNmnAI48xeZMjz51I4PYQ=;
        b=TT/dJMC0QDBR5BLQq0ct4HY9jQmew7U+1eRpVFICiLXZelOj/G5vvTKZcoc9snThHp
         i98F7INOplihkJMnWne7YEHnh9ppOj0TEbi5MgHFRiw8NgYzNEidq+TGVHW0VPYMY0wh
         B2C1eTOpj3y0A32sxF50PmQ3/BWR5gjZ47BHZdVPpwdqeD9rPGE5a3BVKXLs2Rixduvs
         oDo8ZBFBk2tGU3+L6VP5OWYUDy16XEmd0VV8uDlk/OHcKG2KHHrdDOyTUCjWDSM4LpAZ
         qpq1ktRCDll00bm0dYsxWA/Bs3D6ZSpqxK7zPtFDS1HImxZx1agoIahaULnTglfr12uw
         wDHw==
X-Forwarded-Encrypted: i=1; AJvYcCVtT4aiEFUzq/CsiedPm6fCALytvQit8xz+ybaHFNQz+soCwEq2X+0FVjSwAMCiSRBWcAC4HjqfaAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZMHF1jZZsAK0yfIzHY/Uni5QoRAZIKaUAPlXamknhHy3nmwur
	5P7uY8IiOhkZ4Jontx7vVfPISa3ltP2JmvbP3UkTwVFbTOAQ/omQZKT4eWYNHedXVSs=
X-Gm-Gg: ASbGncvnA+sPNvqSLzlZY9aCYbNIOc3d8I0MAPyBddDQ/S+3ZriQXXU04nGd1VaP2Zc
	ktaQwjEHttitLuVwoVsmsgDwq+Qol9lVa4Txn1sphCuJaOk9eIvrZTDcSj3jnc39s7bfSFXDurz
	Hgfo8vVE0XzCZgBl5mIXBxPTs3JRMO9HjqhotVfm11rr4OyQF/A5npNN5YB/3f5eOeUk0JDvAc/
	N2obv/xcipEINk1ImnVgcibcbT93SJPR9U+3Ne8iNKGduUfxW4GrL8is7ySBmQOd2Lr8PhLnWdi
	rVDdpWnQ+JuKBisXteYMjC+oZJh9ogWrFrxYm4ud014ZO2UOeOUwcL1YNMSDEbTKOS51nrJe15P
	wEItBiBaSlYP23UYngAthVW2Nc9HOjV0ElRDOKwZJ+nxRiSw=
X-Google-Smtp-Source: AGHT+IG/HhCkm1Gi61ELQRqkvZ3XIKNGqTBZELD2vHrE8vEDDGA4SjyDoHug+ECuSyTQxFMvHAm9vw==
X-Received: by 2002:a05:6000:144a:b0:3ee:114f:f89f with SMTP id ffacd0b85a97d-42704d87e31mr696458f8f.15.1760635288872;
        Thu, 16 Oct 2025 10:21:28 -0700 (PDT)
Received: from localhost ([151.35.142.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1284sm35562724f8f.45.2025.10.16.10.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:21:27 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate
Date: Thu, 16 Oct 2025 19:21:22 +0200
Message-Id: <20251016172122.1220332-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251016172122.1220332-1-flavra@baylibre.com>
References: <20251016172122.1220332-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8512; i=flavra@baylibre.com; h=from:subject; bh=OWmMaB3SrzHnfCDh9K18vjCvQJ2hdy4J/JH+EhrXHlQ=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo8SlGgCckhZixFpg+ln/Nt4QhyFRygHiAprqgN VMlGmYT2iWJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaPEpRgAKCRDt8TtzzpQ2 X/0PC/9o6cpQL6wMMPQZkYMgUz6uYIEIY2stSxgmDL+xIIgRF2RVdetKBSL5uHjErBl6fXObDxU DJeyfSGbkqtILQ4JLBsJuH+eBOXBwk+SgISK4yrZoD2A134wVWjvAppmJZY6sdM8Dy5oM36qDO9 gQ0LDS88V9Iaw4d//MoNfSk6b+QN3dw81c7e16xLCLww1jXF7eQtsB2EESD2kEWuOgnoh6eH4lc tvyVV6cj7HmfGlbt4WdM7SdxYgKlmHQ7HkpPbfxGTpa7cdqN/7pw5C3utVVPbUdRcEB3k0ykifD b1kZRiSfNJ1DZFFwMQkWKPIMJ91CTSuwrov7udsTeeFrW0r3KJ06aG9uxEKpDytJUFteYrNSXue 1bZUobAU6130eyJqCkJZ2X/QTc8D6whgxDy7hS29Xvqkm85ZTdaHO2d2/LNHv83kfyPnpcDtYaZ uT2G3F4bKpvK6hC954GEQgRar9Lx9go+w+LAIS6Ph2x69J+VjCDe/qUjFqv1BoBY1gXhk=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The rate at which accelerometer or gyroscope sensor samples are fed
to the hardware FIFO (batch data rate, or BDR) does not have to
coincide with the sensor sampling frequency (output data rate, or
ODR); the only requirement is for the BDR to not be greater than
the ODR. Having a BDR lower than the ODR is useful in cases where
an application requires a high sampling rate for accurate detection
of motion events (e.g. wakeup events), but wants to read sensor
sample values from the hardware FIFO at a lower data rate (e.g. to
minimize the amount of I2C or SPI traffic and the rate of periodic
interrupts).
To support the above use case, add a sampling_frequency sysfs
attribute to the buffer directory of st_lsm6dsx IIO devices, which
controls the BDR for a given sensor independently from the "main"
sampling_frequency attribute (which controls the ODR); introduce a
new `hwfifo_odr_mHz` field in struct st_lsm6dsx_sensor to keep
track of the current BDR value, and use this field instead of the
`odr` field in the code that deals with the FIFO data rate. In the
sensor hub driver, make the hwfifo_odr_mHz value always mirror the
odr value, since there is no separate configuration setting to
control the BDR for data produced by the sensor hub functionality.
For backwards compatibility, set the buffer frequency equal to the
main frequency whenever the latter is updated via sysfs; if
userspace wants a different buffer frequency, it has to write to
the relevant sysfs attribute after any writes to the main frequency
attribute.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 +
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 71 ++++++++++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  3 +-
 4 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index bd366c6e282a..3cd520bdec46 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -366,6 +366,7 @@ enum st_lsm6dsx_fifo_mode {
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  * @gain: Configured sensor sensitivity.
  * @odr: Output data rate of the sensor [mHz].
+ * hwfifo_odr_mHz: Batch data rate for hardware FIFO [mHz]
  * @samples_to_discard: Number of samples to discard for filters settling time.
  * @watermark: Sensor watermark level.
  * @decimator: Sensor decimation factor.
@@ -380,6 +381,7 @@ struct st_lsm6dsx_sensor {
 
 	u32 gain;
 	u32 odr;
+	u32 hwfifo_odr_mHz;
 
 	u16 samples_to_discard;
 	u16 watermark;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 8a9d2593576a..7a66f06522c4 100644
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
+	u32 decimator = max_odr / sensor->hwfifo_odr_mHz;
 	int i;
 
 	if (decimator > 1)
@@ -136,14 +137,14 @@ static void st_lsm6dsx_get_max_min_odr(struct st_lsm6dsx_hw *hw,
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
 
-		*max_odr = max_t(u32, *max_odr, sensor->odr);
-		*min_odr = min_t(u32, *min_odr, sensor->odr);
+		*max_odr = max(*max_odr, sensor->hwfifo_odr_mHz);
+		*min_odr = min(*min_odr, sensor->hwfifo_odr_mHz);
 	}
 }
 
 static u8 st_lsm6dsx_get_sip(struct st_lsm6dsx_sensor *sensor, u32 min_odr)
 {
-	u8 sip = sensor->odr / min_odr;
+	u8 sip = sensor->hwfifo_odr_mHz / min_odr;
 
 	return sip > 1 ? round_down(sip, 2) : sip;
 }
@@ -231,7 +232,7 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 		if (enable) {
 			int err;
 
-			err = st_lsm6dsx_check_odr(sensor, sensor->odr,
+			err = st_lsm6dsx_check_odr(sensor, sensor->hwfifo_odr_mHz,
 						   &data);
 			if (err < 0)
 				return err;
@@ -713,7 +714,7 @@ st_lsm6dsx_update_samples_to_discard(struct st_lsm6dsx_sensor *sensor)
 
 	data = &hw->settings->samples_to_discard[sensor->id];
 	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++) {
-		if (data->val[i].milli_hz == sensor->odr) {
+		if (data->val[i].milli_hz == sensor->hwfifo_odr_mHz) {
 			sensor->samples_to_discard = data->val[i].samples;
 			return;
 		}
@@ -799,6 +800,59 @@ static const struct iio_buffer_setup_ops st_lsm6dsx_buffer_ops = {
 	.postdisable = st_lsm6dsx_buffer_postdisable,
 };
 
+static ssize_t st_lsm6dsx_hwfifo_odr_show(struct device *dev,
+					  struct device_attribute *attr, char *buf)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_to_iio_dev(dev));
+	u32 hwfifo_odr = sensor->hwfifo_odr_mHz;
+
+	return sysfs_emit(buf, "%d.%03d\n", hwfifo_odr / 1000, hwfifo_odr % 1000);
+}
+
+static ssize_t st_lsm6dsx_hwfifo_odr_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t len)
+{
+	struct iio_dev *iio_dev = dev_to_iio_dev(dev);
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+	int integer, milli;
+	int ret;
+	u32 hwfifo_odr;
+	u8 data;
+
+	if (!iio_device_claim_direct(iio_dev))
+		return -EBUSY;
+
+	ret = iio_str_to_fixpoint(buf, 100, &integer, &milli);
+	if (ret)
+		goto out;
+
+	hwfifo_odr = integer * 1000 + milli;
+	ret = st_lsm6dsx_check_odr(sensor, hwfifo_odr, &data);
+	if (ret < 0)
+		goto out;
+
+	hwfifo_odr = ret;
+
+	/* the batch data rate must not exceed the sensor output data rate */
+	if (hwfifo_odr <= sensor->odr)
+		sensor->hwfifo_odr_mHz = hwfifo_odr;
+	else
+		ret = -EINVAL;
+
+out:
+	iio_device_release_direct(iio_dev);
+
+	return ret < 0 ? ret : len;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(0664, st_lsm6dsx_hwfifo_odr_show, st_lsm6dsx_hwfifo_odr_store);
+
+static const struct iio_dev_attr *st_lsm6dsx_buffer_attrs[] = {
+	&iio_dev_attr_sampling_frequency,
+	NULL
+};
+
 int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 {
 	int i, ret;
@@ -807,8 +861,9 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
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
index c65ad49829e7..055424303a4f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1850,7 +1850,7 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 		if (val < 0)
 			err = val;
 		else
-			sensor->odr = val;
+			sensor->odr = sensor->hwfifo_odr_mHz = val;
 		break;
 	}
 	default:
@@ -2384,6 +2384,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	sensor->id = id;
 	sensor->hw = hw;
 	sensor->odr = hw->settings->odr_table[id].odr_avl[0].milli_hz;
+	sensor->hwfifo_odr_mHz = sensor->odr;
 	sensor->gain = hw->settings->fs_table[id].fs_avl[0].gain;
 	sensor->watermark = 1;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 3c5e65dc0f97..039f588ef806 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -639,7 +639,7 @@ __st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
 			return odr;
 
 		sensor->ext_info.slv_odr = val;
-		sensor->odr = odr;
+		sensor->odr = sensor->hwfifo_odr_mHz = odr;
 		return 0;
 	}
 	case IIO_CHAN_INFO_SCALE:
@@ -746,6 +746,7 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	sensor->id = id;
 	sensor->hw = hw;
 	sensor->odr = hw->settings->odr_table[ref_id].odr_avl[0].milli_hz;
+	sensor->hwfifo_odr_mHz = sensor->odr;
 	sensor->ext_info.slv_odr = info->odr_table.odr_avl[0].milli_hz;
 	sensor->gain = info->fs_table.fs_avl[0].gain;
 	sensor->ext_info.settings = info;
-- 
2.39.5


