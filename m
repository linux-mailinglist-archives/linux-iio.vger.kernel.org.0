Return-Path: <linux-iio+bounces-8246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D2A9476F9
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 10:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60513B22202
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 08:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8EB14F9CC;
	Mon,  5 Aug 2024 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="b2Kx8jfg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B87914C5A1
	for <linux-iio@vger.kernel.org>; Mon,  5 Aug 2024 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845580; cv=none; b=FU7FHWBNChnOQveGcxUFzOkmg+3JNlVztyCmQjG3aBakbQRJKHBCLrktb5OJK12CRKIzQsXrW1v1IlDJf7HfEUplHA6MSRETlCdCUjw3YSOvA3dMX1oiKYxof8Ma8JeI9ZNuYO5Mzj9OGbmzClAEhxIdwKzFOCzkWUicGEp44D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845580; c=relaxed/simple;
	bh=1Khf1UDyTtXqMecMd/S+X2KpB0eMBbe3AtVxpeTXNtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WiY602RO/H0owRfR0DUCWyI0pCRIGfafSQhzEqRthuhz5T1bBKQtcpTJs2Ip/k83/2iIRk1oh7ac4aqJ4iEw2QucC+eJYEfRN7ePwezUkrN6mTcz1yfqLP6LMoatNlFuzx0ki9Y0IYhjn+A8/F/rJN+zO0WjQkubnh/CcaiHQvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=b2Kx8jfg; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-52efa9500e0so11913442e87.3
        for <linux-iio@vger.kernel.org>; Mon, 05 Aug 2024 01:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1722845577; x=1723450377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v78hwJU/wG48aw0B9DVAOmxqpaYmoS/29vW4dzbedZc=;
        b=b2Kx8jfgDkpiGtnP8dHTOWHZc4n2dky0UQABJSaEmXUTrDWENjOSrHgujX9cek2i5w
         YE3c+EYAWlQjQq6yFmVLz/lFjyUXTyj95DGQ72toKvuNTsYgOLQWDPYjgRlQYDCr7vae
         hm8s//0B3DiEkbWNLr5v453eprXyF3YUElmgsNfsadmYmS+PS8nU9260SFHE9D0eKXQV
         xOW5mMYi4ezqCcHx7Z5q0xEIVlRnWNzLU0IIEEhFDCHGpXOoU8XUpVc4JlEATzhtL9Id
         o0l2+Au2eM5x8tFX28/lnNbIofGK3UJXctZ5Ayf6pstEwwMBYuaTgcibAA0DHAFfX7wh
         sb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722845577; x=1723450377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v78hwJU/wG48aw0B9DVAOmxqpaYmoS/29vW4dzbedZc=;
        b=K3cZCCVm1SpZbMkoJRg/H5+D2BOuNQS6GyjnY3obSd/c2lT0EPPRP9abUpfCKJB1OU
         Tvdi2UQK2VXEK/ocNzdKPcK0yBaGV+0cjadw10GnDlBdtAnIMWo76McADCKACnbDjdgr
         AElGaSj/76bDRiWeg30SUDCuBJ+G1Ohwh1i0RBxRM5AiNFIiHHAfgdt8nxD2MDMPxbGD
         hxVR/DZaedApTFf8f/mhRiGOzvrOgCTWr6ZxVGO/XFEEsG5YWOH+8np5DsHQ81EFglTn
         1VBABjJqoIggEx/fGPd1IHGT66lritHz1ObtLxMvYDDZh9zFGu0ZKm4MfK6jFXhfj3Oh
         gpPA==
X-Gm-Message-State: AOJu0Yy80AZxDwmNUmTZeCBTme9pLzOy+V/ji57HsXlwaV0A2FYsKKDb
	VSsqUSsONLs7rOAUuOgdz7xufIBectHCY6LM8TYW3RHOLzP0vB9i71an+T+8IQs=
X-Google-Smtp-Source: AGHT+IFzsUWEIKc4vSpNvJMhPzVZjxkOrm8Nem3Jp8LTg9dL+Wx0WJ5puE94crO+XIv3TqVP3iDetw==
X-Received: by 2002:a05:6512:3dab:b0:52c:df9d:7cbe with SMTP id 2adb3069b0e04-530bb39d2dbmr7076160e87.39.1722845576265;
        Mon, 05 Aug 2024 01:12:56 -0700 (PDT)
