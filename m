Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F214A3EB2B2
	for <lists+linux-iio@lfdr.de>; Fri, 13 Aug 2021 10:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbhHMIfx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Aug 2021 04:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhHMIfu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Aug 2021 04:35:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F983C061756;
        Fri, 13 Aug 2021 01:35:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q2so10943034plr.11;
        Fri, 13 Aug 2021 01:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4GsNW56/UTWAKNJcOVAzElbQgz8X5qDWWkjKF7FjuM8=;
        b=SciHUmuvLOFOUpXdwCrJ/1HSWkBiy8qVuLN6n0GHOOQrPHwyBBuMZJBqsUPw/8+01m
         haWmi8fkQryC6BDANwMCDRSlfeOcuNpXX8oN1cbYno5SOv2p2QoYRRndeJRw1QzjcT7g
         XUns4vNTyjtZtqZjdZkkwsVHLFPhHaYZUspIQlzIRLCR3GIB2k4FjfpIqSRrdqOlBtAP
         231NPw5Dpvm8Ur30PbDop//SJCKAB9wTFDLRtHn+tiOiD6BAecK4vgqsAQJ5yzp1DGrM
         8kInF4LEVgTD4zE2VnvB6EjKPdF6PZ6hITHDrkndGpit3RtoE7c8H5rUq0ZHUeNxqCkJ
         i0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4GsNW56/UTWAKNJcOVAzElbQgz8X5qDWWkjKF7FjuM8=;
        b=RTXLczUf24v633bxgDiz+jvOjnFP04+E8q2uwWJWNp3F28JzzhgrGvjOOvfxlvjDeN
         oIG77R/ASHI6ctxepxzSBlQUBb49t8S+aSqXCrVYQTyBe4eSi1qfSmI0pw5upTI/OreC
         4nKMLb/aP4Kw0rUYbDcs78WhsKCI17KJz92E8zOoDAa85D/DvY3It0aaQKHnnhVzbtDn
         z4vom6EFUobr6+xySbxf2bo+6s2I+iVpkf4y3402i9qdnRhoEig9WOlvapyfsBV7Hy8w
         S6z3ox/DYY6HwwuFFMyQeRhdJRMAYDWbCxVu554aE6tmkEYBYO6wZrYjzSO7fqSM3/Ax
         2cZA==
X-Gm-Message-State: AOAM532FNOTKWr5MnSayhMRvSELPEP/v3OjwKfoLKgC1oxVdF6sEfBZ3
        4veOcbrtoIYw+FvrWpYL25s=
X-Google-Smtp-Source: ABdhPJxR8lCxtwSp2FFc6DPT1zBpjAZaEhOiOdFeuW5JCEBbPvgVZY6valh9pcZRYa8BLr7GGkMqkQ==
X-Received: by 2002:a63:fe52:: with SMTP id x18mr1424644pgj.84.1628843723927;
        Fri, 13 Aug 2021 01:35:23 -0700 (PDT)
Received: from localhost.localdomain ([49.156.122.252])
        by smtp.googlemail.com with ESMTPSA id w82sm1363569pff.112.2021.08.13.01.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:35:23 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com, andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH] iio: accel: adxl355: Add triggered buffer support
Date:   Fri, 13 Aug 2021 14:04:55 +0530
Message-Id: <20210813083455.252986-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Provide a way for continuous data capture by setting up buffer support. The
data ready signal exposed at the DRDY pin of the ADXL355 is exploited as
a hardware interrupt which triggers to fill the buffer.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/iio/accel/Kconfig        |   4 +
 drivers/iio/accel/adxl355_core.c | 154 ++++++++++++++++++++++++++++++-
 2 files changed, 155 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index d0c45c809..9c16c1841 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -69,6 +69,8 @@ config ADXL355_I2C
 	depends on I2C
 	select ADXL355
 	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here if you want to build i2c support for the Analog Devices
 	  ADXL355 3-axis digital accelerometer.
@@ -82,6 +84,8 @@ config ADXL355_SPI
 	depends on SPI
 	select ADXL355
 	select REGMAP_SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here if you want to build spi support for the Analog Devices
 	  ADXL355 3-axis digital accelerometer.
diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index c91d2254c..bd5304bcf 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -6,14 +6,18 @@
  *
  * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adxl354_adxl355.pdf
  */
-
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 #include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <asm/unaligned.h>
 
@@ -46,6 +50,7 @@
 #define ADXL355_RANGE_REG		0x2C
 #define ADXL355_POWER_CTL_REG		0x2D
 #define  ADXL355_POWER_CTL_MODE_MSK	GENMASK(1, 0)
+#define  ADXL355_POWER_CTL_DRDY_MSK	BIT(2)
 #define ADXL355_SELF_TEST_REG		0x2E
 #define ADXL355_RESET_REG		0x2F
 
