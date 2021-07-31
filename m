Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AA03DC8C3
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 00:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhGaWvU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 18:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhGaWvR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Jul 2021 18:51:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D7EC0613D5;
        Sat, 31 Jul 2021 15:51:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so8901697pjb.2;
        Sat, 31 Jul 2021 15:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+oxhLW/JAeUr8T6pG8sP91Z111DWd3TJdv6xrLbTH7o=;
        b=AVL9sng0SrOVPr0ecOpe8MXE7oF7gzO2XEeqLZirveu95khdif/X3JY//3+Wopeq3T
         LGI3dw8nCqC2mrRdWOIGAcSdcjUuFIapQz0HPD3+cTYZgMbbqnVZNkidufgUAaMnL9HT
         yYDvNCvsFvKVEqQXC1rB3zpPtxG/jfqodoj91/j6LOir6GEjoWoaxMfaNjvOMQnWq+6m
         yDUBdzQyzGTosVSr6UtQefxB0JNhGVsSJzLC0mQplczR61BMkulpPD/LITxiTXq4EX9C
         XxEU/ySz6828kv3vaRBVM8H79CjpXCltM6hyQ5VH37whPzhcr52GnV5xgSBa0JCkQAQG
         VmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+oxhLW/JAeUr8T6pG8sP91Z111DWd3TJdv6xrLbTH7o=;
        b=XiRWq76a3l3Gw4mVJo6osLfszh5LwQKHxG55riBOT4Yio9CVtjJr1Z6pWBXlDRdujd
         v7XlDhQTrsZBcCotERs/KRTyu8gM7R8wnfaLsxjZWarXk2Hw/8iMiwMnZ4otIQOaNH33
         CZfaPlbDxbVyb3mJ/hSYXiQEZ4gXRcFIXsBXrjixE69N9J/zkdmCB6TuQcEHBiJq1GC/
         AhiMNT6lhN0oWvGF5ASFoq8nWYzT8UpixTozzNFOF7KTarvfSEx5HHA45ktqcZX7JW/S
         gn6Mg96a+XsEB7k7gNPvz9EBFIQln/LlIB6fq8MJj1sbvOdIhX+LZKVc0pxXrTls2TQ7
         /2bg==
X-Gm-Message-State: AOAM530g4aosZBHriZDX9P05kWT0vwQiaaxzx7wl2OYE+KtJQZ55bAhY
        ycujBOs3s0Ps0Dc832Szug4=
X-Google-Smtp-Source: ABdhPJxTPlR7eg1CM11kTxq6x8s810BUvyjkf2nypP8A4sRrN07/j9GAQlkHd7WrBbq4bol9nk7gyA==
X-Received: by 2002:a17:902:da8a:b029:12c:4261:a2d6 with SMTP id j10-20020a170902da8ab029012c4261a2d6mr8113679plx.50.1627771867488;
        Sat, 31 Jul 2021 15:51:07 -0700 (PDT)
Received: from localhost.localdomain ([125.62.118.205])
        by smtp.googlemail.com with ESMTPSA id 20sm6980578pfi.170.2021.07.31.15.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 15:51:07 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v7 3/3] iio: accel: adxl355: Add triggered buffer support
Date:   Sun,  1 Aug 2021 04:20:45 +0530
Message-Id: <20210731225045.399445-4-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210731225045.399445-1-puranjay12@gmail.com>
References: <20210731225045.399445-1-puranjay12@gmail.com>
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
 drivers/iio/accel/adxl355.h      |   2 +-
 drivers/iio/accel/adxl355_core.c | 102 ++++++++++++++++++++++++++++++-
 drivers/iio/accel/adxl355_i2c.c  |   3 +-
 drivers/iio/accel/adxl355_spi.c  |   2 +-
 4 files changed, 104 insertions(+), 5 deletions(-)

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