Received: from carbon.local (catv-86-101-168-118.catv.fixed.vodafone.hu. [86.101.168.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bb88d1d9a3sm1231565a12.26.2024.08.05.01.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:12:55 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Date: Mon, 05 Aug 2024 09:12:53 +0100
Subject: [PATCH v6 2/2] iio: humidity: Add support for ENS210
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-ens21x-v6-2-5bb576ef26a6@thegoodpenguin.co.uk>
References: <20240805-ens21x-v6-0-5bb576ef26a6@thegoodpenguin.co.uk>
In-Reply-To: <20240805-ens21x-v6-0-5bb576ef26a6@thegoodpenguin.co.uk>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722845573; l=11290;
 i=jfelmeden@thegoodpenguin.co.uk; s=20240709; h=from:subject:message-id;
 bh=1Khf1UDyTtXqMecMd/S+X2KpB0eMBbe3AtVxpeTXNtU=;
 b=8tl10uh9XTPHL2grhaw08Nu/s6Cq73Rk3uiMqZN4lxIRD2bOSGSPXufX7Tzek9FnlhwUil3pK
 jdjFcZYIYuiAyTVVq91MVuymm+22zjBQBn35FzykI2+oPmGF9WQC8Pk
X-Developer-Key: i=jfelmeden@thegoodpenguin.co.uk; a=ed25519;
 pk=tePkZ5iJ3ejQ2O3vjhsj7GrLYcyJN1o1sMT3IEXvKo0=

Add support for ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215.

The ENS21x is a family of temperature and relative humidity sensors with
accuracies tailored to the needs of specific applications.

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
---
 drivers/iio/humidity/Kconfig  |  11 ++
 drivers/iio/humidity/Makefile |   1 +
 drivers/iio/humidity/ens210.c | 338 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 350 insertions(+)

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index b15b7a3b66d5..54f11f000b6f 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -25,6 +25,17 @@ config DHT11
 	  Other sensors should work as well as long as they speak the
 	  same protocol.
 
+config ENS210
+	tristate "ENS210 temperature and humidity sensor"
+	depends on I2C
+	select CRC7
+	help
+	  Say yes here to get support for the ScioSense ENS210 family of
+	  humidity and temperature sensors.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ens210.
+
 config HDC100X
 	tristate "TI HDC100x relative humidity and temperature sensor"
 	depends on I2C
diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
index 5fbeef299f61..34b3dc749466 100644
--- a/drivers/iio/humidity/Makefile
+++ b/drivers/iio/humidity/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_AM2315) += am2315.o
 obj-$(CONFIG_DHT11) += dht11.o
+obj-$(CONFIG_ENS210) += ens210.o
 obj-$(CONFIG_HDC100X) += hdc100x.o
 obj-$(CONFIG_HDC2010) += hdc2010.o
 obj-$(CONFIG_HDC3020) += hdc3020.o
diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
new file mode 100644
index 000000000000..719fdac817cf
--- /dev/null
+++ b/drivers/iio/humidity/ens210.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ens210.c - Support for ScioSense ens210 temperature & humidity sensor family
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
+#include <linux/crc7.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include <asm/unaligned.h>
+
+/* register definitions */
+#define ENS210_REG_PART_ID		0x00
+#define ENS210_REG_DIE_REV		0x02
+#define ENS210_REG_UID			0x04
+#define ENS210_REG_SYS_CTRL		0x10
+#define ENS210_REG_SYS_STAT		0x11
+#define ENS210_REG_SENS_RUN		0x21
+#define ENS210_REG_SENS_START		0x22
+#define ENS210_REG_SENS_STOP		0x23
+#define ENS210_REG_SENS_STAT		0x24
+#define ENS210_REG_T_VAL		0x30
+#define ENS210_REG_H_VAL		0x33
+
+/* value definitions */
+#define ENS210_SENS_START_T_START		BIT(0)
+#define ENS210_SENS_START_H_START		BIT(1)
+
+#define ENS210_SENS_STAT_T_ACTIVE		BIT(0)
+#define ENS210_SENS_STAT_H_ACTIVE		BIT(1)
+
+#define ENS210_SYS_CTRL_LOW_POWER_ENABLE	BIT(0)
+#define ENS210_SYS_CTRL_SYS_RESET		BIT(7)
+
+#define ENS210_SYS_STAT_SYS_ACTIVE		BIT(0)
+
+enum ens210_partnumber {
+	ENS210	= 0x0210,
+	ENS210A	= 0xa210,
+	ENS211	= 0x0211,
+	ENS212	= 0x0212,
+	ENS213A	= 0xa213,
+	ENS215	= 0x0215,
+};
+
+/**
+ * struct ens210_chip_info - Humidity/Temperature chip specific information
+ * @name:		name of device
+ * @part_id:		chip identifier
+ * @conv_time_msec:	time for conversion calculation in m/s
+ */
+struct ens210_chip_info {
+	const char *name;
+	enum ens210_partnumber part_id;
+	unsigned int conv_time_msec;
+};
+
+/**
+ * struct ens210_data - Humidity/Temperature sensor device structure
+ * @client:	i2c client
+ * @chip_info:	chip specific information
+ * @lock:	lock protecting against simultaneous callers of get_measurement
+ *		since multiple uninterrupted transactions are required
+ */
+struct ens210_data {
+	struct i2c_client *client;
+	const struct ens210_chip_info *chip_info;
+	struct mutex lock;
+};
+
+/* calculate 17-bit crc7 */
+static u8 ens210_crc7(u32 val)
+{
+	unsigned int val_be = (val & 0x1ffff) >> 0x8;
+
+	return crc7_be(0xde, (u8 *)&val_be, 3) >> 1;
+}
+
+static int ens210_get_measurement(struct iio_dev *indio_dev, bool temp, int *val)
+{
+	struct ens210_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+	u32 regval;
+	u8 regval_le[3];
+	int ret;
+
+	/* assert read */
+	ret = i2c_smbus_write_byte_data(data->client, ENS210_REG_SENS_START,
+					temp ? ENS210_SENS_START_T_START :
+					       ENS210_SENS_START_H_START);
+	if (ret)
+		return ret;
+
+	/* wait for conversion to be ready */
+	msleep(data->chip_info->conv_time_msec);
+
+	ret = i2c_smbus_read_byte_data(data->client, ENS210_REG_SENS_STAT);
+	if (ret < 0)
+		return ret;
+
+	/* perform read */
+	ret = i2c_smbus_read_i2c_block_data(
+		data->client, temp ? ENS210_REG_T_VAL : ENS210_REG_H_VAL, 3,
+		regval_le);
+	if (ret < 0) {
+		dev_err(dev, "failed to read register");
+		return -EIO;
+	}
+	if (ret != 3) {
+		dev_err(dev, "expected 3 bytes, received %d\n", ret);
+		return -EIO;
+	}
+
+	regval = get_unaligned_le24(regval_le);
+	if (ens210_crc7(regval) != ((regval >> 17) & 0x7f)) {
+		dev_err(dev, "invalid crc\n");
+		return -EIO;
+	}
+
+	if (!((regval >> 16) & 0x1)) {
+		dev_err(dev, "data is not valid");
+		return -EIO;
+	}
+
+	*val = regval & GENMASK(15, 0);
+	return IIO_VAL_INT;
+}
+
+static int ens210_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *channel, int *val,
+			   int *val2, long mask)
+{
+	struct ens210_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		scoped_guard(mutex, &data->lock) {
+			ret = ens210_get_measurement(
+				indio_dev, channel->type == IIO_TEMP, val);
+			if (ret)
+				return ret;
+			return IIO_VAL_INT;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		if (channel->type == IIO_TEMP) {
+			*val = 15;
+			*val2 = 625000;
+		} else {
+			*val = 1;
+			*val2 = 953125;
+		}
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = -17481;
+		*val2 = 600000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_chan_spec ens210_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+	},
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	}
+};
+
+static const struct iio_info ens210_info = {
+	.read_raw = ens210_read_raw,
+};
+
+static int ens210_probe(struct i2c_client *client)
+{
+	struct ens210_data *data;
+	struct iio_dev *indio_dev;
+	uint16_t part_id;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
+					     I2C_FUNC_SMBUS_WRITE_BYTE |
+					     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+		return dev_err_probe(&client->dev, -EOPNOTSUPP,
+			"adapter does not support some i2c transactions\n");
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+	data->chip_info = i2c_get_match_data(client);
+
+	ret = devm_regulator_get_enable(&client->dev, "vdd");
+	if (ret)
+		return ret;
+
+	/* reset device */
+	ret = i2c_smbus_write_byte_data(client, ENS210_REG_SYS_CTRL,
+					ENS210_SYS_CTRL_SYS_RESET);
+	if (ret)
+		return ret;
+
+	/* wait for device to become active */
+	usleep_range(4000, 5000);
+
+	/* disable low power mode */
+	ret = i2c_smbus_write_byte_data(client, ENS210_REG_SYS_CTRL, 0x00);
+	if (ret)
+		return ret;
+
+	/* wait for device to finish */
+	usleep_range(4000, 5000);
+
+	/* get part_id */
+	ret = i2c_smbus_read_word_data(client, ENS210_REG_PART_ID);
+	if (ret < 0)
+		return ret;
+	part_id = ret;
+
+	if (part_id != data->chip_info->part_id) {
+		dev_info(&client->dev,
+			 "Part ID does not match (0x%04x != 0x%04x)\n", part_id,
+			 data->chip_info->part_id);
+	}
+
+	/* reenable low power */
+	ret = i2c_smbus_write_byte_data(client, ENS210_REG_SYS_CTRL,
+					ENS210_SYS_CTRL_LOW_POWER_ENABLE);
+	if (ret)
+		return ret;
+
+	indio_dev->name = data->chip_info->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ens210_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ens210_channels);
+	indio_dev->info = &ens210_info;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct ens210_chip_info ens210_chip_info_data = {
+	.name = "ens210",
+	.part_id = ENS210,
+	.conv_time_msec = 130,
+};
+
+static const struct ens210_chip_info ens210a_chip_info_data = {
+	.name = "ens210a",
+	.part_id = ENS210A,
+	.conv_time_msec = 130,
+};
+
+static const struct ens210_chip_info ens211_chip_info_data = {
+	.name = "ens211",
+	.part_id = ENS211,
+	.conv_time_msec = 32,
+};
+
+static const struct ens210_chip_info ens212_chip_info_data = {
+	.name = "ens212",
+	.part_id = ENS212,
+	.conv_time_msec = 32,
+};
+
+static const struct ens210_chip_info ens213a_chip_info_data = {
+	.name = "ens213a",
+	.part_id = ENS213A,
+	.conv_time_msec = 130,
+};
+
+static const struct ens210_chip_info ens215_chip_info_data = {
+	.name = "ens215",
+	.part_id = ENS215,
+	.conv_time_msec = 130,
+};
+
+static const struct of_device_id ens210_of_match[] = {
+	{ .compatible = "sciosense,ens210", .data = &ens210_chip_info_data },
+	{ .compatible = "sciosense,ens210a", .data = &ens210a_chip_info_data },
+	{ .compatible = "sciosense,ens211", .data = &ens211_chip_info_data },
+	{ .compatible = "sciosense,ens212", .data = &ens212_chip_info_data },
+	{ .compatible = "sciosense,ens213a", .data = &ens213a_chip_info_data },
+	{ .compatible = "sciosense,ens215", .data = &ens215_chip_info_data },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ens210_of_match);
+
+static const struct i2c_device_id ens210_id_table[] = {
+	{ "ens210", (kernel_ulong_t)&ens210_chip_info_data },
+	{ "ens210a", (kernel_ulong_t)&ens210a_chip_info_data },
+	{ "ens211", (kernel_ulong_t)&ens211_chip_info_data },
+	{ "ens212", (kernel_ulong_t)&ens212_chip_info_data },
+	{ "ens213a", (kernel_ulong_t)&ens213a_chip_info_data },
+	{ "ens215", (kernel_ulong_t)&ens215_chip_info_data },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ens210_id_table);
+
+static struct i2c_driver ens210_driver = {
+	.probe = ens210_probe,
+	.id_table = ens210_id_table,
+	.driver = {
+		.name = "ens210",
+		.of_match_table = ens210_of_match,
+	},
+};
+module_i2c_driver(ens210_driver);
+
+MODULE_DESCRIPTION("ScioSense ENS210 temperature and humidity sensor driver");
+MODULE_AUTHOR("Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>");
+MODULE_LICENSE("GPL");

-- 
2.39.2


