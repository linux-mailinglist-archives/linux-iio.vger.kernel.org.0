Return-Path: <linux-iio+bounces-7478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5958692C1B3
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 19:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8B928A95A
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 17:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7066B1B6A74;
	Tue,  9 Jul 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="a9/U/66w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8B11B6A46
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542981; cv=none; b=O8xuMZsvf9CuRYG0Q4OfaJLDKNMRNL9wvydoeLbwicQMlrgZ/OTKYX4K/hKvV79wNQWF4RiDxrsOVSeTQVYAYyA9o+DhBfD4N6RofVqd15OiIFR1wlfpWcDnBGAvrC3e4LQOU2Xum4y0qY5OR1KOroK+jMCs4CRtUi8mOljmvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542981; c=relaxed/simple;
	bh=2HqOWqgH9CA461Wb/q+FwVD2F6sn+9Zwyy1avKg4/UE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kAUEs/Dvu3n3m5knVg1QLf2XjEhsQkYbzG9cHMxCoenV96/36xWAONdZCtFGwxkf7zjJiCIcltKXzjudC+i4w1Q9+qxxkG+5KKG39zuqWEMF+zYMuL/yyX5u6LX8chNqakUcbjcEtZtmmA+emDFbUidHNI8njkgoxvv5Eq9r2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=a9/U/66w; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so32900165e9.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Jul 2024 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1720542977; x=1721147777; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QM3Enk0FHhXowGleK7U87eB/XrmKhSbEWz776aA1QZ0=;
        b=a9/U/66wPgcEyNN2Jb5H9NSx/uZKeZ5AQRMsKWq8s4SmBUbh4F8ifVpt+U31SkZG9r
         3bC5WxLTgYAvgTfMe/KbaxP0x6cZrLd7Ye/g0lP5ch+5fpYM9TQ43czAATwns62V1tcl
         xz77gHPbEdMD0xdPvGYX4rVUrnxYqbwtz5VtiE4At6xOHiai2WBBA/d2KhUuExAQB7+2
         kb56Bk+XQDozMdt2PnfxfjsJJi/8t99WlNmQ05beM07elaB62t9+TkngATaIuFCsK7eH
         O7Le8+P5Wf3KxD3AuNjclQhkGetJ/xPf2AeZxZZUtg0U4Re/bSzjEGtZ61sngKqi5++H
         NNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720542977; x=1721147777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QM3Enk0FHhXowGleK7U87eB/XrmKhSbEWz776aA1QZ0=;
        b=CRgh9PbWT+AssCopb4J8zKserj/6cLgWEOUQYt6BOo9JkJJBCXRx21QvXbaGGV+xfm
         eUt463D/sC7IRFE5aG6EoNUeFHV4sCp3yUmC6tOzSIH3HScNBbKeJ0uA7tu3aKCLx5tq
         mg39Jfz78+X+JF1CGmlkpPBteb1osZnDf17qfWeH0FHGrXPENOZJB8seku3vU9di5QZc
         g1Qc8A1dRBLOK0TGmBrtX5miqDwL8JMh8xDqx34VWw+BlKlmhUYu1YB98IjCFJgSgsNw
         S59nlaAqLfaKv7Isc2NWgCB1bp31LtmOu8pJcImskkzLsFDY2pfjCE+O1qrRLNWlf2ut
         3WFQ==
X-Gm-Message-State: AOJu0YzVZDp2gxch4iMNAxeKwuwBsvX+uW1DgtVUHS9ws7rjkvhEYS7f
	FEuLVJZU9sZMJtz8Eyrkw9bjNHZU8m4rpndHvR6fFq9HVGkwFiBALhdOEUpPqNk=
X-Google-Smtp-Source: AGHT+IHIr1JsOfgrePKcKdO642DX9W8GroKeUgsJijfsmZPJeZfxHsOCb5W0MFb87HAXAKGH+GFTfw==
X-Received: by 2002:a05:600c:2d03:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-426722e3ee4mr22790015e9.11.1720542977164;
        Tue, 09 Jul 2024 09:36:17 -0700 (PDT)
