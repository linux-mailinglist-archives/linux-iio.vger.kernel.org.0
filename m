Return-Path: <linux-iio+bounces-7710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2619377FF
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 14:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D1F1B21C57
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B36142E7C;
	Fri, 19 Jul 2024 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="2RJUhl5G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED913CA9C
	for <linux-iio@vger.kernel.org>; Fri, 19 Jul 2024 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721393467; cv=none; b=QDLVjvECVqvS/6VJLID3vLKp8dW8dhGK9fSWbWHSrd8BOVbs085+MWKoKpjCI76TWuRcNbe2gctI/RLyUGBluI/jeVaZLJFAUSmbrgNaL78Y00LKr6notWR/0T7ECeqDBaCBJatNIQz8UneQpLQWLNBNQ6ktYl4S/+skbrRewmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721393467; c=relaxed/simple;
	bh=LvPY47ZKo3Tui6dtaG9dph3g887IEcqLVyuYsUo+nAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7DfLPNJ7pVAE9CFsDaTHqgM9nb/HiwjykujHP2Ga5X/uZMwlkVf2f+/b9jMFmpgcXHLNyjCie5CpDTeFZmKnbrxQzEM2oUXXXu6XxjDR4oTpjnH4ussUf240VYgOyb6vEf2XrsFwGQPEshbmtWKWPIg9dKFDMX4+t6GLgGw2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=2RJUhl5G; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-426526d30aaso12731155e9.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Jul 2024 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1721393464; x=1721998264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYwa1tD0o4Ya1w2J9EVZpIfkoRF2CSGZ2ttH8+PFLZw=;
        b=2RJUhl5GbwpVz0DrNJG8pBaVA7/zFLLaMWL0OyCEgJmgmZ9H4jh++B2TcWcrXPrrNF
         Nf/zQ2la2JViumGQDfd6dKkLz6K+SWf13rkr/msoVsbcpZ4dDjIRIniq49ksWDGGdlgy
         AwnhwcRu+62/513BYM9hoUY2Jqf7HqUqVxxHrfoEmrjObdEDowB7i2ncF9p+L+zeDfRb
         Hhw1zh4veu7ry8n5S9khpr2ZMeLUUAKzSWf+XxaB66XPcjzW3y7aW1kSC6I9qFbQw8jw
         btKV7sL1W45WOGGUC7FyRRDc+mbI6V26rryK8atgPDZYsZpJljFG83Vo+9QNJcyaDdpJ
         YnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721393464; x=1721998264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYwa1tD0o4Ya1w2J9EVZpIfkoRF2CSGZ2ttH8+PFLZw=;
        b=lwYsvqNurWBOXJgks+l+fAU6crfH54FgBJbaffncq4AGJlpLKKJccNR8M+M0NAYqPW
         DFw0T8WxxT4iuub4KaWj+D7/ZMkDafQZKQeu9fCtHwv3ZMTm+Tfz/fGLtzgEtYnDFD37
         iAxbUVo6ZvoXmlqcIqu0e6vS8MTl3+MjOEls/DWTH8O2s5h/X+FkKvtQz6RwAoFm55sd
         +saKZC/3dkM9NZipMmbbOOEvKKQrWxoaXKJ4zsQA6sp5xMLVZJn7bEBGSJaWAE3SC1L9
         zCcfes+Daxgq0+Sbkc0WEBFoLrwef+OHJHb3Vn63WNKob6VQ3shY+T8ctDpvyRrjXj5Y
         LqLQ==
X-Gm-Message-State: AOJu0YzYcID9s2yVmmCPxCzkEFMYFuTT6x9/OosNnli5KhifW9uDLBbW
	9QgRAhpiRaW8DMoobwcXJWCNDMXcsPI/eAU/zosaxfMEFbFr1xrKU29NrO9B9WE=
