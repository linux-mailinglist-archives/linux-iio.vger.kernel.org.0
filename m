Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD6E2653ED
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 23:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgIJMi5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 08:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbgIJMcz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 08:32:55 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A702C061573;
        Thu, 10 Sep 2020 05:32:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u3so2963929pjr.3;
        Thu, 10 Sep 2020 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrt2Zo0I7V3qw8iOGxULBlBEn4cKaIZWUdf+NM+cwwI=;
        b=Sa07GR4U8PmycSTRVlQlKdM9ZT4+Z8sDIuDG5pGA0UmWMhzIYrNyIy5Ma02ToFIy4Q
         Y1JcBvQRg+UJU0JoCl9JrLYD0swB2PB3hjQ6VAK8PJ5enuCFN5sFVZKDplsJa+eH2aP4
         eG20r5s2nfDdnxa1d2f2cvE24NniqAZexkuS3nZ4kUhrA0TS1/KBvmLr4/bkbUQu4kq2
         2wulPQhYJ6FJ0idPGZoBPj5jtaUYM0QOm+n/q29ZTWy+c4Fn63FUJpj4Rm3hDPZJ9C+f
         ppfg6lPzD79bD41NzK9l0qFE7TGrRC3H+FNi4gPSt9JKG+0FiuArqgCgBV2uzHv/f5CG
         tb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrt2Zo0I7V3qw8iOGxULBlBEn4cKaIZWUdf+NM+cwwI=;
        b=SPJMZmAF+64PwxAYQd+4JFAo08uTflJ81S5oy/K/dCEbiVjCLx7zi0fCiHZwO4qGlE
         PqVkFk4s2al7FHSGxZGlpXNCA3Nsy/EgCWEaV9DxmpU8tzgfrn65Kr5avrSEI7ry0Nad
         xdWbt37mpvHefpsiQjA0BHwpfdQPTU4NCg65BXq4wW2XV43tYw1MmwSzUtOEEJ+TWtp7
         CgxfRA2rX4v+ApfdJiSP1qSfprfDDIpqdBvVw/bNYDnUlMqumW+1JmETnq/Rj56+iiFD
         Wxgost3jYOL3+2RZm3fbSxqpHgFtyjf4ixnVkNlR9/XPN/05Juwul2Rn7BPy3Q18M921
         YUIg==
X-Gm-Message-State: AOAM532fpQL1fpdEgqIE7oIAdkxOqW1JHTh4b31POBi7ICSQhaE5anEy
        /jrVIhfI78yEp1HO0rcXKvo=
X-Google-Smtp-Source: ABdhPJw6I+KooSh37nQCpjRHfmq62ZJbutI5QVxhjghyh1LzLiwJ/p7iAoVHLeB76LrB1BGiX0I3Vg==
X-Received: by 2002:a17:902:b10a:: with SMTP id q10mr5354001plr.156.1599741144391;
        Thu, 10 Sep 2020 05:32:24 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6218:54d7:9928:e984:12bb:783d])
        by smtp.gmail.com with ESMTPSA id f4sm3056475pfa.125.2020.09.10.05.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:32:23 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH v3 1/3] iio: gyro: adxrs290: Add triggered buffer support
Date:   Thu, 10 Sep 2020 18:02:15 +0530
Message-Id: <20200910123215.17074-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
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

Changes in v3:
  - issue a separate precursor patch for the devm resource unwinding hook
  - rename labels in the error-path
  - use dev_err_probe() (which handles deferred probing) only for calls
    which request h/w resources

Changes in v2:

  - In adxrs290_set_mode(), move 'if' block outside the locked section
  - use break statement for error handling instead of goto labels in
    switch-case blocks
  - remove outer parentheses when conditional ternary operator is used
  - use dev_err_probe() saving a few lines of code
  - re-align 'buffer' variable name in 'struct adxrs290_state'
  - don't return errors in 'try_reenable' callback
  - use 'st->spi' inline in 'adxrs290_trigger_handler'
  - unnecessary to mention default 'shift' (= 0) in
    iio_chan_spec.scan_type
  - bring in consistent wrapping of parameters while staying under
    the advised 80 chars line limit
