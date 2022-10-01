Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4E55F1E6A
	for <lists+linux-iio@lfdr.de>; Sat,  1 Oct 2022 19:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiJARdO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Oct 2022 13:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJARc5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2022 13:32:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8053124B
        for <linux-iio@vger.kernel.org>; Sat,  1 Oct 2022 10:32:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dv25so14829651ejb.12
        for <linux-iio@vger.kernel.org>; Sat, 01 Oct 2022 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=wEXE0Rz/fQM7JYCBnYNQfz9czJRuEypdZLlPSpxsy8o=;
        b=t/ukTvhla5Br0rnvgqRIOoBc3/PWv3/Cabt/QjSAOntVKCzfCzqrYAyvltWinXGTpE
         1zMlhVO3a8YSOOv+s29mUEGivcjph6X8g6/RyogoP1/NPhfetbJueCY6plDnBFhvL22P
         So55YURo8cGPS1oS1s04COBjhcZypC0QEDYxFjx1KjNWGnOpAneA9O8wyvTrW9k+osd3
         1ax3LZ/ZzhPXAPuU3aMRCbZdH8TUMIOvwHKA6OkgVjXjkfGk5UHlbcLlL+tFntRCOWPg
         lJv5gFb7enymMKS4PMgIyXioVvdSVFBfu39WK7zMnSRY8zf9TZOKq6pBPIQmDyl8qMpk
         KWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=wEXE0Rz/fQM7JYCBnYNQfz9czJRuEypdZLlPSpxsy8o=;
        b=ytNQYkZiyjaRxDV04992UmXjmfozMvd2VqjY0YhzBM/Yk5x56KEHtWrEYLcWaFQPZQ
         DXD3y4KHBc/PvCu1QC4+2jeOUQzBF/GE1HuMtUACvyMrdgczUhQKoJ6FCoBbU3RpQpZa
         UITgwWqjNv0y918qlu6gUERt6p3Jqb73eG2MCTqFawzbU6OBbNyag83PqGEPwxeHXwIu
         OAEis4SPX0LthH6tEBK/q4kpKsAVI4IJHsdn0ddloFLOENhVUiHD4UGj3At4sHjxjbvP
         0+r25VwMfYpatSjs86vgJLMC+s7IiTSsLO7yuJGdi8OIe43XzzXfgJpVIrYHa+FrobRn
         xyxQ==
X-Gm-Message-State: ACrzQf3lA1MVTOmN/r1iNw4rUlgmGFeSMJuNOVgtOhnXIXv+wOdqN+x7
        BUbHYYB5bBoMjbVtjvgk8bJonw==
X-Google-Smtp-Source: AMsMyM6XDUenRQan+F2vqLKpQpiDdrFOKnJ9g9RIDUY0gh2MDVt73TCcSXjqwswjXBZzleD9cfZFpQ==
X-Received: by 2002:a17:907:6089:b0:783:592a:5d3f with SMTP id ht9-20020a170907608900b00783592a5d3fmr10579321ejc.385.1664645564012;
        Sat, 01 Oct 2022 10:32:44 -0700 (PDT)
Received: from localhost.localdomain ([95.236.236.71])
        by smtp.gmail.com with ESMTPSA id cz7-20020a0564021ca700b0045724875fa2sm3883602edb.15.2022.10.01.10.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 10:32:43 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     a.zummo@towertech.it, william.gray@linaro.org
Cc:     linux-iio@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH] iio: dac: add support for max5522
Date:   Sat,  1 Oct 2022 19:31:04 +0200
Message-Id: <20221001173104.492027-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add initial support for dac max5522.

Tested writing DAC A and B with some values,
from 0 to 1023, measured output voltages, driver works properly.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
 drivers/iio/dac/Kconfig   |   1 +
 drivers/iio/dac/max5522.c | 159 ++++++++++++++++++++------------------
 2 files changed, 86 insertions(+), 74 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 52bb393d043b..91b284342db6 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -360,6 +360,7 @@ config MAX517
 config MAX5522
 	tristate "Maxim MAX5522 DAC driver"
 	depends on SPI