X-Google-Smtp-Source: AGHT+IHRF4xQQNR8Ec0V29L5a5MXsUKeESjkErt8a/p3j5aoFPkeeF7+YCfhelAkZS5TiAuCLAliiA==
X-Received: by 2002:a05:600c:4f86:b0:426:62c6:4341 with SMTP id 5b1f17b1804b1-427c2ce5ae0mr50819915e9.20.1721393463786;
        Fri, 19 Jul 2024 05:51:03 -0700 (PDT)
Received: from carbon.local (aztw-29-b2-v4wan-166913-cust1764.vm26.cable.virginm.net. [82.37.38.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2911486sm21217445e9.0.2024.07.19.05.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 05:51:03 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Date: Fri, 19 Jul 2024 13:50:54 +0100
Subject: [PATCH v4 2/2] iio: humidity: Add support for ENS210
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-ens21x-v4-2-6044e48a376a@thegoodpenguin.co.uk>
References: <20240719-ens21x-v4-0-6044e48a376a@thegoodpenguin.co.uk>
In-Reply-To: <20240719-ens21x-v4-0-6044e48a376a@thegoodpenguin.co.uk>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721393458; l=11384;
 i=jfelmeden@thegoodpenguin.co.uk; s=20240709; h=from:subject:message-id;
 bh=LvPY47ZKo3Tui6dtaG9dph3g887IEcqLVyuYsUo+nAs=;
 b=mOErL2FoA5ayRIaRc/veMFbW9GGgEc2xVsG9865fBe0UO58FNUlKq/YB7w8S50deWaL1mA2N7
 9Xgg25qqByOCy6YkedJsap0wjWDnZFpPQi/t6rv3z6PUCIAYt785GDr
X-Developer-Key: i=jfelmeden@thegoodpenguin.co.uk; a=ed25519;
 pk=tePkZ5iJ3ejQ2O3vjhsj7GrLYcyJN1o1sMT3IEXvKo0=

Add support for ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215.

The ENS21x is a family of temperature and relative humidity sensors with
accuracies tailored to the needs of specific applications.

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
---
 drivers/iio/humidity/Kconfig  |  11 ++
 drivers/iio/humidity/Makefile |   1 +
 drivers/iio/humidity/ens210.c | 341 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 353 insertions(+)

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
index 000000000000..4655e8cb4f51
--- /dev/null
+++ b/drivers/iio/humidity/ens210.c
@@ -0,0 +1,341 @@
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
+ * @lock:	lock protecting the i2c conversion
+ * @res_index:	index to selected sensor resolution
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
+	__be32 val_be = (cpu_to_be32(val & 0x1ffff) >> 0x8);
+
+	return crc7_be(0xde, (u8 *)&val_be, 3) >> 1;
+}
+
+static int ens210_get_measurement(struct iio_dev *indio_dev, bool temp, int *val)
+{
+	u32 regval;
+	u8 regval_le[3];
+	int ret;
+	struct ens210_data *data = iio_priv(indio_dev);
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
+		dev_err(&data->client->dev, "failed to read register");
+		return -EIO;
+	} else if (ret != 3) {
+		dev_err(&indio_dev->dev, "expected 3 bytes, received %d\n", ret);
+		return -EIO;
+	}
+
+	regval = get_unaligned_le24(regval_le);
+	if (ens210_crc7(regval) != ((regval >> 17) & 0x7f)) {
+		/* crc fail */
+		dev_err(&indio_dev->dev, "ens invalid crc\n");
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
+			ret = ens210_get_measurement(
+				indio_dev, channel->type == IIO_TEMP, val);
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
+	return ret;
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
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	struct ens210_data *data;
+	struct iio_dev *indio_dev;
+	uint16_t part_id;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter,
+			I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
+			I2C_FUNC_SMBUS_WRITE_BYTE |
+			I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+		dev_err_probe(&client->dev, -EOPNOTSUPP,
+			"adapter does not support some i2c transactions\n");
+		return -EOPNOTSUPP;
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
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
+			"Part ID does not match (0x%04x != 0x%04lx)\n", part_id,
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


