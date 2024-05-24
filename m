Return-Path: <linux-iio+bounces-5260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925A68CE2DB
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 11:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B552B1C20E02
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 09:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9637129A6F;
	Fri, 24 May 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEQtD1Ft"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939F86258;
	Fri, 24 May 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541419; cv=none; b=p50QhCaEyV9zpUz8P1T5W05RBQKo/NdgMed0tVA418TqJXCHZignQ3SmbPt4WO8EstV/7c7iLWauFqvSAzPUSymgp+oUUnA8OD4xxw2jMkQF1FAQsHyPYfxU8AEcTIaH408kUH1fcRYS3KMNxzmIWW4JhpKb4ertT5Sc16EdZgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541419; c=relaxed/simple;
	bh=H4fr8FZkPT1Qt51E/Cae4FaRADKjSmXO3M6WqS0BuCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KpQh/7/3OrjCFQwblwTa7Uq8B0RmpyFtqwvpxqwFbmrEvMNDA7swSjMC4/amJQkNT3DQR+Wa28wxTZZUvWJNRo2Q+SPliWU0N/qK/Dv7TikWa1CCl8iFtiBcNAkOBNZV7NrwHjxHSE9lqINTgMg4xuOL1E8VUjswJin/YnT1wM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEQtD1Ft; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5a7d28555bso1279837166b.1;
        Fri, 24 May 2024 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716541415; x=1717146215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1nexVopxlraJXNGXP7AVvmaKXoYwkbRCjy1Bq0G0Qek=;
        b=MEQtD1Ft0NwY3JGXTmQwro+A/TiRsfVcWI/YKE4PpqYeR/wnWouL7z9wDJUfv/wwma
         pN3dCTA7kON+c4wf2lBKA7MoLBqpHQ6B/VOwLG+g6I98KO/YirSa3JFs6sMlOsZfLVI5
         M9lehxmiVF0RbE8BlsyZhex1BcvDfe9CyRwLn/O9k7CPGSn+T0bvdhOLZGnqnuuvImXu
         G1Yh1WlqdC+ypUreSh7yxoH2OmPVuMdPmz0SSl0VYpfxA1mHqHo3xo0eidi+EtBwED0D
         FR3BRoTzFWI1FQ0Xk9OImFm/Ra6eIlj8HgYdNdfBU8/h0dFjUp8OCHvNlVI85E9Yx+CL
         eftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541415; x=1717146215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nexVopxlraJXNGXP7AVvmaKXoYwkbRCjy1Bq0G0Qek=;
        b=ojqex3x+DpoED9yZUztDjxz8Y37JlsNnn2+tITJlg19RCeqO+HJzoxUvQFU5ODV29Z
         3ewSvDB1mjSI+2WS7HWN9PXFQRA4Lgrw304FL2dM3X9wgd2RLd+EfvNJTTSQe2ORX34s
         zFIHnjwo4/cEMKmwAdFvWgu3fM22eAHu6Epqm70JhIXHiPnVrQw0jYejGTJDo73hpF5e
         5uxl6GKk9gvy/CWr+yMmUJlMbtpSfjivfuD9ufj0il/fFEUy9Y4sKluZgA5xbSxsxw2W
         JUO7vzK9lybaKU+/5IRVo7ye1ELZE1jrbybHK9UtcydPjj0P91W1Yc/IfW36ZcWD8ay1
         vQMg==
X-Forwarded-Encrypted: i=1; AJvYcCUFlpGnisVUTjzCapjtx623z6s4FOk4MQks+PwbSHjFP3dLTZCiHjovXaaBQLpsrlE8/4zNgExRY0rHJPBxcgujdC/yjis/i7tMWyk7HrNHzDBJO1/K8EkrSHGDqfzfLPhit4DJYw==
X-Gm-Message-State: AOJu0YzBaefisir9MUd37MC4+7FlfURZI0s+0l160DTZasJvGjHT4fga
	822i0vWkclEl02gAoUTCzZHuKRNbupOxDThwlGF6DvtJ1dUCKdv7zPgl0fHtb0M=
X-Google-Smtp-Source: AGHT+IGKdxfIH7Cw3HRFULNjBF+tj75rdu43BoBvXqGMlyiB7azAGPTqm1nxS/6g6EgJ6GXBRTN77A==
X-Received: by 2002:a17:907:6d07:b0:a58:c80e:edd9 with SMTP id a640c23a62f3a-a626525da3bmr103350966b.77.1716541414738;
        Fri, 24 May 2024 02:03:34 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:dac3:9bb:ed7a:184b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8c860sm96641866b.168.2024.05.24.02.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:03:33 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH v4 10/10] drivers: iio: imu: Add support for adis1657x family