+	select REGMAP_SPI if SPI_MASTER
 	help
 	  Support for the MAX5522 2 channels
 	  Digital to Analog Converters (DAC).
diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
index 5d3dce0e6bb1..3932834cc7b7 100644
--- a/drivers/iio/dac/max5522.c
+++ b/drivers/iio/dac/max5522.c
@@ -3,11 +3,10 @@
  * Maxim MAX5522
  * Dual, Ultra-Low-Power 10-Bit, Voltage-Output DACs
  *
- * Copyright 2022 TImesys (C)
+ * Copyright 2022 Timesys Corp.
  */
 
 #include <linux/device.h>
-#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
@@ -20,7 +19,6 @@
 #include <linux/iio/sysfs.h>
 
 #define MAX5522_MAX_ADDR	15
-
 #define MAX5522_CTRL_NONE	0
 #define MAX5522_CTRL_LOAD_IN_A	9
 #define MAX5522_CTRL_LOAD_IN_B	10
@@ -35,46 +33,33 @@ struct max5522_chip_info {
 struct max5522_state {
 	struct regmap *regmap;
 	const struct max5522_chip_info *chip_info;
-	struct mutex lock;
+	unsigned short dac_cache[2];
+	unsigned int vrefin_mv;
+	struct regulator *vrefin_reg;
 };
 
-const struct iio_chan_spec max5522_channels[] = {
-{
-	.type = IIO_VOLTAGE,
-	.indexed = 1,
-	.output = 1,
-	.channel = 0,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			      BIT(IIO_CHAN_INFO_SCALE),
-	.address = 0,
-	.scan_type = {
-		.sign = 'u',
-		.realbits = 10,
-		.storagebits = 16,
-		.shift = 6,
-	},
-}, {
-	.type = IIO_VOLTAGE,
-	.indexed = 1,
-	.output = 1,
-	.channel = 1,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			      BIT(IIO_CHAN_INFO_SCALE),
-	.address = 1,
-	.scan_type = {
-		.sign = 'u',
-		.realbits = 10,
-		.storagebits = 16,
-		.shift = 6,
-	},
+#define MAX5522_CHANNEL(chan) {	\
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.output = 1, \
+	.channel = chan, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE), \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 10, \
+		.storagebits = 16, \
+		.shift = 2, \
+	} \
 }
+
+const struct iio_chan_spec max5522_channels[] = {
+	MAX5522_CHANNEL(0),
+	MAX5522_CHANNEL(1),
 };
 
 enum max5522_type {
 	ID_MAX5522,
-	ID_MAX5523,
-	ID_MAX5524,
-	ID_MAX5525,
 };
 
 static const struct max5522_chip_info max5522_chip_info_tbl[] = {
@@ -82,43 +67,54 @@ static const struct max5522_chip_info max5522_chip_info_tbl[] = {
 		.channels = max5522_channels,
 		.num_channels = 2,
 	},
-	[ID_MAX5523] = {
-		.channels = max5522_channels,
-		.num_channels = 2,
-	},
-	[ID_MAX5524] = {
-		.channels = max5522_channels,
-		.num_channels = 2,
-	},
-	[ID_MAX5525] = {
-		.channels = max5522_channels,
-		.num_channels = 2,
-	},
 };
 
