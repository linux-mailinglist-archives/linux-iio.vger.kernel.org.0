Return-Path: <linux-iio+bounces-25210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DE0BEAD3D
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 18:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E02419C80A7
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4CF2E427B;
	Fri, 17 Oct 2025 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SMikJuUq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F52DF6F5
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719386; cv=none; b=IScRSytqK24BzeVlDYpZf8idWvnR1Az1v1cJr6VpX3RyQsW2tK4PyKFHiy4FOcH67abnrgsIfA0OaN9ovzgtfO+nOzS8SWQc1AxQVbGkrmO8DJgdHP+HQn+U5bbnPfHbzPiY2NyO4VdtfxKCcfWzyYHHBJKE8YjRdRY3/ZI5DBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719386; c=relaxed/simple;
	bh=C+z7sypaWzV70HTwj6KI3rPfmg2IyKDpJvcZ0i7QuuU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jwvptq3CHw6PfYKawGMAlUXSzaGJBPQTARlb4DaA9mihL/BnG/M84dVTVpG7uHqTVhn0i2cqxc4Hn56h91FWGVvzlsupsq20lHi7pvxFsSs4eHzff0uU1mpI69MaB/CdeivTp1y8sS554V5w8f+bx52aV00x5neJ32ITtsb/Eek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SMikJuUq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso391992466b.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760719382; x=1761324182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQX98Tf2y0MkdvdIOBqjljpmh/9Imc0tmR+fXFJYM8E=;
        b=SMikJuUqUItID1Sasvbl8VDEC8epNziP5TS6X+LP8g3banXTQ5UpC0l2rheNJvbkQn
         t8hSNgJ6lCPlddJBPOsXxSpGC+blYKWld9KevVlUYMdiSgwfyv+W39z/rDVRk61NcyEg
         aq1QCjhBJJC3pneN8d6N6KnhWXBJe5yop2cwonOnGgg0Nk7IFHxUMn5b6PrsKlolTKl0
         kqJHwF+sNj9F5aOxukavEWYlfoVaTKnRKeEW9OCuSiKDZV6PUc6mdzIJqCpbdXZKeUpk
         ET99TdrLGrWgKO80CyTCBoGnKLmAto9/Z/m4em+ZmkBEsTuiknNcEGN9g7++WUOuiUiy
         Ms5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719382; x=1761324182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQX98Tf2y0MkdvdIOBqjljpmh/9Imc0tmR+fXFJYM8E=;
        b=SwXMimjOxSCRWrMqz6Yh+tTh22nzb0s2Cwdi/1yT8HdicVj0oAMnKRKIekyYi3O0Qk
         oK/mPwK3XTKOM8pscg7KnX5T5p+BaNLbopAy8ewgCXMXU1RUsylnaLVUshlbDVgqp12D
         wqCA7V9jkZe+8lBNi3Mux4oD6eW4JRDiCnoJ3dXs+S5bg6OwzMeiBqEztgDplyVPpeqS
         TDPsv1UvrESp1jjYdbH1X534EH/zzTFtjNGhVkKfhiQVSddDQsmnBl4EE6beHkVSJ/Io
         MsYHYp0vqg7GgMSVXlg/xW9tbAVn+v5Ya7zyxNlejb/GxZL2GMersO32/KzQNRF7oNAz
         Tyig==
X-Forwarded-Encrypted: i=1; AJvYcCX5a4IbeVuMuySdYTDokKC9Eb7hneo6deRfXv5gMcc7430Hegs788IgbyIctyjp/r2S/oInEHN/bkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTUnpysfda1XgFnD0wmhfrjMyF42woHuGEYu/J3j2yb2/b6A++
	NtCG/7MWVW/aT855mUFlNHqmupcFGFOKD+Hiif5GwXaLmClqI73dlBlH7IIx69tTyKk=
X-Gm-Gg: ASbGncteLxOIaQWpCzYvFSTpO2pguMYU2waTRQcGdDOZu2HAaisZ2Cw+2z16x1qwYkO
	cQhgUYeNIAeAzvz6fUDWVkITvu4p7BpPmL2kgHJOQF7GOP3NMEps1ssWFCLnU8vvOWIGHMOPBN0
	x8HqITSOUgjPchGjDOMTCF9lwN8x4/SP3omi31hFZyxMIeY+hbTwwd0ajwd2dR+/6Qb9EiVJH9x
	4PEWT9ehTLpc4swbQZr9GU/vtoqdnzzkEmSi/zGhL72c7Ia82dFHXb/mb4pNy/kLo1RPMfM8Bjr
	+LEQm9aakY8VeCpxzWHv1q0fg5wT62mVLd+mUjHkfdfNiQ1a36ItfbxN43XxoRFb/MXFwhZk9hF
	pDBpWIhSml7SnTL5OWQatBcYixSuLVRnStPP6Jlc1cBZ4YrAD7cryy4YLlcG/BBcpymNiZYVaW2
	A/3WbfTplVmvpfyByXeywBGJflDLAZcSgdiXyF