Date: Fri, 24 May 2024 12:03:29 +0300
Message-Id: <20240524090329.340810-1-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ADIS1657X family devices in already exiting ADIS16475
driver.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
changes in v4:
 - removed AIDS16575_HAS_FIFO flag and instead used has_fifo flag from adis_data
 - removed timestamp channel for devices which support FIFO readings (adis1657x)
 - dropped the dev_attr.attr. from adis16475_fifo_attributes
 - reworked if (ret) as advised
 drivers/iio/imu/adis16475.c | 649 ++++++++++++++++++++++++++++++++----
 1 file changed, 579 insertions(+), 70 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 3bbf3e181e1a..f0eed75c4fb2 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -14,6 +14,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/imu/adis.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/irq.h>
 #include <linux/lcm.h>
@@ -52,6 +53,8 @@
 				FIELD_PREP(ADIS16475_MSG_CTRL_DR_POL_MASK, x)
 #define ADIS16475_SYNC_MODE_MASK	GENMASK(4, 2)
 #define ADIS16475_SYNC_MODE(x)		FIELD_PREP(ADIS16475_SYNC_MODE_MASK, x)
+#define ADIS16575_SYNC_4KHZ_MASK	BIT(11)
+#define ADIS16575_SYNC_4KHZ(x)		FIELD_PREP(ADIS16575_SYNC_4KHZ_MASK, x)
 #define ADIS16475_REG_UP_SCALE		0x62
 #define ADIS16475_REG_DEC_RATE		0x64
 #define ADIS16475_REG_GLOB_CMD		0x68
@@ -65,15 +68,32 @@
 #define ADIS16500_BURST32_MASK		BIT(9)
 #define ADIS16500_BURST32(x)		FIELD_PREP(ADIS16500_BURST32_MASK, x)
 /* number of data elements in burst mode */
-#define ADIS16475_BURST32_MAX_DATA	32
+#define ADIS16475_BURST32_MAX_DATA_NO_TS32	32
+#define ADIS16575_BURST32_DATA_TS32		34
 #define ADIS16475_BURST_MAX_DATA	20
 #define ADIS16475_MAX_SCAN_DATA		20
 /* spi max speed in brust mode */
 #define ADIS16475_BURST_MAX_SPEED	1000000
+#define ADIS16575_BURST_MAX_SPEED	8000000
 #define ADIS16475_LSB_DEC_MASK		0
 #define ADIS16475_LSB_FIR_MASK		1
 #define ADIS16500_BURST_DATA_SEL_0_CHN_MASK	GENMASK(5, 0)
 #define ADIS16500_BURST_DATA_SEL_1_CHN_MASK	GENMASK(12, 7)
