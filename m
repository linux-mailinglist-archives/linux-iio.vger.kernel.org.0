Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF5B2518D8
	for <lists+linux-iio@lfdr.de>; Tue, 25 Aug 2020 14:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHYMrs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Aug 2020 08:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgHYMrr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Aug 2020 08:47:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F715C061574;
        Tue, 25 Aug 2020 05:47:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nv17so1199783pjb.3;
        Tue, 25 Aug 2020 05:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWx5awK4K9eJcCbumClelHKWUpnz2Dv4DMf0B72fPkQ=;
        b=coYd+f14bARc6NtbO8IcE5B/Mzap6FKIiOQSbMedhkvqpV6rdrkhDpGxI350BOmiCC
         yES6wL4pny8kdcgI8DqL9F6CWaFryKPl/ugXhnU7FCPmVev3v9Y2wTnCE7g5k8qelcT4
         QLF4CGFNtbeVxC/95aaaodypqjxqdLp3SbkcU5SIKzmt4BoAui6A0qs74scRKffsA9hg
         VaXuixhxZxlS4l8/aCI8M1WgKD4sy8I4RrmdHjvTAfncPGLepF9oAy/QjWt1xlYZcP7J
         YY6sbBb+5pXJOOeIvB93WbApS0IaMOrF4biY7uaE2cw2vyesCEUBCzwrGGgJNRMNmQtK
         4bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWx5awK4K9eJcCbumClelHKWUpnz2Dv4DMf0B72fPkQ=;
        b=cq2jSUp8AcR91egNwEWd/v08J9BeWKh5Gpkk+bWB28IFvluQknW42MCr1nfda/fZwr
         Aoa5mSkdvVUORbhZ7nCH6w5jK2+qdokLJwmxzXkLCmInW9d+0M2m/5xvd1AE3XonuGLN
         mQQgSV8JeNgU/Ny9UQh40yOCBw5sNN3gtNJ5ZOo2jSwCaKYiRVNy1JerZeAr30iMXxui
         gn85cl96Ov/+V2QiiPJnlJMYkfZgJvtRyn4p3j1vg3zGMIMOKdOrLHl1qE6U6A9GD9P2
         s0a5qkTXV0MLlQ3iZVF+N9S6l4uHaDfv5MItvGfg9mnyJ7iBljgBGbz62APYhSFlpWWI
         Kiyw==
X-Gm-Message-State: AOAM5336AWHW924k5hV6E9mq9bstWtIOYcAhlHd2uDXZMX7zligO0osc
        WKoq5yJJkScH33tWEFIlWwQ=
X-Google-Smtp-Source: ABdhPJx6dEGm5vVOiZr5D1LXu8PGl7o1uNbPCdSdCn8/VkjceSjit+CqSKj0GyIh+GiSy2lxj+TRwQ==
X-Received: by 2002:a17:90a:4f0e:: with SMTP id p14mr1532887pjh.31.1598359667005;
        Tue, 25 Aug 2020 05:47:47 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:619:dc6c:a526:a3b6:4686:f6fb])
        by smtp.gmail.com with ESMTPSA id u5sm14656833pfm.149.2020.08.25.05.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 05:47:46 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH 1/3] iio: gyro: adxrs290: Add triggered buffer support
Date:   Tue, 25 Aug 2020 18:17:09 +0530
Message-Id: <20200825124711.11455-2-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200825124711.11455-1-nish.malpani25@gmail.com>
References: <20200825124711.11455-1-nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Provide a way for continuous data capture by setting up buffer support. The
data ready signal exposed at the SYNC pin of the ADXRS290 is exploited as
a hardware interrupt which triggers to fill the buffer.

Triggered buffer setup was tested with both hardware trigger (DATA_RDY) and
software triggers (sysfs-trig & hrtimer).

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---
 drivers/iio/gyro/Kconfig    |   2 +
 drivers/iio/gyro/adxrs290.c | 272 ++++++++++++++++++++++++++++++++++--
 2 files changed, 260 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 024a34139875..5824f2edf975 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -44,6 +44,8 @@ config ADIS16260
 config ADXRS290
 	tristate "Analog Devices ADXRS290 Dual-Axis MEMS Gyroscope SPI driver"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices ADXRS290 programmable
 	  digital output gyroscope.
diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index ff989536d2fb..25046590761e 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -13,8 +13,12 @@
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #define ADXRS290_ADI_ID		0xAD
 #define ADXRS290_MEMS_ID	0x1D
@@ -35,7 +39,9 @@
 #define ADXRS290_READ		BIT(7)
 #define ADXRS290_TSM		BIT(0)
 #define ADXRS290_MEASUREMENT	BIT(1)
-#define ADXRS290_SYNC		GENMASK(1, 0)
+#define ADXRS290_DATA_RDY_OUT	BIT(0)
+#define ADXRS290_SYNC_MASK	GENMASK(1, 0)
+#define ADXRS290_SYNC(x)	FIELD_PREP(ADXRS290_SYNC_MASK, x)
 #define ADXRS290_LPF_MASK	GENMASK(2, 0)
 #define ADXRS290_LPF(x)		FIELD_PREP(ADXRS290_LPF_MASK, x)
 #define ADXRS290_HPF_MASK	GENMASK(7, 4)
@@ -50,6 +56,13 @@ enum adxrs290_mode {
 	ADXRS290_MODE_MEASUREMENT,
 };
 
+enum adxrs290_scan_index {
+	ADXRS290_IDX_X,
+	ADXRS290_IDX_Y,
+	ADXRS290_IDX_TEMP,
+	ADXRS290_IDX_TS,
+};
+
 struct adxrs290_state {
 	struct spi_device	*spi;
 	/* Serialize reads and their subsequent processing */
@@ -57,6 +70,12 @@ struct adxrs290_state {
 	enum adxrs290_mode	mode;
 	unsigned int		lpf_3db_freq_idx;
 	unsigned int		hpf_3db_freq_idx;
+	struct iio_trigger      *dready_trig;
+	/* Ensure correct alignment of timestamp when present */
+	struct {
+		s16 channels[3];
+		s64 ts __aligned(8);
+	}                       buffer;
 };
 
 /*
@@ -192,6 +211,52 @@ static int adxrs290_set_filter_freq(struct iio_dev *indio_dev,
 	return adxrs290_spi_write_reg(st->spi, ADXRS290_REG_FILTER, val);
 }
 
+static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	int val, ret;
+
+	mutex_lock(&st->lock);
+
+	if (st->mode == mode) {
+		ret = 0;
+		goto done;
+	}
+
+	val = spi_w8r8(st->spi, ADXRS290_READ_REG(ADXRS290_REG_POWER_CTL));
+	if (val < 0) {
+		ret = val;
+		goto done;
+	}
+
+	switch (mode) {
+	case ADXRS290_MODE_STANDBY:
+		val &= ~ADXRS290_MEASUREMENT;
+		break;
+	case ADXRS290_MODE_MEASUREMENT:
+		val |= ADXRS290_MEASUREMENT;
+		break;
+	default:
+		ret = -EINVAL;
+		goto done;
+	}
+
+	ret = adxrs290_spi_write_reg(st->spi,
+				     ADXRS290_REG_POWER_CTL,
+				     val);
+	if (ret < 0) {
+		dev_err(&st->spi->dev, "unable to set mode: %d\n", ret);
+		goto done;
+	}
+
+	/* update cached mode */
+	st->mode = mode;
+
+done:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
 static int adxrs290_initial_setup(struct iio_dev *indio_dev)
 {
 	struct adxrs290_state *st = iio_priv(indio_dev);
@@ -203,6 +268,13 @@ static int adxrs290_initial_setup(struct iio_dev *indio_dev)
 				      ADXRS290_MEASUREMENT | ADXRS290_TSM);
 }
 
+static void adxrs290_chip_off_action(void *data)
+{
+	struct iio_dev *indio_dev = data;
+
+	adxrs290_set_mode(indio_dev, ADXRS290_MODE_STANDBY);
+}
+
 static int adxrs290_read_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int *val,