X-Google-Smtp-Source: AGHT+IHcSVLRPmaNpo/l1hcAlmozuaLO9Zw2xYWDm+QeXDkQRKPSWUG23uhTVPllrDvezkmyiTTUAg==
X-Received: by 2002:a17:907:2686:b0:b42:1324:7986 with SMTP id a640c23a62f3a-b647254f3afmr440216166b.6.1760719381757;
        Fri, 17 Oct 2025 09:43:01 -0700 (PDT)
Received: from localhost (mob-176-247-36-41.net.vodafone.it. [176.247.36.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebc4d552sm13771266b.80.2025.10.17.09.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:43:00 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate
Date: Fri, 17 Oct 2025 18:42:55 +0200
Message-Id: <20251017164255.1251060-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251017164255.1251060-1-flavra@baylibre.com>
References: <20251017164255.1251060-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8633; i=flavra@baylibre.com; h=from:subject; bh=C+z7sypaWzV70HTwj6KI3rPfmg2IyKDpJvcZ0i7QuuU=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo8nH/QAuLBrSbvOQSUJF7FwtMAsMXUmk/rp4ED dXaLhqPd9uJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaPJx/wAKCRDt8TtzzpQ2 X0dmDACNrQbNuPJ2vhlv/H3Ai6EBxNnucTmSJSU4f+Ax0CLgl61xZHuUIFh1sWq/g+SWCkeRYq+ R5pFfCh9wVLq7Lu/gBMz1vDELQMMG1ZSmZpffuDskOYHXNQYYCfjbXYAp0ekUqIZVQnRZ/xqmVw jo3T4NJc/BNQ4Eyc/AFxIUrqn8ApDRHoZMgBEJjO8DPOeDF4xAqECGQWdPyB6+j7Cq/2KHT29r+ cdiTsmGli2LbwOI7X6mQw682whQa6J8gEqhhFcOa7jSGmEYEbYBFXSqrOgA9Uar/3K8uYX7fx3+ cS8Xio225shc7y+ocvmO2/yAW+1HDAr8kp5LgUXhm7/1voGymMzpfXuUj/ZMi6N/FUNGTAWV6v/ WhFTSQkXaLnyTu9S8Smt38plUiO/9nD9EE4EQViWZKinnpzKo7lH7aC8vldboe+lq0fL2CrztDG CrV4KWYKJCqXVY+bpgiukFrKEWi+7hiAK9JtQqjGJ5J3eIXa3WM1+/zK3E6IhK2/dR9wg=
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
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 +
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 71 ++++++++++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  2 +
 4 files changed, 72 insertions(+), 10 deletions(-)

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
index 8a9d2593576a..55d877745575 100644
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
+
+	return sysfs_emit(buf, "%d.%03d\n", sensor->hwfifo_odr_mHz / 1000,
+			  sensor->hwfifo_odr_mHz % 1000);
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
index c65ad49829e7..216160549b5a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1847,10 +1847,12 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 
 		val = val * 1000 + val2 / 1000;
 		val = st_lsm6dsx_check_odr(sensor, val, &data);
-		if (val < 0)
+		if (val < 0) {
 			err = val;
-		else
+		} else {
 			sensor->odr = val;
+			sensor->hwfifo_odr_mHz = val;
+		}
 		break;
 	}
 	default:
@@ -2384,6 +2386,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	sensor->id = id;
 	sensor->hw = hw;
 	sensor->odr = hw->settings->odr_table[id].odr_avl[0].milli_hz;
+	sensor->hwfifo_odr_mHz = sensor->odr;
 	sensor->gain = hw->settings->fs_table[id].fs_avl[0].gain;
 	sensor->watermark = 1;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 3c5e65dc0f97..d6a1eeb151ca 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -640,6 +640,7 @@ __st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
 
 		sensor->ext_info.slv_odr = val;
 		sensor->odr = odr;
+		sensor->hwfifo_odr_mHz = odr;
 		return 0;
 	}
 	case IIO_CHAN_INFO_SCALE:
@@ -746,6 +747,7 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	sensor->id = id;
 	sensor->hw = hw;
 	sensor->odr = hw->settings->odr_table[ref_id].odr_avl[0].milli_hz;
+	sensor->hwfifo_odr_mHz = sensor->odr;
 	sensor->ext_info.slv_odr = info->odr_table.odr_avl[0].milli_hz;
 	sensor->gain = info->fs_table.fs_avl[0].gain;
 	sensor->ext_info.settings = info;
-- 
2.39.5