+#define ADIS16575_MAX_FIFO_WM		511UL
+#define ADIS16475_REG_FIFO_CTRL		0x5A
+#define ADIS16575_WM_LVL_MASK		GENMASK(15, 4)
+#define ADIS16575_WM_LVL(x)		FIELD_PREP(ADIS16575_WM_LVL_MASK, x)
+#define ADIS16575_WM_POL_MASK		BIT(3)
+#define ADIS16575_WM_POL(x)		FIELD_PREP(ADIS16575_WM_POL_MASK, x)
+#define ADIS16575_WM_EN_MASK		BIT(2)
+#define ADIS16575_WM_EN(x)		FIELD_PREP(ADIS16575_WM_EN_MASK, x)
+#define ADIS16575_OVERFLOW_MASK		BIT(1)
+#define ADIS16575_STOP_ENQUEUE		FIELD_PREP(ADIS16575_OVERFLOW_MASK, 0)
+#define ADIS16575_OVERWRITE_OLDEST	FIELD_PREP(ADIS16575_OVERFLOW_MASK, 1)
+#define ADIS16575_FIFO_EN_MASK		BIT(0)
+#define ADIS16575_FIFO_EN(x)		FIELD_PREP(ADIS16575_FIFO_EN_MASK, x)
+#define ADIS16575_FIFO_FLUSH_CMD	BIT(5)
+#define ADIS16575_REG_FIFO_CNT		0x3C

 enum {
 	ADIS16475_SYNC_DIRECT = 1,
@@ -95,6 +115,8 @@ struct adis16475_chip_info {
 	const char *name;
 #define ADIS16475_HAS_BURST32		BIT(0)
 #define ADIS16475_HAS_BURST_DELTA_DATA	BIT(1)
+#define ADIS16475_HAS_TIMESTAMP32	BIT(2)
+#define ADIS16475_NEEDS_BURST_REQUEST	BIT(3)
 	const long flags;
 	u32 num_channels;
 	u32 gyro_max_val;
@@ -116,6 +138,7 @@ struct adis16475 {
 	bool burst32;
 	unsigned long lsb_flag;
 	u16 sync_mode;
+	u16 fifo_watermark;
 	/* Alignment needed for the timestamp */
 	__be16 data[ADIS16475_MAX_SCAN_DATA] __aligned(8);
 };
@@ -442,6 +465,124 @@ static int adis16475_set_filter(struct adis16475 *st, const u32 filter)
 	return 0;
 }

+static ssize_t adis16475_get_fifo_enabled(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adis16475 *st = iio_priv(indio_dev);
+	int ret;
+	u16 val;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FIFO_CTRL, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%lu\n", FIELD_GET(ADIS16575_FIFO_EN_MASK, val));
+}
+
+static ssize_t adis16475_get_fifo_watermark(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adis16475 *st = iio_priv(indio_dev);
+	int ret;
+	u16 val;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FIFO_CTRL, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%lu\n", FIELD_GET(ADIS16575_WM_LVL_MASK, val) + 1);
+}
+
+static ssize_t hwfifo_watermark_min_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "1\n");
+}
+
+static ssize_t hwfifo_watermark_max_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", ADIS16575_MAX_FIFO_WM);
+}
+
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
+static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
+		       adis16475_get_fifo_watermark, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
+		       adis16475_get_fifo_enabled, NULL, 0);
+
+static const struct iio_dev_attr *adis16475_fifo_attributes[] = {
+	&iio_dev_attr_hwfifo_watermark_min,
+	&iio_dev_attr_hwfifo_watermark_max,
+	&iio_dev_attr_hwfifo_watermark,
+	&iio_dev_attr_hwfifo_enabled,
+	NULL
+};
+
+static int adis16475_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct adis16475 *st = iio_priv(indio_dev);
+	struct adis *adis = &st->adis;
+
+	return adis_update_bits(adis, ADIS16475_REG_FIFO_CTRL,
+				ADIS16575_FIFO_EN_MASK, (u16)ADIS16575_FIFO_EN(1));
+}
+
+static int adis16475_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct adis16475 *st = iio_priv(indio_dev);
+	struct adis *adis = &st->adis;
+	int ret;
+
+	adis_dev_lock(&st->adis);
+
+	ret = __adis_update_bits(adis, ADIS16475_REG_FIFO_CTRL,
+				 ADIS16575_FIFO_EN_MASK, (u16)ADIS16575_FIFO_EN(0));
+	if (ret)
+		goto unlock;
+
+	ret = __adis_write_reg_16(adis, ADIS16475_REG_GLOB_CMD,
+				  ADIS16575_FIFO_FLUSH_CMD);
+
+unlock:
+	adis_dev_unlock(&st->adis);
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops adis16475_buffer_ops = {
+	.postenable = adis16475_buffer_postenable,
+	.postdisable = adis16475_buffer_postdisable,
+};
+
+static int adis16475_set_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct adis16475 *st  = iio_priv(indio_dev);
+	int ret;
+	u16 wm_lvl;
+
+	adis_dev_lock(&st->adis);
+
+	val = min_t(unsigned int, val, ADIS16575_MAX_FIFO_WM);
+
+	wm_lvl = ADIS16575_WM_LVL(val - 1);
+	ret = __adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL, ADIS16575_WM_LVL_MASK, wm_lvl);
+	if (ret)
+		goto unlock;
+
+	st->fifo_watermark = val;
+
+unlock:
+	adis_dev_unlock(&st->adis);
+	return ret;
+}
+
 static const u32 adis16475_calib_regs[] = {
 	[ADIS16475_SCAN_GYRO_X] = ADIS16475_REG_X_GYRO_BIAS_L,
 	[ADIS16475_SCAN_GYRO_Y] = ADIS16475_REG_Y_GYRO_BIAS_L,
@@ -651,6 +792,22 @@ static const struct iio_chan_spec adis16475_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };

+static const struct iio_chan_spec adis16575_channels[] = {
+	ADIS16475_GYRO_CHANNEL(X),
+	ADIS16475_GYRO_CHANNEL(Y),
+	ADIS16475_GYRO_CHANNEL(Z),
+	ADIS16475_ACCEL_CHANNEL(X),
+	ADIS16475_ACCEL_CHANNEL(Y),
+	ADIS16475_ACCEL_CHANNEL(Z),
+	ADIS16475_TEMP_CHANNEL(),
+	ADIS16475_DELTANG_CHAN(X),
+	ADIS16475_DELTANG_CHAN(Y),
+	ADIS16475_DELTANG_CHAN(Z),
+	ADIS16475_DELTVEL_CHAN(X),
+	ADIS16475_DELTVEL_CHAN(Y),
+	ADIS16475_DELTVEL_CHAN(Z),
+};
+
 enum adis16475_variant {
 	ADIS16470,
 	ADIS16475_1,
@@ -673,6 +830,12 @@ enum adis16475_variant {
 	ADIS16507_1,
 	ADIS16507_2,
 	ADIS16507_3,
+	ADIS16575_2,
+	ADIS16575_3,
+	ADIS16576_2,
+	ADIS16576_3,
+	ADIS16577_2,
+	ADIS16577_3,
 };

 enum {
@@ -731,6 +894,12 @@ static const struct adis16475_sync adis16475_sync_mode[] = {
 	{ ADIS16475_SYNC_PULSE, 1000, 2100 },
 };

+static const struct adis16475_sync adis16575_sync_mode[] = {
+	{ ADIS16475_SYNC_OUTPUT },
+	{ ADIS16475_SYNC_DIRECT, 1900, 4100 },
+	{ ADIS16475_SYNC_SCALED, 1, 400 },
+};
+
 static const struct adis_timeout adis16475_timeouts = {
 	.reset_ms = 200,
 	.sw_reset_ms = 200,
@@ -760,7 +929,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16470, &adis16475_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16475_1] = {
@@ -779,7 +948,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16475_2] = {
@@ -798,7 +967,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16475_3] = {
@@ -817,7 +986,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16477_1] = {
@@ -837,7 +1006,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16477_2] = {
@@ -857,7 +1026,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16477_3] = {
@@ -877,7 +1046,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16465_1] = {
@@ -896,7 +1065,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16465_2] = {
@@ -915,7 +1084,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16465_3] = {
@@ -934,7 +1103,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16467_1] = {
@@ -953,7 +1122,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16467_2] = {
@@ -972,7 +1141,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16467_3] = {
@@ -991,7 +1160,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16500] = {
@@ -1012,7 +1181,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16500, &adis1650x_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16501] = {
@@ -1033,7 +1202,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16501, &adis1650x_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16505_1] = {
@@ -1054,7 +1223,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16505_2] = {
@@ -1075,7 +1244,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16505_3] = {
@@ -1096,7 +1265,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16507_1] = {
@@ -1117,7 +1286,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16507_2] = {
@@ -1138,7 +1307,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16507_3] = {
@@ -1159,9 +1328,147 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts,
-					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
 					    ADIS16475_BURST_MAX_SPEED, false),
 	},
+	[ADIS16575_2] = {
+		.name = "adis16575-2",
+		.num_channels = ARRAY_SIZE(adis16575_channels),
+		.channels = adis16575_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 8,
+		.accel_max_scale = IIO_M_S_2_TO_G(32000 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(450),
+		.deltvel_max_val = 100,
+		.int_clk = 4000,
+		.max_dec = 3999,
+		.sync = adis16575_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16575_sync_mode),
+		.flags = ADIS16475_HAS_BURST32 |
+			 ADIS16475_HAS_BURST_DELTA_DATA |
+			 ADIS16475_NEEDS_BURST_REQUEST |
+			 ADIS16475_HAS_TIMESTAMP32,
+		.adis_data = ADIS16475_DATA(16575, &adis16475_timeouts,
+					    ADIS16575_BURST32_DATA_TS32,
+					    ADIS16575_BURST_MAX_SPEED, true),
+	},
+	[ADIS16575_3] = {
+		.name = "adis16575-3",
+		.num_channels = ARRAY_SIZE(adis16575_channels),
+		.channels = adis16575_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
+		.accel_max_val = 8,
+		.accel_max_scale = IIO_M_S_2_TO_G(32000 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(2000),
+		.deltvel_max_val = 100,
+		.int_clk = 4000,
+		.max_dec = 3999,
+		.sync = adis16575_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16575_sync_mode),
+		.flags = ADIS16475_HAS_BURST32 |
+			 ADIS16475_HAS_BURST_DELTA_DATA |
+			 ADIS16475_NEEDS_BURST_REQUEST |
+			 ADIS16475_HAS_TIMESTAMP32,
+		.adis_data = ADIS16475_DATA(16575, &adis16475_timeouts,
+					    ADIS16575_BURST32_DATA_TS32,
+					    ADIS16575_BURST_MAX_SPEED, true),
+	},
+	[ADIS16576_2] = {
+		.name = "adis16576-2",
+		.num_channels = ARRAY_SIZE(adis16575_channels),
+		.channels = adis16575_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 40,
+		.accel_max_scale = IIO_M_S_2_TO_G(32000 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(450),
+		.deltvel_max_val = 125,
+		.int_clk = 4000,
+		.max_dec = 3999,
+		.sync = adis16575_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16575_sync_mode),
+		.flags = ADIS16475_HAS_BURST32 |
+			 ADIS16475_HAS_BURST_DELTA_DATA |
+			 ADIS16475_NEEDS_BURST_REQUEST |
+			 ADIS16475_HAS_TIMESTAMP32,
+		.adis_data = ADIS16475_DATA(16576, &adis16475_timeouts,
+					    ADIS16575_BURST32_DATA_TS32,
+					    ADIS16575_BURST_MAX_SPEED, true),
+	},
+	[ADIS16576_3] = {
+		.name = "adis16576-3",
+		.num_channels = ARRAY_SIZE(adis16575_channels),
+		.channels = adis16575_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
+		.accel_max_val = 40,
+		.accel_max_scale = IIO_M_S_2_TO_G(32000 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(2000),
+		.deltvel_max_val = 125,
+		.int_clk = 4000,
+		.max_dec = 3999,
+		.sync = adis16575_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16575_sync_mode),
+		.flags = ADIS16475_HAS_BURST32 |
+			 ADIS16475_HAS_BURST_DELTA_DATA |
+			 ADIS16475_NEEDS_BURST_REQUEST |
+			 ADIS16475_HAS_TIMESTAMP32,
+		.adis_data = ADIS16475_DATA(16576, &adis16475_timeouts,
+					    ADIS16575_BURST32_DATA_TS32,
+					    ADIS16575_BURST_MAX_SPEED, true),
+	},
+	[ADIS16577_2] = {
+		.name = "adis16577-2",
+		.num_channels = ARRAY_SIZE(adis16575_channels),
+		.channels = adis16575_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 40,
+		.accel_max_scale = IIO_M_S_2_TO_G(32000 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(450),
+		.deltvel_max_val = 400,
+		.int_clk = 4000,
+		.max_dec = 3999,
+		.sync = adis16575_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16575_sync_mode),
+		.flags = ADIS16475_HAS_BURST32 |
+			 ADIS16475_HAS_BURST_DELTA_DATA |
+			 ADIS16475_NEEDS_BURST_REQUEST |
+			 ADIS16475_HAS_TIMESTAMP32,
+		.adis_data = ADIS16475_DATA(16577, &adis16475_timeouts,
+					    ADIS16575_BURST32_DATA_TS32,
+					    ADIS16575_BURST_MAX_SPEED, true),
+	},
+	[ADIS16577_3] = {
+		.name = "adis16577-3",
+		.num_channels = ARRAY_SIZE(adis16575_channels),
+		.channels = adis16575_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
+		.accel_max_val = 40,
+		.accel_max_scale = IIO_M_S_2_TO_G(32000 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(2000),
+		.deltvel_max_val = 400,
+		.int_clk = 4000,
+		.max_dec = 3999,
+		.sync = adis16575_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16575_sync_mode),
+		.flags = ADIS16475_HAS_BURST32 |
+			 ADIS16475_HAS_BURST_DELTA_DATA |
+			 ADIS16475_NEEDS_BURST_REQUEST |
+			 ADIS16475_HAS_TIMESTAMP32,
+		.adis_data = ADIS16475_DATA(16577, &adis16475_timeouts,
+					    ADIS16575_BURST32_DATA_TS32,
+					    ADIS16575_BURST_MAX_SPEED, true),
+	},
 };

 static int adis16475_update_scan_mode(struct iio_dev *indio_dev,
@@ -1196,15 +1503,19 @@ static const struct iio_info adis16475_info = {
 	.debugfs_reg_access = adis_debugfs_reg_access,
 };

+static const struct iio_info adis16575_info = {
+	.read_raw = &adis16475_read_raw,
+	.write_raw = &adis16475_write_raw,
+	.update_scan_mode = adis16475_update_scan_mode,
+	.debugfs_reg_access = adis_debugfs_reg_access,
+	.hwfifo_set_watermark = adis16475_set_watermark,
+};
+
 static bool adis16475_validate_crc(const u8 *buffer, u16 crc,
-				   const bool burst32)
+				   u16 burst_size, u16 start_idx)
 {
 	int i;
-	/* extra 6 elements for low gyro and accel */
-	const u16 sz = burst32 ? ADIS16475_BURST32_MAX_DATA :
-		ADIS16475_BURST_MAX_DATA;
-
-	for (i = 0; i < sz - 2; i++)
+	for (i = start_idx; i < burst_size - 2; i++)
 		crc -= buffer[i];

 	return crc == 0;
@@ -1214,10 +1525,14 @@ static void adis16475_burst32_check(struct adis16475 *st)
 {
 	int ret;
 	struct adis *adis = &st->adis;
+	u8 timestamp32 = 0;

 	if (!(st->info->flags & ADIS16475_HAS_BURST32))
 		return;

+	if (st->info->flags & ADIS16475_HAS_TIMESTAMP32)
+		timestamp32 = 1;
+
 	if (st->lsb_flag && !st->burst32) {
 		const u16 en = ADIS16500_BURST32(1);

@@ -1231,9 +1546,12 @@ static void adis16475_burst32_check(struct adis16475 *st)
 		/*
 		 * In 32-bit mode we need extra 2 bytes for all gyro
 		 * and accel channels.
+		 * If the device has 32-bit timestamp value we need 2 extra
+		 * bytes for it.
 		 */
-		adis->burst_extra_len = 6 * sizeof(u16);
-		adis->xfer[1].len += 6 * sizeof(u16);
+		adis->burst_extra_len = (6 + timestamp32) * sizeof(u16);
+		adis->xfer[1].len += (6 + timestamp32) * sizeof(u16);
+
 		dev_dbg(&adis->spi->dev, "Enable burst32 mode, xfer:%d",
 			adis->xfer[1].len);

@@ -1249,7 +1567,7 @@ static void adis16475_burst32_check(struct adis16475 *st)

 		/* Remove the extra bits */
 		adis->burst_extra_len = 0;
-		adis->xfer[1].len -= 6 * sizeof(u16);
+		adis->xfer[1].len -= (6 + timestamp32) * sizeof(u16);
 		dev_dbg(&adis->spi->dev, "Disable burst32 mode, xfer:%d\n",
 			adis->xfer[1].len);
 	}
@@ -1264,20 +1582,30 @@ static int adis16475_push_single_sample(struct iio_poll_func *pf)
 	__be16 *buffer;
 	u16 crc;
 	bool valid;
+	u8 crc_offset = 9;
+	u16 burst_size = ADIS16475_BURST_MAX_DATA;
+	u16 start_idx = (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ? 2 : 0;
+
 	/* offset until the first element after gyro and accel */
 	const u8 offset = st->burst32 ? 13 : 7;

+	if (st->burst32) {
+		crc_offset = (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ? 16 : 15;
+		burst_size = (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ?
+			     ADIS16575_BURST32_DATA_TS32 : ADIS16475_BURST32_MAX_DATA_NO_TS32;
+	}
+
 	ret = spi_sync(adis->spi, &adis->msg);
 	if (ret)
-		goto check_burst32;
+		return ret;

 	buffer = adis->buffer;

-	crc = be16_to_cpu(buffer[offset + 2]);
-	valid = adis16475_validate_crc(adis->buffer, crc, st->burst32);
+	crc = be16_to_cpu(buffer[crc_offset]);
+	valid = adis16475_validate_crc(adis->buffer, crc, burst_size, start_idx);
 	if (!valid) {
 		dev_err(&adis->spi->dev, "Invalid crc\n");
-		goto check_burst32;
+		return ret;
 	}

 	for_each_set_bit(bit, indio_dev->active_scan_mask,
@@ -1337,23 +1665,127 @@ static int adis16475_push_single_sample(struct iio_poll_func *pf)
 		}
 	}

-	iio_push_to_buffers_with_timestamp(indio_dev, st->data, pf->timestamp);
-check_burst32:
+	if (adis->data->has_fifo)
+		iio_push_to_buffers(indio_dev, st->data);
+	else
+		iio_push_to_buffers_with_timestamp(indio_dev, st->data, pf->timestamp);
+
+	return 0;
+}
+
+static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adis16475 *st = iio_priv(indio_dev);
+
+	adis16475_push_single_sample(pf);
 	/*
 	 * We only check the burst mode at the end of the current capture since
 	 * it takes a full data ready cycle for the device to update the burst
 	 * array.
 	 */
 	adis16475_burst32_check(st);
-	return ret;
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
 }

-static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+/*
+ * This function updates the first tx byte from the adis message based on the
+ * given burst request.
+ */
+static void adis16575_update_msg_for_burst(struct adis *adis, u8 burst_req)
+{
+	unsigned int burst_max_length;
+	u8 *tx;
+
+	if (adis->data->burst_max_len)
+		burst_max_length = adis->data->burst_max_len;
+	else
+		burst_max_length = adis->data->burst_len + adis->burst_extra_len;
+
+	tx = adis->buffer + burst_max_length;
+	tx[0] = ADIS_READ_REG(burst_req);
+}
+
+static int adis16575_custom_burst_read(struct iio_poll_func *pf, u8 burst_req)
+{
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adis16475 *st = iio_priv(indio_dev);
+	struct adis *adis = &st->adis;
+
+	adis16575_update_msg_for_burst(adis, burst_req);
+
+	if (burst_req)
+		return spi_sync(adis->spi, &adis->msg);
+
+	return adis16475_push_single_sample(pf);
+}
+
+/*
+ * This handler is meant to be used for devices which support burst readings
+ * from FIFO (namely devices from adis1657x family).
+ * In order to pop the FIFO the 0x68 0x00 FIFO pop burst request has to be sent.
+ * If the previous device command was not a FIFO pop burst request, the FIFO pop
+ * burst request will simply pop the FIFO without returning valid data.
+ * For the nth consecutive burst request, thedevice will send the data popped
+ * with the (n-1)th consecutive burst request.
+ * In order to read the data which was popped previously, without popping the
+ * FIFO, the 0x00 0x00 burst request has to be sent.
+ * If after a 0x68 0x00 FIFO pop burst request, there is any other device access
+ * different from a 0x68 0x00 or a 0x00 0x00 burst request, the FIFO data popped
+ * previously will be lost.
+ */
+static irqreturn_t adis16475_trigger_handler_with_fifo(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adis16475 *st = iio_priv(indio_dev);
+	struct adis *adis = &st->adis;
+	int ret;
+	u16 fifo_cnt, i;

-	adis16475_push_single_sample(pf);
+	adis_dev_lock(&st->adis);
+
+	ret = __adis_read_reg_16(adis, ADIS16575_REG_FIFO_CNT, &fifo_cnt);
+	if (ret)
+		goto unlock;
+
+	/*
+	 * If no sample is available, nothing can be read. This can happen if
+	 * a the used trigger has a higher frequency than the selected sample rate.
+	 */
+	if (!fifo_cnt)
+		goto unlock;
+
+	/*
+	 * First burst request - FIFO pop: popped data will be returned in the
+	 * next burst request.
+	 */
+	ret = adis16575_custom_burst_read(pf, adis->data->burst_reg_cmd);
+	if (ret)
+		goto unlock;
+
+	for (i = 0; i < fifo_cnt - 1; i++) {
+		ret = adis16475_push_single_sample(pf);
+		if (ret)
+			goto unlock;
+	}
+
+	/* FIFO read without popping */
+	ret = adis16575_custom_burst_read(pf, 0);
+	if (ret)
+		goto unlock;
+
+unlock:
+	/*
+	 * We only check the burst mode at the end of the current capture since
+	 * reading data from registers will impact the FIFO reading.
+	 */
+	adis16475_burst32_check(st);
+	adis_dev_unlock(&st->adis);
 	iio_trigger_notify_done(indio_dev->trig);

 	return IRQ_HANDLED;
@@ -1367,6 +1799,14 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 	u32 sync_mode;
 	u16 max_sample_rate = st->info->int_clk + 100;

+	/* if available, enable 4khz internal clock */
+	if (st->info->int_clk == 4000) {
+		ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
+					 ADIS16575_SYNC_4KHZ_MASK, (u16)ADIS16575_SYNC_4KHZ(1));
+		if (ret)
+			return ret;
+	}
+
 	/* default to internal clk */
 	st->clk_freq = st->info->int_clk * 1000;

@@ -1444,34 +1884,67 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
 	u8 polarity;
 	struct spi_device *spi = st->adis.spi;

-	/*
-	 * It is possible to configure the data ready polarity. Furthermore, we
-	 * need to update the adis struct if we want data ready as active low.
-	 */
 	irq_type = irq_get_trigger_type(spi->irq);
-	if (irq_type == IRQ_TYPE_EDGE_RISING) {
-		polarity = 1;
-		st->adis.irq_flag = IRQF_TRIGGER_RISING;
-	} else if (irq_type == IRQ_TYPE_EDGE_FALLING) {
-		polarity = 0;
-		st->adis.irq_flag = IRQF_TRIGGER_FALLING;
+
+	if (st->adis.data->has_fifo) {
+		/*
+		 * It is possible to configure the fifo watermark pin polarity.
+		 * Furthermore, we need to update the adis struct if we want the
+		 * watermark pin active low.
+		 */
+		if (irq_type == IRQ_TYPE_LEVEL_HIGH) {
+			polarity = 1;
+			st->adis.irq_flag = IRQF_TRIGGER_HIGH;
+		} else if (irq_type == IRQ_TYPE_LEVEL_LOW) {
+			polarity = 0;
+			st->adis.irq_flag = IRQF_TRIGGER_LOW;
+		} else {
+			dev_err(&spi->dev, "Invalid interrupt type 0x%x specified\n",
+				irq_type);
+			return -EINVAL;
+		}
+
+		/* Configure the watermark pin polarity. */
+		ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
+				       ADIS16575_WM_POL_MASK, (u16)ADIS16575_WM_POL(polarity));
+		if (ret)
+			return ret;
+
+		/* Enable watermark interrupt pin. */
+		ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
+				       ADIS16575_WM_EN_MASK, (u16)ADIS16575_WM_EN(1));
+		if (ret)
+			return ret;
+
 	} else {
-		dev_err(&spi->dev, "Invalid interrupt type 0x%x specified\n",
-			irq_type);
-		return -EINVAL;
-	}
+		/*
+		 * It is possible to configure the data ready polarity. Furthermore, we
+		 * need to update the adis struct if we want data ready as active low.
+		 */
+		if (irq_type == IRQ_TYPE_EDGE_RISING) {
+			polarity = 1;
+			st->adis.irq_flag = IRQF_TRIGGER_RISING;
+		} else if (irq_type == IRQ_TYPE_EDGE_FALLING) {
+			polarity = 0;
+			st->adis.irq_flag = IRQF_TRIGGER_FALLING;
+		} else {
+			dev_err(&spi->dev, "Invalid interrupt type 0x%x specified\n",
+				irq_type);
+			return -EINVAL;
+		}

-	val = ADIS16475_MSG_CTRL_DR_POL(polarity);
-	ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
-				 ADIS16475_MSG_CTRL_DR_POL_MASK, val);
-	if (ret)
-		return ret;
-	/*
-	 * There is a delay writing to any bits written to the MSC_CTRL
-	 * register. It should not be bigger than 200us, so 250 should be more
-	 * than enough!
-	 */
-	usleep_range(250, 260);
+		val = ADIS16475_MSG_CTRL_DR_POL(polarity);
+		ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
+					 ADIS16475_MSG_CTRL_DR_POL_MASK, val);
+		if (ret)
+			return ret;
+		/*
+		 * There is a delay writing to any bits written to the MSC_CTRL
+		 * register. It should not be bigger than 200us, so 250 should be more
+		 * than enough!
+		 */
+		usleep_range(250, 260);
+	}

 	return 0;
 }
