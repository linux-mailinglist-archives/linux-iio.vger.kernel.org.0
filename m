Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9723E40FA
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhHIHpw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 03:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbhHIHpv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 03:45:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E90AC0613CF;
        Mon,  9 Aug 2021 00:45:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a8so26534764pjk.4;
        Mon, 09 Aug 2021 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SrLgkSJMzgJNstGssttga51BfllZQtA+A4n81rJJdYk=;
        b=bt2QYH2bo+Ta8686hD+/L9PL5tWBdaw+0JPkFoW5Xcs0GIqNjHVYjxF7jCTarkseyr
         K9WKNd8mEO5xsbhDucq5aS4rrKEV/egPdFV3egO8kGl1CmXNV7OfaiN0re3nvcFPOcCx
         03mmAhgvLCDAD5LUnIUP+aQ3LwBdL7KiG+P2x80SzYkk8ibqU2iVDBVWMdJHqjMktA8S
         ePI0eiZKzNDeaAvtVdNELlB4l77uGkZrpJhm+qWLhqvAUlKfEw66lFK5883TrF/yBzSi
         dm0qFElVyKz9AzwFkjEWVC5J2NWTvuL2jr3LjPHgNrmB434xmxEd0w87oMr1D4zglPGp
         5WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SrLgkSJMzgJNstGssttga51BfllZQtA+A4n81rJJdYk=;
        b=QO24tqPVH3cmO+Ts50wgmmaD4V7glwhbFo2u1k0a4Ar22i2f/MC3qCX7mZiYyhdiZj
         NtW1sRtwliAQfCalj8fLgRmdQhqzx//uiWE6tPRA/vekdXDOWzoYdqGZuuSZInzl3xlD
         S6I+T7dk0wTmRvlZGgk10R2F/qJdM/I61qGC0RIR2KQt9aNs3Mqeh67WjZIgrRufLeES
         fGVY3/MrPSyNhDKVZcFESMh1TamqmnMCTZO+n5BWYH5q9h13RpcNOOfRc3sjXm++qU5G
         hViMLqjKyATTUpR+saDWVdZ4dngTxV1aPisuYH4NXv+AZDhEmd6MHpuI7FuKbEtXZEUl
         b3tw==
X-Gm-Message-State: AOAM532TilL8LHuCRJcJSTD2ofmiLBmfhTpDdzWvHzzTLjc7gqRQBVrT
        zAetP7GrhItMOcL20be60So=
X-Google-Smtp-Source: ABdhPJz1MdG3dMJgJY5Wf3BRU5Up00cijzh9YQEitGKAFx+YcWr19cbmdBm6L47QZOLxsx4MqAD+Tw==
X-Received: by 2002:a63:f54:: with SMTP id 20mr261208pgp.106.1628495130171;
        Mon, 09 Aug 2021 00:45:30 -0700 (PDT)
Received: from localhost.localdomain ([27.255.251.44])
        by smtp.googlemail.com with ESMTPSA id h16sm18602524pfn.215.2021.08.09.00.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 00:45:29 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v9 2/2] iio: accel: adxl355: Add triggered buffer support
Date:   Mon,  9 Aug 2021 13:15:12 +0530
Message-Id: <20210809074512.34757-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210809074512.34757-1-puranjay12@gmail.com>
References: <20210809074512.34757-1-puranjay12@gmail.com>
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
index d1163cde1..45397dcce 100644
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
@@ -153,6 +157,7 @@ static const struct adxl355_chan_info adxl355_chans[] = {
 };
 
 struct adxl355_data {
+	int irq;
 	struct regmap *regmap;
 	struct device *dev;
 	struct mutex lock; /* lock to protect op_mode */
@@ -162,6 +167,12 @@ struct adxl355_data {
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
@@ -493,12 +504,46 @@ static int adxl355_read_avail(struct iio_dev *indio_dev,
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
@@ -512,6 +557,7 @@ static const struct iio_info adxl355_info = {
 	.info_mask_shared_by_type_available =				\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
 		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
+	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
 		.realbits = 20,						\
@@ -531,17 +577,56 @@ static const struct iio_chan_spec adxl355_channels[] = {
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
@@ -554,6 +639,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 	data = iio_priv(indio_dev);
 	data->regmap = regmap;
 	data->dev = dev;
+	data->irq = irq;
 	data->op_mode = ADXL355_STANDBY;
 	mutex_init(&data->lock);
 
@@ -562,6 +648,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl355_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl355_channels);
+	indio_dev->available_scan_masks = adxl355_avail_scan_masks;
 
 	ret = adxl355_setup(data);
 	if (ret < 0) {
@@ -569,6 +656,17 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
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

