Return-Path: <linux-iio+bounces-25437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C455BC08C19
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 08:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CE83AB6D1
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 06:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891C02D5920;
	Sat, 25 Oct 2025 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="xLOMhwv4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0267270EBA
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761373270; cv=none; b=ctF8JT00oqeBfYH9Hv3G4Hebiszupp1t0K4NwPrOCIaibgvZDeISqoQ+6gZBCBgUzAXKg5kUuPmKcG9+GcBR77h7DkxPQ3NoP7MQKM4C4ZSi5hH/EeTJTRd7W6MHHgfE+vsyQAsmorrlqtw3Sh6+2OjfVAmLx3txeRA10P1OY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761373270; c=relaxed/simple;
	bh=CMQNbwSvv0mkh8tdFQY5j4Ky9jFEh8z398OLpHmgvKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5PgQxkPRHdURD6ufpefOJm5aJPZ3sy1AWAMix9ZB5vjc+b08Ee+h7H3HbthIb3/fiAKpSEnp5BeQ3AfS7yImk71FeMxiGVOlXMLPJPs20iaqjOTCwu5CQvhuTwrlLJPZb7VlUj7t4cTcPwrjRtQ04W/PrSLSFKneDr6ilAIMR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=xLOMhwv4; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 62758104C1FE
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 11:51:04 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 62758104C1FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1761373264; bh=CMQNbwSvv0mkh8tdFQY5j4Ky9jFEh8z398OLpHmgvKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xLOMhwv4xQU3nbkmYcvOPD5nFe5tDH+6EvMnE4OW+dHq2WSnZu8kLjmiqGAUPVHMQ
	 u1xX3XDbf4qJ/arMwguELk08ukaIQBhhwe016oXUtPCMtGhDAZXe741IK2VrqeR1fN
	 nr450a+owd3QTtNG4Vr5duUaWeu8gaTe+4VX6n7Q=
Received: (qmail 18696 invoked by uid 510); 25 Oct 2025 11:51:04 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.513312 secs; 25 Oct 2025 11:51:04 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 25 Oct 2025 11:51:01 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id F381B360035;
	Sat, 25 Oct 2025 11:51:00 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id BA6951E8160F;
	Sat, 25 Oct 2025 11:51:00 +0530 (IST)
Date: Sat, 25 Oct 2025 11:50:55 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com
Cc: skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: [PATCH v4 2/2] iio: pressure: adp810: Add driver for adp810 sensor
Message-ID: <cb51289f0f1c38a7ea24ee5ba3566c787f203ce7.1761372227.git.akhilesh@ee.iitb.ac.in>
References: <cover.1761372227.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761372227.git.akhilesh@ee.iitb.ac.in>

Add driver for Aosong adp810 differential pressure and temperature sensor.
This sensor provides an I2C interface for reading data.
Calculate CRC of the data received using standard crc8 library to verify
data integrity.

Tested on TI am62x sk board with sensor connected at i2c-2.

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 MAINTAINERS                   |   7 ++
 drivers/iio/pressure/Kconfig  |  12 ++
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/adp810.c | 225 ++++++++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+)
 create mode 100644 drivers/iio/pressure/adp810.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3da2c26a796b..3f10755661e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3749,6 +3749,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
 F:	drivers/iio/chemical/ags02ma.c
 
+AOSONG ADP810 DIFFERENTIAL PRESSURE SENSOR DRIVER
+M:	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
+F:	drivers/iio/pressure/adp810.c
+
 ASC7621 HARDWARE MONITOR DRIVER
 M:	George Joseph <george.joseph@fairview5.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index d2cb8c871f6a..2fe9dc90cceb 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -339,4 +339,16 @@ config ZPA2326_SPI
 	tristate
 	select REGMAP_SPI
 
+config ADP810
+	tristate "Aosong adp810 differential pressure and temperature sensor"
+	depends on I2C
+	select CRC8
+	help
+	  Say yes here to build adp810 differential pressure and temperature
+	  sensor driver. ADP810 can measure pressure range up to 500Pa.
+	  It supports an I2C interface for data communication.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called adp810
+
 endmenu
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 6482288e07ee..47bf7656f975 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -5,6 +5,7 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ABP060MG) += abp060mg.o
+obj-$(CONFIG_ADP810) += adp810.o
 obj-$(CONFIG_ROHM_BM1390) += rohm-bm1390.o
 obj-$(CONFIG_BMP280) += bmp280.o
 bmp280-objs := bmp280-core.o bmp280-regmap.o
diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
new file mode 100644
index 000000000000..5282612d1309
--- /dev/null
+++ b/drivers/iio/pressure/adp810.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Akhilesh Patil <akhilesh@ee.iitb.ac.in>
+ *
+ * Driver for adp810 pressure and temperature sensor
+ * Datasheet:
+ *   https://aosong.com/userfiles/files/media/Datasheet%20ADP810-Digital.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/cleanup.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+/*
+ * Refer section 5.4 checksum calculation from datasheet.
+ * This sensor uses CRC polynomial x^8 + x^5 + x^4 + 1 (0x31)
+ */
+#define ADP810_CRC8_POLYNOMIAL		0x31
+
+DECLARE_CRC8_TABLE(crc_table);
+
+/*
+ * Buffer declaration which holds 9 bytes of measurement data read
+ * from the sensor. Use __packed to avoid any paddings, as data sent
+ * from the sensor is strictly contiguous 9 bytes.
+ */
+struct adp810_read_buf {
+	__be16 dp;
+	u8 dp_crc;
+	__be16 tmp;
+	u8 tmp_crc;
+	__be16 sf;
+	u8 sf_crc;
+} __packed;
+
+struct adp810_data {
+	struct i2c_client *client;
+	/* Use lock to synchronize access to device during read sequence */
+	struct mutex lock;
+};
+
+static int adp810_measure(struct adp810_data *data, struct adp810_read_buf *buf)
+{
+	struct i2c_client *client = data->client;
+	struct device *dev = &client->dev;
+	int ret;
+	u8 trig_cmd[2] = {0x37, 0x2d};
+
+	/* Send trigger command to the sensor for measurement */
+	ret = i2c_master_send(client, trig_cmd, sizeof(trig_cmd));
+	if (ret < 0) {
+		dev_err(dev, "Error sending trigger command\n");
+		return ret;
+	}
+	if (ret != sizeof(trig_cmd))
+		return -EIO;
+
+	/*
+	 * Wait for the sensor to acquire data. As per datasheet section 5.3.1,
+	 * at least 10ms delay before reading from the sensor is recommended.
+	 * Here, we wait for 20ms to have some safe margin on the top
+	 * of recommendation and to compensate for any possible variations.
+	 */
+	msleep(20);
+
+	/* Read sensor values */
+	ret = i2c_master_recv(client, (char *)buf, sizeof(*buf));
+	if (ret < 0) {
+		dev_err(dev, "Error reading from sensor\n");
+		return ret;
+	}
+	if (ret != sizeof(*buf))
+		return -EIO;
+
+	/* CRC checks */
+	crc8_populate_msb(crc_table, ADP810_CRC8_POLYNOMIAL);
+	if (buf->dp_crc != crc8(crc_table, (u8 *)&buf->dp, 0x2, CRC8_INIT_VALUE)) {
+		dev_err(dev, "CRC error for pressure\n");
+		return -EIO;
+	}
+
+	if (buf->tmp_crc != crc8(crc_table, (u8 *)&buf->tmp, 0x2, CRC8_INIT_VALUE)) {
+		dev_err(dev, "CRC error for temperature\n");
+		return -EIO;
+	}
+
+	if (buf->sf_crc != crc8(crc_table, (u8 *)&buf->sf, 0x2, CRC8_INIT_VALUE)) {
+		dev_err(dev, "CRC error for scale\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int adp810_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct adp810_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+	struct adp810_read_buf buf = { };
+	int ret;
+
+	scoped_guard(mutex, &data->lock) {
+		ret = adp810_measure(data, &buf);
+		if (ret) {
+			dev_err(dev, "Failed to read from device\n");
+			return ret;
+		}
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			*val = get_unaligned_be16(&buf.dp);
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			*val = get_unaligned_be16(&buf.tmp);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			*val = get_unaligned_be16(&buf.sf);
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			*val = 200;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info adp810_info = {
+	.read_raw = adp810_read_raw,
+};
+
+static const struct iio_chan_spec adp810_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static int adp810_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct adp810_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "adp810";
+	indio_dev->channels = adp810_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adp810_channels);
+	indio_dev->info = &adp810_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register IIO device\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id adp810_id_table[] = {
+	{ "adp810" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adp810_id_table);
+
+static const struct of_device_id adp810_of_table[] = {
+	{ .compatible = "aosong,adp810" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adp810_of_table);
+
+static struct i2c_driver adp810_driver = {
+	.driver = {
+		.name = "adp810",
+		.of_match_table = adp810_of_table,
+	},
+	.probe	= adp810_probe,
+	.id_table = adp810_id_table,
+};
+module_i2c_driver(adp810_driver);
+
+MODULE_AUTHOR("Akhilesh Patil <akhilesh@ee.iitb.ac.in>");
+MODULE_DESCRIPTION("Driver for Aosong ADP810 sensor");
+MODULE_LICENSE("GPL");
-- 
2.34.1


