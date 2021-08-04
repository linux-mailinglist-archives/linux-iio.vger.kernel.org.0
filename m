Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307233E02AF
	for <lists+linux-iio@lfdr.de>; Wed,  4 Aug 2021 16:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbhHDOED (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Aug 2021 10:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbhHDOEA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Aug 2021 10:04:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62889C0613D5;
        Wed,  4 Aug 2021 07:03:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so8840063pjb.3;
        Wed, 04 Aug 2021 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qcD8aSc4/KACHcLwkbrS4QVB6SkYXwRN5b168jQVc44=;
        b=OeIO4iYCkGlVMu/Iwih+cYc2LHrJWZuH+yU/mxHa0VzcBrhq1merUNgG4wH9PxVQuK
         YT06pBSsA4l03CYKpkGSWbtrPso4jcjxL65C4PyDVy5FPSmu9ePjgt9qK2ONGwNQqSGf
         /qtSxlfg1pCGaeUklEqFrnUSK0XBbMKWe2Wf1fMB+VeYvx3qQCy90BroVOAWUqG+QEMc
         EVqfBuUkr0tETZfhYoHcCe8uKDJoC6RC4XP+j+Gve6G/fkL6rVQMCTg0hIbQssnlTc6R
         y8CFTGvWckP9WxOtMR4cV18sx2wI5Aos498SZX1IYevftlV+6PDuo4PQc3LvyVdHXGl5
         iMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qcD8aSc4/KACHcLwkbrS4QVB6SkYXwRN5b168jQVc44=;
        b=bwVf0ocvtpTITFbZ63L0r03FGr3cfjyd/OsE/8UpJkT5jwNWGyj8dmBt0pkRdVkaR8
         Ipe7+k0mQ8tTuChIGMhkcGznizEhSn0yoyAWIjjYL6/yjUktfp7X3GY/W0295x6bN9QV
         STkjLKagAtKEPcC84tJ1xlrHUIa4U+7rNisOcqxTD0nToKeZ7WY4lRRV83wGNmG0ycqb
         K2IbxHS2RzX4TWQBkqfMhHgdV98cbjkB2a8Tyx2jyXbPtarSrqugmfYe+vR7ZkjfsdJv
         02BFBcJkMACH1hZyQLvF4xIQkTUmYoLg7uA1pJuiaLxXI374zOa+d9wD11Pxh7BJ3O/x
         yAUA==
X-Gm-Message-State: AOAM532vVdne9cHWChHqd2l9T3GfNt0KvaZubQEmRADdBQ6TtwpzXsLA
        9XNKUQMSECGzs+VYGSZNb0iWSyK1A08/Sg==
X-Google-Smtp-Source: ABdhPJxdNXp9PMPUvlzYTJehwiJ/Gq6md9tCrAF2VGUhbCnQsorW7hezWCvrpT/NFYyMts410fDCBQ==
X-Received: by 2002:a63:e14c:: with SMTP id h12mr64965pgk.431.1628085826944;
        Wed, 04 Aug 2021 07:03:46 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:20f:6a87:f508:aab5:2fa7:36da])
        by smtp.googlemail.com with ESMTPSA id z2sm4048408pgz.43.2021.08.04.07.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:03:46 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v8 3/3] iio: accel: adxl355: Add triggered buffer support
Date:   Wed,  4 Aug 2021 19:33:09 +0530
Message-Id: <20210804140309.31468-4-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210804140309.31468-1-puranjay12@gmail.com>
References: <20210804140309.31468-1-puranjay12@gmail.com>
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
 drivers/iio/accel/Kconfig        |   4 ++
 drivers/iio/accel/adxl355.h      |   2 +-
 drivers/iio/accel/adxl355_core.c | 102 ++++++++++++++++++++++++++++++-
 drivers/iio/accel/adxl355_i2c.c  |   3 +-
 drivers/iio/accel/adxl355_spi.c  |   2 +-
 5 files changed, 108 insertions(+), 5 deletions(-)

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
diff --git a/drivers/iio/accel/adxl355.h b/drivers/iio/accel/adxl355.h
index 322b0abb8..f0a376e6d 100644
--- a/drivers/iio/accel/adxl355.h
+++ b/drivers/iio/accel/adxl355.h
@@ -15,5 +15,5 @@ extern const struct regmap_access_table adxl355_readable_regs_tbl;
 extern const struct regmap_access_table adxl355_writeable_regs_tbl;
 
 int adxl355_core_probe(struct device *dev, struct regmap *regmap,
-		       const char *name);
+		       const char *name, int irq);
 #endif /* _ADXL355_H_ */
diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 47fbb31bc..f9dc2a530 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -9,6 +9,10 @@
 
 #include <asm/unaligned.h>
 #include <linux/bitfield.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/limits.h>
 #include <linux/math64.h>
@@ -172,6 +176,7 @@ static const struct adxl355_chan_info adxl355_chans[] = {
 };
 
 struct adxl355_data {
+	int irq;
 	struct regmap *regmap;
 	struct device *dev;
 	struct mutex lock; /* lock to protect op_mode */
@@ -181,6 +186,12 @@ struct adxl355_data {
 	int calibbias[3];
 	int adxl355_hpf_3db_table[7][2];
 	u8 transf_buf[3] ____cacheline_aligned;
+	struct iio_trigger      *dready_trig;
+	/* Ensure correct alignment of timestamp when present */
+	struct {
+		__be32 channels[3];
+		s64 ts;
+	} buffer ____cacheline_aligned;
 };
 
 static int adxl355_set_op_mode(struct adxl355_data *data,
@@ -499,12 +510,46 @@ static int adxl355_read_avail(struct iio_dev *indio_dev,
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
 	.read_avail	= &adxl355_read_avail
 };
 
+static const struct iio_trigger_ops adxl355_trigger_ops = {
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
+			       data->buffer.channels,
+			       9);
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
@@ -518,6 +563,7 @@ static const struct iio_info adxl355_info = {
 	.info_mask_shared_by_type_available =				\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
 		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
+	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
 		.realbits = 20,						\
@@ -537,17 +583,56 @@ static const struct iio_chan_spec adxl355_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = 3,
 		.scan_type = {
 			.sign = 's',
 			.realbits = 12,
 			.storagebits = 16,
 			.endianness = IIO_BE,
 		},
-	}
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(4)
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
-		       const char *name)
+		       const char *name, int irq)
 {
 	struct adxl355_data *data;
 	struct iio_dev *indio_dev;
@@ -560,6 +645,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 	data = iio_priv(indio_dev);
 	data->regmap = regmap;
 	data->dev = dev;
+	data->irq = irq;
 	data->op_mode = ADXL355_STANDBY;
 	mutex_init(&data->lock);
 
@@ -568,6 +654,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl355_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl355_channels);
+	indio_dev->available_scan_masks = adxl355_avail_scan_masks;
 
 	ret = adxl355_setup(data);
 	if (ret < 0) {
@@ -575,6 +662,17 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &adxl355_trigger_handler, NULL);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "iio triggered buffer setup failed\n");
+
+	ret = adxl355_probe_trigger(indio_dev);
+	if (ret < 0)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_GPL(adxl355_core_probe);
diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
index e3070ee81..c18521819 100644
--- a/drivers/iio/accel/adxl355_i2c.c
+++ b/drivers/iio/accel/adxl355_i2c.c
@@ -31,7 +31,8 @@ static int adxl355_i2c_probe(struct i2c_client *client)
 		return PTR_ERR(regmap);
 	}
 
-	return adxl355_core_probe(&client->dev, regmap, client->name);
+	return adxl355_core_probe(&client->dev, regmap, client->name,
+				  client->irq);
 }
 
 static const struct i2c_device_id adxl355_i2c_id[] = {
diff --git a/drivers/iio/accel/adxl355_spi.c b/drivers/iio/accel/adxl355_spi.c
index a16bd1407..f9ba153f6 100644
--- a/drivers/iio/accel/adxl355_spi.c
+++ b/drivers/iio/accel/adxl355_spi.c
@@ -34,7 +34,7 @@ static int adxl355_spi_probe(struct spi_device *spi)
 		return PTR_ERR(regmap);
 	}
 
-	return adxl355_core_probe(&spi->dev, regmap, id->name);
+	return adxl355_core_probe(&spi->dev, regmap, id->name, spi->irq);
 }
 
 static const struct spi_device_id adxl355_spi_id[] = {
-- 
2.30.1

