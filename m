Return-Path: <linux-iio+bounces-7791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC249392E1
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 18:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CEA2829B8
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 16:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF51E16F292;
	Mon, 22 Jul 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="NR6GOOaa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC6E16F0D0
	for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667534; cv=none; b=MK2WOYI2O+Zm5gb2ZT4fln9GmbnvVD2RBhJjvODWh1XRWVvE/H4aYdF1GoxjGNszct3ciX1OeH0X1cc5dvwEgqU4GokupgK9dUub8GR0x1wK2WnKQPo32zTPNxPyAKIYvk58aHxMrshSZO4gTwa7TtO0hFi5a0HTG0ES5tKxr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667534; c=relaxed/simple;
	bh=mqWrU3scnTZMpLJqnWzO2uIY68DKBT3JCJ/LsOnwo4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phI7yk75fGILps33QAplYW3lYPzIfB0+BoSS2LtY61OveNYr8sekACHScpe7cBBpiCGyL/SSQeKlBZgSddZxphUR+MCL/TGLzYbvQpq3mDSU3tqfafpPCnZ2GGsCKXiF5J3ZkPtXhnR9b5ZdqGcif7au4DDcFcnWTrCb82maz3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=NR6GOOaa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266eda81c5so39418385e9.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 09:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1721667531; x=1722272331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVT0gOf+NtOjihQ2nIWu7Ft9BgKRkrwt18aNIThkUj8=;
        b=NR6GOOaa7lbA3BJPtCJU2QSyjWN3Wd3h3lFg8z2zsd+VhtvzhoTGCCFbXfEv8Gfd++
         F/DlZkLwNOSbEO2oXvBV6TJ8j/05u4k30oyfiXSPWFqF710n1YOMGYPYTyS7c826oSWf
         5mYvXimkr70UIQhif38op2n24zjn9ijQgAdnAJ0gxqmjCOSlvQN+V0wAuFNupKrPx2/B
         TSG9UEoojda5SGVDvWL8TjyqGSipyHLLr2LNFVgFzcmJ54ROq2aooiEdqZSgoeutWL5E
         1TQc13eC2p2+0oA+rPpBWG2cn1yAN9OIpDwatddvM0TD3g7VGk5AotsNSlweYCXB7HcF
         Rblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721667531; x=1722272331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVT0gOf+NtOjihQ2nIWu7Ft9BgKRkrwt18aNIThkUj8=;
        b=Mg+4XJvMbryfAip/rMF/MNYdfziYs73npHAPJ7lGT5mp8qPJSYEgJVKPzhQZnice/d
         FDkgmCaFXLcRl5cBXcou7/E7UCiSb2469jGUFUD84EgHmkBzqwCj9VEJNTl8omicblll
         sRQptzrG2Qr/gVwzItJykXQaHuXq/BVh6Zh4sXBK2aBoRIL0R3G2+51NerDhOpFjLawH
         WGjCfzUV3VyEO6XoUgQId+T9XijoDLTzkgmjTHJPqjlm7naRMi8D/fZ9p+Kea+aJBChB
         pjv1jOYMvkaerjN0sLjvf+Lbf9vQ4ORf1gS45Uu5CSj7N1AA6zuXgA3qn+pjg8IMkmU8
         Gg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDJDsiVkP+iuIKoF7s5SNs8Hk+I+vxZMVtH2ehBFkJKpxLzanN34mIi2nz4K3KJndiCxeKLFjr+UFCM2gMhm26lKrK5wm6N7Gm
X-Gm-Message-State: AOJu0YzvENAgZiO4gDoZRtIPSqtjca0ItkNW4pX1qCw6D1V4fTLmKedT
	qv4uaxIonWe2djtx1yjLr/JZpj6AODj+lOzld4R6Tb3muc/L95hOuG1fEa9PBb8=
X-Google-Smtp-Source: AGHT+IEf5Z2BHiSbz5jeExeu1x4AURd20Z5mAdPYMuYoH526y4oOlikjVZuGNfO3Hmhe1sfyzkDnxA==
X-Received: by 2002:a05:600c:45ce:b0:426:5520:b835 with SMTP id 5b1f17b1804b1-427dc515ce5mr61802035e9.5.1721667530878;
        Mon, 22 Jul 2024 09:58:50 -0700 (PDT)