@@ -215,24 +287,34 @@ static int adxrs290_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
 			ret = adxrs290_get_rate_data(indio_dev,
 						     ADXRS290_READ_REG(chan->address),
 						     val);
 			if (ret < 0)
-				return ret;
+				goto err_release;
 
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
+			break;
 		case IIO_TEMP:
 			ret = adxrs290_get_temp_data(indio_dev, val);
 			if (ret < 0)
-				return ret;
+				goto err_release;
 
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
+err_release:
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
@@ -279,34 +361,53 @@ static int adxrs290_write_raw(struct iio_dev *indio_dev,
 			      long mask)
 {
 	struct adxrs290_state *st = iio_priv(indio_dev);
-	int lpf_idx, hpf_idx;
+	int ret, lpf_idx, hpf_idx;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		lpf_idx = adxrs290_find_match(adxrs290_lpf_3db_freq_hz_table,
 					      ARRAY_SIZE(adxrs290_lpf_3db_freq_hz_table),
 					      val, val2);
-		if (lpf_idx < 0)
-			return -EINVAL;
+		if (lpf_idx < 0) {
+			ret = -EINVAL;
+			goto err_release;
+		}
+
 		/* caching the updated state of the low-pass filter */
 		st->lpf_3db_freq_idx = lpf_idx;
 		/* retrieving the current state of the high-pass filter */
 		hpf_idx = st->hpf_3db_freq_idx;
-		return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
+		ret = adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
+		break;
+
 	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
 		hpf_idx = adxrs290_find_match(adxrs290_hpf_3db_freq_hz_table,
 					      ARRAY_SIZE(adxrs290_hpf_3db_freq_hz_table),
 					      val, val2);
-		if (hpf_idx < 0)
-			return -EINVAL;
+		if (hpf_idx < 0) {
+			ret = -EINVAL;
+			goto err_release;
+		}
+
 		/* caching the updated state of the high-pass filter */
 		st->hpf_3db_freq_idx = hpf_idx;
 		/* retrieving the current state of the low-pass filter */
 		lpf_idx = st->lpf_3db_freq_idx;
-		return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
+		ret = adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
 	}
 
