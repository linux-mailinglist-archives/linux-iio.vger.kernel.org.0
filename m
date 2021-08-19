Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFBF3F1FA3
	for <lists+linux-iio@lfdr.de>; Thu, 19 Aug 2021 20:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhHSSMb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Aug 2021 14:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhHSSMV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Aug 2021 14:12:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B693DC061756;
        Thu, 19 Aug 2021 11:11:44 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o10so4454077plg.0;
        Thu, 19 Aug 2021 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xI7rSnOguYkd6xzMlrJnuStjAaAVVRIcPQVFzkRh8no=;
        b=eGhM94gKi9D2d+j6+BFoq2vBCuj9LR/JiKRIgP4bX7upetlNR3OOTw83yjjzaTUYb2
         KEtkL+EAbXKhKswSaYlgGGX2EwbL7twfVdN4zqeX1uZ/RBLNxj7eV3v2j7BmgWmbkaz7
         GHOtfaHZ59MIOn7LlPocXDzMjX1eaJRWiJYlTjdR+VLLKhh8eD1Toor7MiOPLIx7xX7f
         Z7/q23W5VXvllptpzzb4Y0f/zDO7r+QVjcu8oy2oql7sob6TYCq6kuDS40XtCfcZ5ORz
         r1g37USCNQWLDEVrlOXj4Az9Y1FHe3XBQ9B71+mfwYjUmEC8/H3SRh+hUc6tDKiQ2OA2
         KFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xI7rSnOguYkd6xzMlrJnuStjAaAVVRIcPQVFzkRh8no=;
        b=boaEWeRxcmVzd+L95bh5UnKAh2tCqtkA89diBgnPv3e0i8M+iLfOM8aXoONFyGR7SN
         yA6WfYybldL3JdSsYPSqdrxbM0fpXgeb6gXsjE4PUmdjTMuX6Q9aoQyzwqWRk0hPo9HW
         DNJdIdLQl1MMUoriA7eEymwLrFeyDVTmo+/QYoFuQyJ8uQ9Tvei4KntNtw8MYEJcg9O2
         1N/0tQMvurYuZ81VNCBEry0ULh9sCeRTJmUWWTlRI1wdYd0Wg3JJiA7ePrR+KWpvWsEq
         WqGsncv7hJGM3xz4tm1HrTzTH6O/l41qZYcv42IWerOxmUPnOim0QPRzwYVjoglEoHNL
         whHQ==
X-Gm-Message-State: AOAM532m2w/8FWJoeWExAtlt9x3he4VWCtJ5z5Lo8aCaoxoWkoWVCOeq
        X39Ss1NLUV8zHCAOetMeThy8wNKq9g0JeqWa
X-Google-Smtp-Source: ABdhPJxxpedvq/DIZ8u6iBG2cQwP+z6yNOktU9Scx/K5uNdN+sw4l7MK3m7YX4xvw5fYwpIQy/mJVw==
X-Received: by 2002:a17:903:4055:b0:12e:ce88:e896 with SMTP id n21-20020a170903405500b0012ece88e896mr9410201pla.21.1629396704152;
        Thu, 19 Aug 2021 11:11:44 -0700 (PDT)
Received: from localhost.localdomain ([124.253.6.166])
        by smtp.googlemail.com with ESMTPSA id t5sm4314669pfd.133.2021.08.19.11.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 11:11:43 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     jic23@kernel.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com, andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v2] iio: accel: adxl355: Add triggered buffer support
Date:   Thu, 19 Aug 2021 23:41:33 +0530
Message-Id: <20210819181133.15181-1-puranjay12@gmail.com>
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
Changes since v1:
- Fix an indentation issue.
- Add comments on layout of data in buffer.
- Zero the buffer before using it in trigger handler.
- Use if(ret) in place of if(ret < 0)
---
drivers/iio/accel/Kconfig        |   4 +
 drivers/iio/accel/adxl355_core.c | 162 ++++++++++++++++++++++++++++++-
 2 files changed, 164 insertions(+), 2 deletions(-)

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
index c91d2254c..d499403dc 100644
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
 
@@ -165,7 +171,15 @@ struct adxl355_data {
 	enum adxl355_hpf_3db hpf_3db;
 	int calibbias[3];
 	int adxl355_hpf_3db_table[7][2];
-	u8 transf_buf[3] ____cacheline_aligned;
+	struct iio_trigger *dready_trig;
+	int irq;
+	union {
+		u8 transf_buf[3];
+		struct {
+			u8 buf[14];
+			s64 ts;
+		} buffer;
+	} ____cacheline_aligned;
 };
 
 static int adxl355_set_op_mode(struct adxl355_data *data,
@@ -186,6 +200,23 @@ static int adxl355_set_op_mode(struct adxl355_data *data,
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
@@ -246,6 +277,12 @@ static int adxl355_setup(struct adxl355_data *data)
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
@@ -499,12 +536,74 @@ static int adxl355_read_avail(struct iio_dev *indio_dev,
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
+	 * The accelaration data is 24 bits and big endian. It has to be saved
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
@@ -518,6 +617,7 @@ static const struct iio_info adxl355_info = {
 	.info_mask_shared_by_type_available =				\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
 		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
+	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
 		.realbits = 20,						\
@@ -537,6 +637,7 @@ static const struct iio_chan_spec adxl355_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = 3,
 		.scan_type = {
 			.sign = 's',
 			.realbits = 12,
@@ -544,8 +645,46 @@ static const struct iio_chan_spec adxl355_channels[] = {
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
+	if (ret)
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
@@ -563,18 +702,37 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 	data->op_mode = ADXL355_STANDBY;
 	mutex_init(&data->lock);
 
+	/*
+	 * TODO: Would be good to move it to the generic version.
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