-static unsigned int max5522_info_to_reg(struct iio_chan_spec const *chan,
-					long info)
+static inline int max5522_info_to_reg(struct iio_chan_spec const *chan)
 {
+	return MAX5522_REG_DATA(chan->channel);
+}
+
+static int max5522_read_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int *val, int *val2, long info)
+{
+	struct max5522_state *state = iio_priv(indio_dev);
+
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		return MAX5522_REG_DATA(chan->address);
+		*val = state->dac_cache[chan->channel];
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = state->vrefin_mv;
+		*val2 = 10;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	default:
-		break;
+		return -EINVAL;
 	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static int max5522_write_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int val, int val2, long info)
 {
-	struct max5522_state *st = iio_priv(indio_dev);
+	struct max5522_state *state = iio_priv(indio_dev);
+	int rval;
 
-	return regmap_write(st->regmap, max5522_info_to_reg(chan, info),
+	if (val > 1023 || val < 0)
+		return -EINVAL;
+
+	rval = regmap_write(state->regmap, max5522_info_to_reg(chan),
 				val << chan->scan_type.shift);
+	if (rval < 0)
+		return rval;
+
+	state->dac_cache[chan->channel] = val;
+
+	return 0;
 }
 
 static const struct iio_info max5522_info = {
+	.read_raw = max5522_read_raw,
 	.write_raw = max5522_write_raw,
 };
 
@@ -131,40 +127,61 @@ static void max5522_remove(struct device *dev)
 }
 
 static const struct regmap_config max5522_regmap_config = {
-
+	.reg_bits = 4,
 	.val_bits = 12,
-
 	.max_register = MAX5522_MAX_ADDR,
-	.cache_type = REGCACHE_RBTREE,
 };
 
 static int max5522_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
-	struct regmap *regmap;
 	struct iio_dev *indio_dev;
-	struct max5522_state *st;
+	struct max5522_state *state;
+	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
 	if (indio_dev == NULL) {
 		dev_err(&spi->dev, "failed to allocate iio device\n");
 		return  -ENOMEM;
 	}
 
-	st = iio_priv(indio_dev);
+	state = iio_priv(indio_dev);
+	state->chip_info = &max5522_chip_info_tbl[id->driver_data];
 
-	st->chip_info = &max5522_chip_info_tbl[id->driver_data];
+	state->vrefin_reg = devm_regulator_get(&spi->dev, "vrefin");
+	if (IS_ERR(state->vrefin_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(state->vrefin_reg),
+				     "Vrefin regulator not specified\n");
+
+	ret = regulator_get_voltage(state->vrefin_reg);
+	if (ret < 0) {
+		dev_err(&spi->dev, "Failed to read vrefin regulator: %d\n",
+				ret);
+		goto error_disable_vrefin_reg;
+	}
+	state->vrefin_mv = ret / 1000;
 
 	spi_set_drvdata(spi, indio_dev);
 
-	regmap = devm_regmap_init_spi(spi, &max5522_regmap_config);
+	state->regmap = devm_regmap_init_spi(spi, &max5522_regmap_config);
 
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	if (IS_ERR(state->regmap))
+		return PTR_ERR(state->regmap);
 
-	dev_err(&spi->dev, "device probed\n");
+	dev_info(&spi->dev, "iio dac ready");
 
-	return 0;
+	indio_dev->info = &max5522_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = max5522_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max5522_channels);
+	indio_dev->name = id->name;
+
+	return iio_device_register(indio_dev);
+
+error_disable_vrefin_reg:
+	regulator_disable(state->vrefin_reg);
+
+	return ret;
 }
 
 static void max5522_spi_remove(struct spi_device *spi)
@@ -174,9 +191,6 @@ static void max5522_spi_remove(struct spi_device *spi)
 
 static const struct spi_device_id max5522_ids[] = {
 	{ "max5522", ID_MAX5522 },
-	{ "max5522", ID_MAX5523 },
-	{ "max5522", ID_MAX5524 },
-	{ "max5525", ID_MAX5525 },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad5360_ids);
@@ -184,9 +198,6 @@ MODULE_DEVICE_TABLE(spi, ad5360_ids);
 
 static const struct of_device_id max5522_of_match[] = {
 	{ .compatible = "maxim,max5522", },
-	{ .compatible = "maxim,max5523", },
-	{ .compatible = "maxim,max5524", },
-	{ .compatible = "maxim,max5525", },
 	{},
 };
 
-- 
2.37.3