-	return -EINVAL;
+err_release:
+	iio_device_release_direct_mode(indio_dev);
+	return ret;
 }
 
 static int adxrs290_read_avail(struct iio_dev *indio_dev,
@@ -334,6 +435,68 @@ static int adxrs290_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxrs290_data_rdy_trigger_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	int ret;
+	u8 val;
+
+	val = (state ? ADXRS290_SYNC(ADXRS290_DATA_RDY_OUT) : 0);
+
+	ret = adxrs290_spi_write_reg(st->spi, ADXRS290_REG_DATA_RDY, val);
+	if (ret < 0)
+		dev_err(&st->spi->dev, "failed to start data ready interrupt\n");
+
+	return ret;
+}
+
+static int adxrs290_reset_trig(struct iio_trigger *trig)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	int val;
+
+	/*
+	 * Data ready interrupt is reset after a read of the data registers.
+	 * Here, we only read the 16b DATAY registers as that marks the end of
+	 * a read of the data registers and initiates a reset for the interrupt line.
+	 */
+	return adxrs290_get_rate_data(indio_dev, ADXRS290_READ_REG(ADXRS290_REG_DATAY0), &val);
+}
+
+static const struct iio_trigger_ops adxrs290_trigger_ops = {
+	.set_trigger_state = &adxrs290_data_rdy_trigger_set_state,
+	.validate_device = &iio_trigger_validate_own_device,
+	.try_reenable = &adxrs290_reset_trig,
+};
+
+static irqreturn_t adxrs290_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	struct spi_device *spi = st->spi;
+	u8 tx = ADXRS290_READ_REG(ADXRS290_REG_DATAX0);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	/* exercise a bulk data capture starting from reg DATAX0... */
+	ret = spi_write_then_read(spi, &tx, sizeof(tx), st->buffer.channels,
+				  sizeof(st->buffer.channels));
+	if (ret < 0)
+		goto done;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
+					   pf->timestamp);
+
+done:
+	mutex_unlock(&st->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 #define ADXRS290_ANGL_VEL_CHANNEL(reg, axis) {				\
 	.type = IIO_ANGL_VEL,						\
 	.address = reg,							\
@@ -346,6 +509,13 @@ static int adxrs290_read_avail(struct iio_dev *indio_dev,
 	.info_mask_shared_by_type_available =				\
 	BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |		\
 	BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),		\
+	.scan_index = ADXRS290_IDX_##axis,				\
+	.scan_type = {                                                  \
+		.sign = 's',                                            \
+		.realbits = 16,                                         \
+		.storagebits = 16,                                      \
+		.endianness = IIO_LE,					\
+	},                                                              \
 }
 
 static const struct iio_chan_spec adxrs290_channels[] = {
@@ -356,7 +526,21 @@ static const struct iio_chan_spec adxrs290_channels[] = {
 		.address = ADXRS290_REG_TEMP0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = ADXRS290_IDX_TEMP,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 12,
+			.storagebits = 16,
+			.shift = 0,
+			.endianness = IIO_LE,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(ADXRS290_IDX_TS),
+};
+
+static const unsigned long adxrs290_avail_scan_masks[] = {
+	BIT(ADXRS290_IDX_X) | BIT(ADXRS290_IDX_Y) | BIT(ADXRS290_IDX_TEMP),
+	0
 };
 
 static const struct iio_info adxrs290_info = {
@@ -365,6 +549,47 @@ static const struct iio_info adxrs290_info = {
 	.read_avail = &adxrs290_read_avail,
 };
 
+static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!st->spi->irq) {
+		dev_info(&st->spi->dev, "no irq, using polling\n");
+		return 0;
+	}
+
+	st->dready_trig = devm_iio_trigger_alloc(&st->spi->dev,
+						 "%s-dev%d",
+						 indio_dev->name,
+						 indio_dev->id);
+	if (!st->dready_trig)
+		return -ENOMEM;
+
+	st->dready_trig->dev.parent = &st->spi->dev;
+	st->dready_trig->ops = &adxrs290_trigger_ops;
+	iio_trigger_set_drvdata(st->dready_trig, indio_dev);
+
+	ret = devm_request_irq(&st->spi->dev, st->spi->irq,
+			       &iio_trigger_generic_data_rdy_poll,
+			       IRQF_ONESHOT,
+			       "adxrs290_irq", st->dready_trig);
+	if (ret < 0) {
+		dev_err(&st->spi->dev, "request irq %d failed\n", st->spi->irq);
+		return ret;
+	}
+
+	ret = devm_iio_trigger_register(&st->spi->dev, st->dready_trig);
+	if (ret) {
+		dev_err(&st->spi->dev, "iio trigger register failed\n");
+		return ret;
+	}
+
+	indio_dev->trig = iio_trigger_get(st->dready_trig);
+
+	return 0;
+}
+
 static int adxrs290_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -384,6 +609,7 @@ static int adxrs290_probe(struct spi_device *spi)
 	indio_dev->channels = adxrs290_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxrs290_channels);
 	indio_dev->info = &adxrs290_info;
+	indio_dev->available_scan_masks = adxrs290_avail_scan_masks;
 
 	mutex_init(&st->lock);
 
@@ -416,6 +642,12 @@ static int adxrs290_probe(struct spi_device *spi)
 	/* max transition time to measurement mode */
 	msleep(ADXRS290_MAX_TRANSITION_TIME_MS);
 
+	ret = devm_add_action_or_reset(&spi->dev,
+				       adxrs290_chip_off_action,
+				       indio_dev);
+	if (ret < 0)
+		return ret;
+
 	ret = adxrs290_get_3db_freq(indio_dev, &val, &val2);
 	if (ret < 0)
 		return ret;
@@ -423,6 +655,18 @@ static int adxrs290_probe(struct spi_device *spi)
 	st->lpf_3db_freq_idx = val;
 	st->hpf_3db_freq_idx = val2;
 
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &adxrs290_trigger_handler, NULL);
+	if (ret < 0) {
+		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
+		return ret;
+	}
+
+	ret = adxrs290_probe_trigger(indio_dev);
+	if (ret < 0)
+		return ret;
+
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
-- 
2.20.1