Received: from carbon.local (aztw-29-b2-v4wan-166913-cust1764.vm26.cable.virginm.net. [82.37.38.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm161660055e9.33.2024.07.22.09.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 09:58:50 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Date: Mon, 22 Jul 2024 17:58:43 +0100
Subject: [PATCH v5 2/2] iio: humidity: Add support for ENS210
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-ens21x-v5-2-cda88dce100e@thegoodpenguin.co.uk>
References: <20240722-ens21x-v5-0-cda88dce100e@thegoodpenguin.co.uk>
In-Reply-To: <20240722-ens21x-v5-0-cda88dce100e@thegoodpenguin.co.uk>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721667526; l=11346;
 i=jfelmeden@thegoodpenguin.co.uk; s=20240709; h=from:subject:message-id;
 bh=mqWrU3scnTZMpLJqnWzO2uIY68DKBT3JCJ/LsOnwo4I=;
 b=9fhgYhZk5srgHHdYqPmpe7lBZ2LTul4ndyXcuaXDrR1YULycf6e/X5jb7+5nP3DhQxqNDGlhy
 iVLtk6rMw+QCwfLsIC7WneO24mQ8HsuOp8wTPCMWW+3HNgDWwN0rIiI
X-Developer-Key: i=jfelmeden@thegoodpenguin.co.uk; a=ed25519;
 pk=tePkZ5iJ3ejQ2O3vjhsj7GrLYcyJN1o1sMT3IEXvKo0=

Add support for ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215.

The ENS21x is a family of temperature and relative humidity sensors with
accuracies tailored to the needs of specific applications.

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
---
 drivers/iio/humidity/Kconfig  |  11 ++
 drivers/iio/humidity/Makefile |   1 +
 drivers/iio/humidity/ens210.c | 344 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 356 insertions(+)

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
index 000000000000..9fe60a9eeef0
--- /dev/null
+++ b/drivers/iio/humidity/ens210.c
@@ -0,0 +1,344 @@
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
+ * @lock:	lock protecting the i2c conversion
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
+				  temp ? ENS210_SENS_START_T_START :
+					 ENS210_SENS_START_H_START);
+	if (ret)
+		return ret;
+
+	/* wait for conversion to be ready */
+	msleep(data->chip_info->conv_time_msec);
+
+	ret = i2c_smbus_read_byte_data(data->client,
+				       ENS210_REG_SENS_STAT);
+	if (ret < 0)
+		return ret;
+
+	/* perform read */
+	ret = i2c_smbus_read_i2c_block_data(
+		data->client, temp ? ENS210_REG_T_VAL : ENS210_REG_H_VAL, 3,
+		(u8 *)&regval_le);
+	if (ret < 0) {
+		dev_err(dev, "failed to read register");
+		return -EIO;
+	} else if (ret != 3) {
+		dev_err(dev, "expected 3 bytes, received %d\n", ret);
+		return -EIO;
+	}
+
+	regval = get_unaligned_le24(regval_le);
+	if (ens210_crc7(regval) != ((regval >> 17) & 0x7f)) {
+		/* crc fail */
+		dev_err(dev, "ens invalid crc\n");
+		return -EIO;
+	}
+
+	if (!((regval >> 16) & 0x1)) {
+		dev_err(dev, "ens data is not valid");
+		return -EIO;
+	}
+
+	*val = regval & 0xffff;
+	return IIO_VAL_INT;
+}
+
+static int ens210_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *channel, int *val,
+			   int *val2, long mask)
+{
+	struct ens210_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		scoped_guard(mutex, &data->lock) {
+			ret = ens210_get_measurement(indio_dev,
+				channel->type == IIO_TEMP, val);
+			if (ret)
+				return ret;
+			return IIO_VAL_INT;
+		}
+		return ret;
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
+		if (channel->type == IIO_TEMP) {
+			*val = -17481;
+			*val2 = 600000;
+			ret = IIO_VAL_INT_PLUS_MICRO;
+			break;
+		}
+		*val = 0;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+	unreachable();
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
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
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
+			I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
+			I2C_FUNC_SMBUS_WRITE_BYTE |
+			I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
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
+	part_id = i2c_smbus_read_word_data(client, ENS210_REG_PART_ID);
+
+	if (part_id != data->chip_info->part_id) {
+		dev_info(&client->dev,
+			"Part ID does not match (0x%04x != 0x%04x)\n", part_id,
+			data->chip_info->part_id);
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
+	{ .compatible = "sciosense,ens210", .data = &ens210_chip_info_data},
+	{ .compatible = "sciosense,ens210a", .data = &ens210a_chip_info_data },
+	{ .compatible = "sciosense,ens211", .data = &ens211_chip_info_data},
+	{ .compatible = "sciosense,ens212", .data = &ens212_chip_info_data},
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
+
+module_i2c_driver(ens210_driver);
+
+MODULE_DESCRIPTION("ScioSense ENS210 temperature and humidity sensor driver");
+MODULE_AUTHOR("Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>");
+MODULE_LICENSE("GPL");

-- 
2.39.2


