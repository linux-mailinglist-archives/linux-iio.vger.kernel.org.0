Return-Path: <linux-iio+bounces-7472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196FC92BA09
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 14:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F7E2856C7
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3719615A86D;
	Tue,  9 Jul 2024 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="i7nYHylf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571E14884D
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529771; cv=none; b=gx9SQuXt8uUJryk+gHPbQvaMUswisgczltVlLdd+TBYcQeJqB0tAzpJKLAqooDkDnk+lklv5LliyzUFVwVx6iJ/mvMSR8OlI8EyiANuKwGGuM6Ynef7C04iHNQRkrDaXWXSkplGsCDAEZWWxNORSkdS4w0b5Eanftc22PW/zdcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529771; c=relaxed/simple;
	bh=/l1jSMAQBWRWuQ6K9Cn/ylbH4pQzjjEHutp7tUkHm58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWfvbc8nuGFadIk5a/7e8qkddkslvEFw0gXG67IZxiMym6+fCPDtUBij3YAQmXu6PAO6rDgrMSyhD7cUOv1wvP7GMPF42csfiFGiNIMLMlanQg7H7kOc43BVfqvUTLx5/PR+06eVaeCZUklgbi8GS/7iSCjhw+Js6pVjnyM+exs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=i7nYHylf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42579b60af1so36155905e9.2
        for <linux-iio@vger.kernel.org>; Tue, 09 Jul 2024 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1720529767; x=1721134567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlSbPh6oz1zXiiiT13oHhsaRgUKN5AbpUKImglmTorc=;
        b=i7nYHylfwdwrJ1xhF0RnjqFX8CDl5AkGvnj72GV6jAr0BolHp6ijyNv2IT81ouvYIo
         aAQcMIhTJ4By/lQ3oo+OyXHJl6gbUieSN4hv+H2ML57mXeIpAN3y2FKN6NQgsk/rQthA
         uH2W5fam4uqOH2lWsv8qrXXOgdg9OTsjCFzl3GyPBzgJ86pQkOeIIix9uvxH5QvaqQSo
         JlQrsGJJ+PqKoiugRlfBxN/H5cRUdoZooX60BNlPGMG/Ee4rrgia+HQvEowCE5uO/FWM
         45iEKWfUzW5jOk4hFWx+d69rCIjvUfK1ZOmCvX19Scb5VRhan1bl94fC7UO6UZPtGSb7
         wXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720529767; x=1721134567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlSbPh6oz1zXiiiT13oHhsaRgUKN5AbpUKImglmTorc=;
        b=t0O781gstkESQx52Awb6yYfC5SoOeRK0CSxEub7tbbPLCHiKZxrQ+x87xJUEveMOsB
         pzYaJ5YiO5rG7Pg/MfxAo5o1WMboR6GoXOV4pkWFaQ9pUy//W7AC5KTeArybZslBp8wl
         +xzDPrhruz5P4/H9V3YK/5e6mNFNM7U2k5JioO05aR2Uc38ZoqrpAKpEsDQba48xEx8w
         QZKSZAssxIahi/dqcPGjrUOPlUDSu1Q3fDE11V7uonjEBl7SxL4zaUaNbpxQAXw9P8z+
         qOqBOfpS5HBWO/7hwpBxQyQKxSnb11uxTF6SsGzrSRTTQ95CRroYJNdYt9YoX8vqPSWH
         nicg==
X-Gm-Message-State: AOJu0YzQfkSb7Pd6TNc+eu60OrJKRxzxlp4pT7mM5rGa8RJSUp5Qhzzf
	92G9iWu9BLUl6JiaerZJpkqHRB5PqCTgG3txcv17AuGjAnfMtQy6RzYJQgE5Zrk=
X-Google-Smtp-Source: AGHT+IGfoNU1Gadu8fHAd+1ti+0iNriUGr3tMM3FjyiM92qgw6UwBbBokU0Ks3IIyrQBTb0FOFjkFg==
X-Received: by 2002:a5d:6790:0:b0:367:9988:7300 with SMTP id ffacd0b85a97d-367ceacb495mr1357108f8f.45.1720529766535;
        Tue, 09 Jul 2024 05:56:06 -0700 (PDT)
Received: from carbon.local (aztw-29-b2-v4wan-166913-cust1764.vm26.cable.virginm.net. [82.37.38.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e095sm2496757f8f.23.2024.07.09.05.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:56:06 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
To: jic23@cam.ac.uk
Cc: linux-iio@vger.kernel.org,
	Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Subject: [PATCH 2/2] iio: humidity: Add support for ENS21x
Date: Tue,  9 Jul 2024 13:55:35 +0100
Message-Id: <20240709125534.988703-2-jfelmeden@thegoodpenguin.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240709125534.988703-1-jfelmeden@thegoodpenguin.co.uk>
References: <20240709125534.988703-1-jfelmeden@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215.

The ENS21x is a family of high-performance temperature and relative humidity sensors with
accuracies tailored to the needs of specific applications. From high volume consumer to
automotive grade or highest accuracy demands in instrumentation, there is virtually no
application, the ENS21x family cannot address.

Encapsulated in a tiny QFN4 package, the devices feature an I2C interface to communicate
with an external host processor. Moreover, the ENS21x family provides digital, pre-
calibrated outputs (Kelvin and % relative humidity) and works well with ScioSense’s gas
sensor portfolio.

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
---
 drivers/iio/humidity/Kconfig  |  10 +
 drivers/iio/humidity/Makefile |   1 +
 drivers/iio/humidity/ens21x.c | 348 ++++++++++++++++++++++++++++++++++
 3 files changed, 359 insertions(+)
 create mode 100644 drivers/iio/humidity/ens21x.c

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 2de5494e7c22..3b792ef10bde 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -98,6 +98,16 @@ config HTU21
 	  This driver can also be built as a module. If so, the module will
 	  be called htu21.
 
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
 config SI7005
 	tristate "SI7005 relative humidity and temperature sensor"
 	depends on I2C
diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
index f19ff3de97c5..2a90967673c1 100644
--- a/drivers/iio/humidity/Makefile
+++ b/drivers/iio/humidity/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_HTS221_I2C) += hts221_i2c.o
 obj-$(CONFIG_HTS221_SPI) += hts221_spi.o
 
 obj-$(CONFIG_HTU21) += htu21.o
+obj-$(CONFIG_ENS21X) += ens21x.o
 obj-$(CONFIG_SI7005) += si7005.o
 obj-$(CONFIG_SI7020) += si7020.o
 
diff --git a/drivers/iio/humidity/ens21x.c b/drivers/iio/humidity/ens21x.c
new file mode 100644
index 000000000000..62d3e4636dff
--- /dev/null
+++ b/drivers/iio/humidity/ens21x.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+MODULE_LICENSE("GPL v2");
+
-- 
2.39.2