Received: from carbon.local (aztw-29-b2-v4wan-166913-cust1764.vm26.cable.virginm.net. [82.37.38.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f5f25sm48897745e9.26.2024.07.09.09.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 09:36:16 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Date: Tue, 09 Jul 2024 17:36:11 +0100
Subject: [PATCH 2/2] iio: humidity: Add support for ENS21x
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-ens21x-v1-2-678521433cdd@thegoodpenguin.co.uk>
References: <20240709-ens21x-v1-0-678521433cdd@thegoodpenguin.co.uk>
In-Reply-To: <20240709-ens21x-v1-0-678521433cdd@thegoodpenguin.co.uk>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720542974; l=11546;
 i=jfelmeden@thegoodpenguin.co.uk; s=20240709; h=from:subject:message-id;
 bh=2HqOWqgH9CA461Wb/q+FwVD2F6sn+9Zwyy1avKg4/UE=;
 b=cFYkSSYDpflQ/sMbAgmeInW6T3QAWWhxm5LW9TgOONDTFelmcX82nSmW+rpoo0osfttP2PhWO
 ID7/h+G9UmXD93hYu37kpBqFmjRhL1k6KWCRPFxN/EdWPNGQqpYQnVN
X-Developer-Key: i=jfelmeden@thegoodpenguin.co.uk; a=ed25519;
 pk=tePkZ5iJ3ejQ2O3vjhsj7GrLYcyJN1o1sMT3IEXvKo0=

Add support for ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215.

The ENS21x is a family of temperature and relative humidity sensors with
accuracies tailored to the needs of specific applications.

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
---
 drivers/iio/humidity/Kconfig  |  11 ++
 drivers/iio/humidity/Makefile |   1 +
 drivers/iio/humidity/ens21x.c | 348 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 360 insertions(+)

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index b15b7a3b66d5..ff62abf730d1 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -25,6 +25,17 @@ config DHT11
 	  Other sensors should work as well as long as they speak the
 	  same protocol.
 
+config ENS21X
+	tristate "ENS21X temperature and humidity sensor"
+	depends on I2C
+	help
+	  Say yes here to get support for the ScioSense ENS21X family of
+	  humidity and temperature sensors.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ens21x.
+
+
 config HDC100X
 	tristate "TI HDC100x relative humidity and temperature sensor"
 	depends on I2C
diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
index 5fbeef299f61..26590d06d11f 100644
--- a/drivers/iio/humidity/Makefile
+++ b/drivers/iio/humidity/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_AM2315) += am2315.o
 obj-$(CONFIG_DHT11) += dht11.o
+obj-$(CONFIG_ENS21X) += ens21x.o
 obj-$(CONFIG_HDC100X) += hdc100x.o
 obj-$(CONFIG_HDC2010) += hdc2010.o
 obj-$(CONFIG_HDC3020) += hdc3020.o
diff --git a/drivers/iio/humidity/ens21x.c b/drivers/iio/humidity/ens21x.c
new file mode 100644
index 000000000000..4145bb117c65
--- /dev/null
+++ b/drivers/iio/humidity/ens21x.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ens21x.c - Support for ScioSense ens21x
+ *           temperature & humidity sensor
+ *
+ * (7-bit I2C slave address 0x43 ENS210)
+ * (7-bit I2C slave address 0x43 ENS210A)
+ * (7-bit I2C slave address 0x44 ENS211)
+ * (7-bit I2C slave address 0x45 ENS212)
+ * (7-bit I2C slave address 0x46 ENS213A)
+ * (7-bit I2C slave address 0x47 ENS215)
+ *
+ * Datasheet:
+ *  https://www.sciosense.com/wp-content/uploads/2024/04/ENS21x-Datasheet.pdf
+ *  https://www.sciosense.com/wp-content/uploads/2023/12/ENS210-Datasheet.pdf
+ */
+
+#include <linux/types.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/crc7.h>
+
+/* register definitions */
+#define ENS21X_REG_PART_ID		0x00
+#define ENS21X_REG_DIE_REV		0x02
+#define ENS21X_REG_UID			0x04
+#define ENS21X_REG_SYS_CTRL		0x10
+#define ENS21X_REG_SYS_STAT		0x11
+#define ENS21X_REG_SENS_RUN		0x21
+#define ENS21X_REG_SENS_START		0x22
+#define ENS21X_REG_SENS_STOP		0x23
+#define ENS21X_REG_SENS_STAT		0x24
+#define ENS21X_REG_T_VAL		0x30
+#define ENS21X_REG_H_VAL		0x33
+
+/* value definitions */
+#define ENS21X_SENS_START_T_START		BIT(0)
+#define ENS21X_SENS_START_H_START		BIT(1)
+
+#define ENS21X_SENS_STAT_T_ACTIVE		BIT(0)
+#define ENS21X_SENS_STAT_H_ACTIVE		BIT(1)
+
+#define ENS21X_SYS_CTRL_LOW_POWER_ENABLE	BIT(0)
+#define ENS21X_SYS_CTRL_SYS_RESET		BIT(7)
+
+#define ENS21X_SYS_STAT_SYS_ACTIVE		BIT(0)
+
+/* magic constants */
+#define ENS21X_CONST_TEMP_SCALE_INT 15 /* integer part of temperature scale (1/64) */
+#define ENS21X_CONST_TEMP_SCALE_DEC 625000 /* decimal part of temperature scale */
+#define ENS21X_CONST_HUM_SCALE_INT 1 /* integer part of humidity scale (1/512) */
+#define ENS21X_CONST_HUM_SCALE_DEC 953125 /* decimal part of humidity scale */
+#define ENS21X_CONST_TEMP_OFFSET_INT -17481 /* temperature offset (64 * -273.15) */
+#define ENS21X_CONST_TEMP_OFFSET_DEC 600000 /* decimal part of offset */
+#define ENS210_CONST_CONVERSION_TIME 130
+#define ENS212_CONST_CONVERSION_TIME 32
+#define ENS215_CONST_CONVERSION_TIME 132
+
+static const struct of_device_id ens21x_of_match[];
+
+struct ens21x_dev {
+	struct i2c_client *client;
+	struct mutex lock;
+	int part_id;
+};
+
+enum ens21x_partnumber {
+	ENS210	= 0x0210,
+	ENS210A	= 0xa210,
+	ENS211	= 0x0211,
+	ENS212	= 0x0212,
+	ENS213A	= 0xa213,
+	ENS215	= 0x0215,
+};
+
+/* calculate 17-bit crc7 */
+static u8 ens21x_crc7(u32 val)
+{
+	u32 val_be = (htonl(val & 0x1ffff) >> 0x8);
+
+	return crc7_be(0xde, (u8 *)&val_be, 3) >> 1;
+}
+
+static int ens21x_get_measurement(struct iio_dev *indio_dev, bool temp, int *val)
+{
+	u32 regval, regval_le;
+	int ret, tries;
+	struct ens21x_dev *dev_data = iio_priv(indio_dev);
+
+	/* assert read */
+	i2c_smbus_write_byte_data(dev_data->client, ENS21X_REG_SENS_START,
+				  temp ? ENS21X_SENS_START_T_START :
+					 ENS21X_SENS_START_H_START);
+
+	/* wait for conversion to be ready */
+	switch (dev_data->part_id) {
+	case ENS210:
+	case ENS210A:
+		msleep(ENS210_CONST_CONVERSION_TIME);
+		break;
+	case ENS211:
+	case ENS212:
+		msleep(ENS212_CONST_CONVERSION_TIME);
+		break;
+	case ENS213A:
+	case ENS215:
+		msleep(ENS215_CONST_CONVERSION_TIME);
+		break;
+	default:
+		dev_err(&dev_data->client->dev, "unrecognised device");
+		return -ENODEV;
+	}
+
+	tries = 10;
+	while (tries-- > 0) {
+		usleep_range(4000, 5000);
+		ret = i2c_smbus_read_byte_data(dev_data->client,
+					       ENS21X_REG_SENS_STAT);
+		if (ret < 0)
+			continue;
+		if (!(ret & (temp ? ENS21X_SENS_STAT_T_ACTIVE :
+				    ENS21X_SENS_STAT_H_ACTIVE)))
+			break;
+	}
+	if (tries < 0) {
+		dev_err(&indio_dev->dev, "timeout waiting for sensor reading\n");
+		return -EIO;
+	}
+
+	/* perform read */
+	ret = i2c_smbus_read_i2c_block_data(
+		dev_data->client, temp ? ENS21X_REG_T_VAL : ENS21X_REG_H_VAL, 3,
+		(u8 *)&regval_le);
+	if (ret < 0) {
+		dev_err(&dev_data->client->dev, "failed to read register");
+		return -EIO;
+	} else if (ret == 3) {
+		regval = le32_to_cpu(regval_le);
+		if (ens21x_crc7(regval) == ((regval >> 17) & 0x7f)) {
+			*val = regval & 0xffff;
+			return IIO_VAL_INT;
+		}
+		/* crc fail */
+		dev_err(&indio_dev->dev, "ens invalid crc\n");
+		return -EIO;
+	}
+
+	dev_err(&indio_dev->dev, "expected 3 bytes, received %d\n", ret);
+	return -EIO;
+}
+
+static int ens21x_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *channel, int *val,
+			   int *val2, long mask)
+{
+	struct ens21x_dev *dev_data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&dev_data->lock);
+		ret = ens21x_get_measurement(
+			indio_dev, channel->type == IIO_TEMP, val);
+		mutex_unlock(&dev_data->lock);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		if (channel->type == IIO_TEMP) {
+			*val = ENS21X_CONST_TEMP_SCALE_INT;
+			*val2 = ENS21X_CONST_TEMP_SCALE_DEC;
+		} else {
+			*val = ENS21X_CONST_HUM_SCALE_INT;
+			*val2 = ENS21X_CONST_HUM_SCALE_DEC;
+		}
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		if (channel->type == IIO_TEMP) {
+			*val = ENS21X_CONST_TEMP_OFFSET_INT;
+			*val2 = ENS21X_CONST_TEMP_OFFSET_DEC;
+			ret = IIO_VAL_INT_PLUS_MICRO;
+			break;
+		}
+		*val = 0;
+		ret =  IIO_VAL_INT;
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static const struct iio_chan_spec ens21x_channels[] = {
+	/* Temperature channel */
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+	},
+	/* Humidity channel */
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+	}
+};
+
+static const struct iio_info ens21x_info = {
+	.read_raw = ens21x_read_raw,
+};
+
+static const struct i2c_device_id ens21x_id[] = {
+	{"ens210", ENS210},
+	{"ens210a", ENS210A},
+	{"ens211", ENS211},
+	{"ens212", ENS212},
+	{"ens213a", ENS213A},
+	{"ens215", ENS215},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ens21x_id);
+
+static int ens21x_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct of_device_id *match;
+	struct ens21x_dev *dev_data;
+	struct iio_dev *indio_dev;
+	uint16_t part_id_le, part_id;
+	int ret, tries;
+
+	if (!i2c_check_functionality(client->adapter,
+			I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
+			I2C_FUNC_SMBUS_WRITE_BYTE |
+			I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+		dev_err(&client->dev,
+			"adapter does not support some i2c transactions\n");
+		return -EOPNOTSUPP;
+	}
+
+	match = of_match_device(ens21x_of_match, &client->dev);
+	if (!match) {
+		dev_err(&client->dev, "failed to get match data\n");
+		return -ENODEV;
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	dev_data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	dev_data->client = client;
+	mutex_init(&dev_data->lock);
+
+	/* reset device */
+	ret = i2c_smbus_write_byte_data(client, ENS21X_REG_SYS_CTRL,
+					ENS21X_SYS_CTRL_SYS_RESET);
+	if (ret)
+		return ret;
+
+	/* wait for device to become active */
+	usleep_range(4000, 5000);
+
+	/* disable low power mode */
+	ret = i2c_smbus_write_byte_data(client, ENS21X_REG_SYS_CTRL, 0x00);
+	if (ret)
+		return ret;
+
+	/* wait for device to become active */
+	tries = 10;
+	while (tries-- > 0) {
+		msleep(20);
+		ret = i2c_smbus_read_byte_data(client, ENS21X_REG_SYS_STAT);
+		if (ret < 0)
+			return ret;
+		if (ret & ENS21X_SYS_STAT_SYS_ACTIVE)
+			break;
+	}
+	if (tries < 0) {
+		dev_err(&client->dev,
+			"timeout waiting for ens21x to become active\n");
+		return -EIO;
+	}
+
+	/* get part_id */
+	part_id_le = i2c_smbus_read_word_data(client, ENS21X_REG_PART_ID);
+	if (part_id_le < 0)
+		return part_id_le;
+	part_id = le16_to_cpu(part_id_le);
+
+	if (part_id != id->driver_data) {
+		dev_err(&client->dev,
+			"Part ID does not match (0x%04x != 0x%04lx)\n", part_id,
+			id->driver_data);
+		return -ENODEV;
+	}
+
+	/* reenable low power */
+	ret = i2c_smbus_write_byte_data(client, ENS21X_REG_SYS_CTRL,
+					ENS21X_SYS_CTRL_LOW_POWER_ENABLE);
+	if (ret)
+		return ret;
+
+	dev_data->part_id = part_id;
+
+	indio_dev->name = id->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ens21x_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ens21x_channels);
+	indio_dev->info = &ens21x_info;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+
+static const struct of_device_id ens21x_of_match[] = {
+	{ .compatible = "sciosense,ens210" },
+	{ .compatible = "sciosense,ens210a" },
+	{ .compatible = "sciosense,ens211" },
+	{ .compatible = "sciosense,ens212" },
+	{ .compatible = "sciosense,ens213a" },
+	{ .compatible = "sciosense,ens215" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ens21x_of_match);
+
+static struct i2c_driver ens21x_driver = {
+	.probe = ens21x_probe,
+	.id_table = ens21x_id,
+	.driver = {
+		.name = "ens21x",
+		.of_match_table = ens21x_of_match,
+	},
+};
+
+module_i2c_driver(ens21x_driver);
+
+MODULE_DESCRIPTION("ScioSense ENS21x temperature and humidity sensor driver");
+MODULE_AUTHOR("Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>");
+MODULE_LICENSE("GPL");
+

-- 
2.39.2