@@ -1500,7 +1973,10 @@ static int adis16475_probe(struct spi_device *spi)
 	indio_dev->name = st->info->name;
 	indio_dev->channels = st->info->channels;
 	indio_dev->num_channels = st->info->num_channels;
-	indio_dev->info = &adis16475_info;
+	if (st->adis.data->has_fifo)
+		indio_dev->info = &adis16575_info;
+	else
+		indio_dev->info = &adis16475_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;

 	ret = __adis_initial_startup(&st->adis);
@@ -1515,10 +1991,25 @@ static int adis16475_probe(struct spi_device *spi)
 	if (ret)
 		return ret;

-	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
-						 adis16475_trigger_handler);
-	if (ret)
-		return ret;
+	if (st->adis.data->has_fifo) {
+		ret = devm_adis_setup_buffer_and_trigger_with_attrs(&st->adis, indio_dev,
+								    adis16475_trigger_handler_with_fifo,
+								    &adis16475_buffer_ops,
+								    adis16475_fifo_attributes);
+		if (ret)
+			return ret;
+
+		/* Update overflow behavior to always overwrite the oldest sample. */
+		ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
+				       ADIS16575_OVERFLOW_MASK, (u16)ADIS16575_OVERWRITE_OLDEST);
+		if (ret)
+			return ret;
+	} else {
+		ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
+							 adis16475_trigger_handler);
+		if (ret)
+			return ret;
+	}

 	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
