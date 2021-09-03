Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C284400506
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 20:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349426AbhICSob (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 14:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349387AbhICSo3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 14:44:29 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C45C061575;
        Fri,  3 Sep 2021 11:43:29 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r2so6340028pgl.10;
        Fri, 03 Sep 2021 11:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KefH4IJYdT8TusVrHVc3jDLnuRH7znx/MRCTGViVfeM=;
        b=iMgugslSQj96T6xaBk+bq74ktBhR9ihW13bCJ919/VKuDC8YZhskaZMoOwGUGjwZTL
         AOiXxIIoPmHlxT3hOs/qbeCooKU1VxeKaloz7PpOTPHmDovIVGEXYVG1ISAJfyZ6BQOs
         dDRVBkUZl3zNb86FnGdYDywGlUQnWpPvlHGHAR6IqLX+BFza9ebOehufzBKSwF+Wvgvk
         MQ0gm56HndI2X93RrhboY5nnys7Gh79ety2+d5csdGgJxlEGXSkz0iXtvadRq+okDOxJ
         RGcZNj6hdnzKiYZdW6SqlWuFjqpVOsBinNB4sIgQGBAwvBbdKIpcYIjD2yTcbM37dwYd
         mugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KefH4IJYdT8TusVrHVc3jDLnuRH7znx/MRCTGViVfeM=;
        b=CL2hbKSHDh1TtG2F23UH62Xb24AjPMz3DexV/+BN2HvQ1A2YcVvHtVP3Ru+IPEKB2l
         Q39otAeJSYWv5l3SNP+GpUWxVDXtYSvE54SOYlhQqZBQJMSb+bjQzfp7ioVGV9+e9g/D
         KpRRL9Kckuz9vo29ouMjucan1rFfZxidZLZjK6aOw10CFIm47jsuAmulKhBh8tKYAxz7
         U/CzLpsc7BcxxiEQC0sNntCAZHX0e8LBJJnO79U2e5Gpy8pfK67u2KuWqqeCLhhb7NG2
         4LWBDwHK+p2OdL6vYNMfHRKfIwpkIV+R822/RlbfbuoZ4tO0w5ZDFR02LmLtcJCqWpMu
         uSQg==
X-Gm-Message-State: AOAM532NVHhMDuSzs8w2lUy1xDOwjY3+m7441bkuACPlcNEk3tz2rB1e
        Lx86/DOuXnRUtUXMiDRrP3w=
X-Google-Smtp-Source: ABdhPJxHONiHS2tQ76PDwec3SKn+S1hTNAyYvL6EhcmaNkxfLOYKWjaZOv2XSVunZYfFk6ittnrKCg==
X-Received: by 2002:a63:1a61:: with SMTP id a33mr377336pgm.55.1630694609061;
        Fri, 03 Sep 2021 11:43:29 -0700 (PDT)
Received: from localhost.localdomain ([49.156.122.119])
        by smtp.googlemail.com with ESMTPSA id h4sm128186pjs.2.2021.09.03.11.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 11:43:28 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     jic23@kernel.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com, andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v2 2/2] iio: accel: adxl355: Add triggered buffer support
Date:   Sat,  4 Sep 2021 00:13:12 +0530
Message-Id: <20210903184312.21009-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210903184312.21009-1-puranjay12@gmail.com>
References: <20210903184312.21009-1-puranjay12@gmail.com>
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
 drivers/iio/accel/adxl355_core.c | 153 ++++++++++++++++++++++++++++++-
 2 files changed, 156 insertions(+), 1 deletion(-)

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
index 0b9996c17..4c561315f 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -9,11 +9,16 @@
 
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
 
@@ -46,6 +51,7 @@
 #define ADXL355_RANGE_REG		0x2C
 #define ADXL355_POWER_CTL_REG		0x2D
 #define  ADXL355_POWER_CTL_MODE_MSK	GENMASK(1, 0)
+#define  ADXL355_POWER_CTL_DRDY_MSK	BIT(2)
 #define ADXL355_SELF_TEST_REG		0x2E
 #define ADXL355_RESET_REG		0x2F
 
@@ -165,7 +171,14 @@ struct adxl355_data {
 	enum adxl355_hpf_3db hpf_3db;
 	int calibbias[3];
 	int adxl355_hpf_3db_table[7][2];
-	u8 transf_buf[3] ____cacheline_aligned;
+	struct iio_trigger *dready_trig;
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
@@ -499,12 +535,74 @@ static int adxl355_read_avail(struct iio_dev *indio_dev,
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
+	/*
+	 * data->buffer is used both for triggered buffer support
+	 * and read/write_raw(), hence, it has to be zeroed here before usage.
+	 */
+	data->buffer.buf[0] = 0;
+
+	/*
+	 * The acceleration data is 24 bits and big endian. It has to be saved
+	 * in 32 bits, hence, it is saved in the 2nd byte of the 4 byte buffer.
+	 * The buf array is 14 bytes as it includes 3x4=12 bytes for
+	 * accelaration data of x, y, and z axis. It also includes 2 bytes for
+	 * temperature data.
+	 */
+	ret = regmap_bulk_read(data->regmap, ADXL355_XDATA3_REG,
+			       &data->buffer.buf[1], 3);
+	if (ret)
+		goto out_unlock_notify;
+
+	ret = regmap_bulk_read(data->regmap, ADXL355_YDATA3_REG,
+			       &data->buffer.buf[5], 3);
+	if (ret)
+		goto out_unlock_notify;
+
+	ret = regmap_bulk_read(data->regmap, ADXL355_ZDATA3_REG,
+			       &data->buffer.buf[9], 3);
+	if (ret)
+		goto out_unlock_notify;
+
+	ret = regmap_bulk_read(data->regmap, ADXL355_TEMP2_REG,
+			       &data->buffer.buf[12], 2);
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
@@ -518,6 +616,7 @@ static const struct iio_info adxl355_info = {
 	.info_mask_shared_by_type_available =				\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
 		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
+	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
 		.realbits = 20,						\
@@ -537,6 +636,7 @@ static const struct iio_chan_spec adxl355_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = 3,
 		.scan_type = {
 			.sign = 's',
 			.realbits = 12,
@@ -544,14 +644,48 @@ static const struct iio_chan_spec adxl355_channels[] = {
 			.endianness = IIO_BE,
 		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
+static int adxl355_probe_trigger(struct iio_dev *indio_dev, int irq)
+{
+	struct adxl355_data *data = iio_priv(indio_dev);
+	int ret;
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
+	ret = devm_request_irq(data->dev, irq,
+			       &iio_trigger_generic_data_rdy_poll,
+			       IRQF_ONESHOT, "adxl355_irq", data->dready_trig);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "request irq %d failed\n",
+				     irq);
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
 	struct adxl355_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
+	int irq;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -568,6 +702,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl355_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl355_channels);
+	indio_dev->available_scan_masks = adxl355_avail_scan_masks;
 
 	ret = adxl355_setup(data);
 	if (ret) {
@@ -575,6 +710,22 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &adxl355_trigger_handler, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "iio triggered buffer setup failed\n");
+
+	/*
+	 * TODO: Would be good to move it to the generic version.
+	 */
+	irq = of_irq_get_byname(dev->of_node, "DRDY");
+	if (irq > 0)
+		ret = adxl355_probe_trigger(indio_dev, irq);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_GPL(adxl355_core_probe);
-- 
2.30.1