---
 drivers/iio/gyro/Kconfig    |   2 +
 drivers/iio/gyro/adxrs290.c | 211 +++++++++++++++++++++++++++++++++---
 2 files changed, 199 insertions(+), 14 deletions(-)

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
index 2864eb443957..41b1f995a143 100644
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
+	} buffer;
 };
 
 /*
@@ -270,24 +289,34 @@ static int adxrs290_read_raw(struct iio_dev *indio_dev,
 
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
+				break;
 
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
+			break;
 		case IIO_TEMP:
 			ret = adxrs290_get_temp_data(indio_dev, val);
 			if (ret < 0)
-				return ret;
+				break;
 
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
+
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
@@ -334,34 +363,52 @@ static int adxrs290_write_raw(struct iio_dev *indio_dev,
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
+			break;
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
+			break;
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
+	iio_device_release_direct_mode(indio_dev);
+	return ret;
 }
 
 static int adxrs290_read_avail(struct iio_dev *indio_dev,
@@ -389,6 +436,72 @@ static int adxrs290_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxrs290_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					       bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	int ret;
+	u8 val;
+
+	val = state ? ADXRS290_SYNC(ADXRS290_DATA_RDY_OUT) : 0;
+
+	ret = adxrs290_spi_write_reg(st->spi, ADXRS290_REG_DATA_RDY, val);
+	if (ret < 0)
+		dev_err(&st->spi->dev, "failed to start data rdy interrupt\n");
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
+	 * a read of the data registers and initiates a reset for the interrupt
+	 * line.
+	 */
+	adxrs290_get_rate_data(indio_dev,
+			       ADXRS290_READ_REG(ADXRS290_REG_DATAY0), &val);
+
+	return 0;
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
+	u8 tx = ADXRS290_READ_REG(ADXRS290_REG_DATAX0);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	/* exercise a bulk data capture starting from reg DATAX0... */
+	ret = spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.channels,
+				  sizeof(st->buffer.channels));
+	if (ret < 0)
+		goto out_unlock_notify;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
+					   pf->timestamp);
+
+out_unlock_notify:
+	mutex_unlock(&st->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 #define ADXRS290_ANGL_VEL_CHANNEL(reg, axis) {				\
 	.type = IIO_ANGL_VEL,						\
 	.address = reg,							\
@@ -401,6 +514,13 @@ static int adxrs290_read_avail(struct iio_dev *indio_dev,
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
@@ -411,7 +531,20 @@ static const struct iio_chan_spec adxrs290_channels[] = {
 		.address = ADXRS290_REG_TEMP0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = ADXRS290_IDX_TEMP,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 12,
+			.storagebits = 16,
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
@@ -420,6 +553,44 @@ static const struct iio_info adxrs290_info = {
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
+	st->dready_trig = devm_iio_trigger_alloc(&st->spi->dev, "%s-dev%d",
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
+			       IRQF_ONESHOT, "adxrs290_irq", st->dready_trig);
+	if (ret < 0)
+		return dev_err_probe(&st->spi->dev, ret,
+				     "request irq %d failed\n", st->spi->irq);
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
@@ -439,6 +610,7 @@ static int adxrs290_probe(struct spi_device *spi)
 	indio_dev->channels = adxrs290_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxrs290_channels);
 	indio_dev->info = &adxrs290_info;
+	indio_dev->available_scan_masks = adxrs290_avail_scan_masks;
 
 	mutex_init(&st->lock);
 
@@ -478,6 +650,17 @@ static int adxrs290_probe(struct spi_device *spi)
 	st->lpf_3db_freq_idx = val;
 	st->hpf_3db_freq_idx = val2;
 
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &adxrs290_trigger_handler, NULL);
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
+				     "iio triggered buffer setup failed\n");
+
+	ret = adxrs290_probe_trigger(indio_dev);
+	if (ret < 0)
+		return ret;
+
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
-- 
2.20.1