@@ -1572,6 +2063,18 @@ static const struct of_device_id adis16475_of_match[] = {
 		.data = &adis16475_chip_info[ADIS16507_2] },
 	{ .compatible = "adi,adis16507-3",
 		.data = &adis16475_chip_info[ADIS16507_3] },
+	{ .compatible = "adi,adis16575-2",
+		.data = &adis16475_chip_info[ADIS16575_2] },
+	{ .compatible = "adi,adis16575-3",
+		.data = &adis16475_chip_info[ADIS16575_3] },
+	{ .compatible = "adi,adis16576-2",
+		.data = &adis16475_chip_info[ADIS16576_2] },
+	{ .compatible = "adi,adis16576-3",
+		.data = &adis16475_chip_info[ADIS16576_3] },
+	{ .compatible = "adi,adis16577-2",
+		.data = &adis16475_chip_info[ADIS16577_2] },
+	{ .compatible = "adi,adis16577-3",
+		.data = &adis16475_chip_info[ADIS16577_3] },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adis16475_of_match);
@@ -1598,6 +2101,12 @@ static const struct spi_device_id adis16475_ids[] = {
 	{ "adis16507-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_1] },
 	{ "adis16507-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_2] },
 	{ "adis16507-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_3] },
+	{ "adis16575-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16575_2] },
+	{ "adis16575-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16575_3] },
+	{ "adis16576-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16576_2] },
+	{ "adis16576-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16576_3] },
+	{ "adis16577-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16577_2] },
+	{ "adis16577-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16577_3] },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adis16475_ids);
--
2.34.1