@@ -157,6 +162,7 @@ static const struct adxl355_chan_info adxl355_chans[] = {
 };
 
 struct adxl355_data {
+	int irq;
 	struct regmap *regmap;
 	struct device *dev;
 	struct mutex lock; /* lock to protect op_mode */
@@ -165,7 +171,14 @@ struct adxl355_data {
 	enum adxl355_hpf_3db hpf_3db;
 	int calibbias[3];
 	int adxl355_hpf_3db_table[7][2];
-	u8 transf_buf[3] ____cacheline_aligned;
+	struct iio_trigger      *dready_trig;
+	union {
+		u8 transf_buf[3];
+		struct {
+			u8 buf[14];
+			s64 ts;
+		} buffer;
+	} ____cacheline_aligned;
 };
 
 static int adxl355_set_op_mode(struct adxl355_data *data,
@@ -186,6 +199,23 @@ static int adxl355_set_op_mode(struct adxl355_data *data,
 	return ret;
 }
 
+static int adxl355_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					      bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct adxl355_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
+				 ADXL355_POWER_CTL_DRDY_MSK,
+				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK,
+					    !state));
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
 static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
 {
 	u32 multiplier;
@@ -246,6 +276,12 @@ static int adxl355_setup(struct adxl355_data *data)
 	if (ret)
 		return ret;
 
+	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
+				 ADXL355_POWER_CTL_DRDY_MSK,
+				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK, 1));
+	if (ret)
+		return ret;
+
 	adxl355_fill_3db_frequency_table(data);
 
 	return adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
@@ -499,12 +535,65 @@ static int adxl355_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static const unsigned long adxl355_avail_scan_masks[] = {
+	GENMASK(3, 0),
+	0
+};
+
 static const struct iio_info adxl355_info = {
 	.read_raw	= adxl355_read_raw,
 	.write_raw	= adxl355_write_raw,
 	.read_avail	= &adxl355_read_avail,
 };
 
+static const struct iio_trigger_ops adxl355_trigger_ops = {
+	.set_trigger_state = &adxl355_data_rdy_trigger_set_state,
+	.validate_device = &iio_trigger_validate_own_device,
+};
+
+static irqreturn_t adxl355_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adxl355_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	ret = regmap_bulk_read(data->regmap, ADXL355_XDATA3_REG,
+			       &data->buffer.buf[1],
+			       3);
+	if (ret)
+		goto out_unlock_notify;
+
+	ret = regmap_bulk_read(data->regmap, ADXL355_YDATA3_REG,
+			       &data->buffer.buf[5],
+			       3);
+	if (ret)
+		goto out_unlock_notify;
+
+	ret = regmap_bulk_read(data->regmap, ADXL355_ZDATA3_REG,
+			       &data->buffer.buf[9],
+			       3);
+	if (ret)
+		goto out_unlock_notify;
+
+	ret = regmap_bulk_read(data->regmap, ADXL355_TEMP2_REG,
+			       &data->buffer.buf[12],
+			       2);
+	if (ret)
+		goto out_unlock_notify;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
+					   pf->timestamp);
+
+out_unlock_notify:
+	mutex_unlock(&data->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 #define ADXL355_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -518,6 +607,7 @@ static const struct iio_info adxl355_info = {
 	.info_mask_shared_by_type_available =				\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
 		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
+	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
 		.realbits = 20,						\
@@ -537,6 +627,7 @@ static const struct iio_chan_spec adxl355_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = 3,
 		.scan_type = {
 			.sign = 's',
 			.realbits = 12,
@@ -544,8 +635,46 @@ static const struct iio_chan_spec adxl355_channels[] = {
 			.endianness = IIO_BE,
 		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
+static int adxl355_probe_trigger(struct iio_dev *indio_dev)
+{
+	struct adxl355_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (!data->irq) {
+		dev_info(data->dev, "no irq, using polling\n");
+		return 0;
+	}
+
+	data->dready_trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
+						   indio_dev->name,
+						   indio_dev->id);
+	if (!data->dready_trig)
+		return -ENOMEM;
+
+	data->dready_trig->ops = &adxl355_trigger_ops;
+	iio_trigger_set_drvdata(data->dready_trig, indio_dev);
+
+	ret = devm_request_irq(data->dev, data->irq,
+			       &iio_trigger_generic_data_rdy_poll,
+			       IRQF_ONESHOT, "adxl355_irq", data->dready_trig);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret, "request irq %d failed\n",
+				     data->irq);
+
+	ret = devm_iio_trigger_register(data->dev, data->dready_trig);
+	if (ret) {
+		dev_err(data->dev, "iio trigger register failed\n");
+		return ret;
+	}
+
+	indio_dev->trig = iio_trigger_get(data->dready_trig);
+
+	return 0;
+}
+
 int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 		       const char *name)
 {
@@ -563,18 +692,37 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 	data->op_mode = ADXL355_STANDBY;
 	mutex_init(&data->lock);
 
+	/*
+	 * Would be good to move it to the generic version.
+	 */
+	ret = of_irq_get_byname(dev->of_node, "DRDY");
+	if (ret > 0)
+		data->irq = ret;
+
 	indio_dev->name = name;
 	indio_dev->info = &adxl355_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl355_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl355_channels);
+	indio_dev->available_scan_masks = adxl355_avail_scan_masks;
 
 	ret = adxl355_setup(data);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(dev, "ADXL355 setup failed\n");
 		return ret;
 	}
 
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &adxl355_trigger_handler, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "iio triggered buffer setup failed\n");
+
+	ret = adxl355_probe_trigger(indio_dev);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_GPL(adxl355_core_probe);
-- 
2.30.1

