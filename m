Return-Path: <linux-iio+bounces-24940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0F9BCF527
	for <lists+linux-iio@lfdr.de>; Sat, 11 Oct 2025 14:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5A9C4E9E3B
	for <lists+linux-iio@lfdr.de>; Sat, 11 Oct 2025 12:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C87278E67;
	Sat, 11 Oct 2025 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="HCUinyqV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B2277CB6
	for <linux-iio@vger.kernel.org>; Sat, 11 Oct 2025 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760185551; cv=none; b=Bkv/FD9Cfc1ekq+9ICar6aeUQW1tpq80YqrAzRZXWizjhdnslu/CUnjG4D++8XxWR/xaMXNXpaMMKKXExWX0AdTVdGCnWRc+6Cvqw/SEKH1cE6NqTVZPj+3dLjaeJ9zVN3in1ig9CGR7FEZn7SNrqouCUon829hJZFAd9M4P0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760185551; c=relaxed/simple;
	bh=H9wIaqVx7OQj6GJ+mV63N1yADVd0N696oTAVTJj9dKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unmN1nRniuEboUY553PYL8bg6e+g/NAECCEjUorVIEj5uLRjceQGZ4FXVp5txijPpcsKCSeswR+uz+Epvk+LyhBmS4YKNuYp2Ck/Iyr6sAHOojZnS4NeiWUbzoLeJsWAn/4wZNXt/pKjWu/iRP4c3QasNymBlhTysB5qYILQ4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=HCUinyqV; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 83957104C1DC
	for <linux-iio@vger.kernel.org>; Sat, 11 Oct 2025 17:55:42 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 83957104C1DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1760185542; bh=H9wIaqVx7OQj6GJ+mV63N1yADVd0N696oTAVTJj9dKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCUinyqVYfw+bTDa3LlrfVxC5DcVFCJHVrJzjjOmmw8ho180790oGnG+kV38EY08q
	 NNxhbKKy8ftn/tVrR1AiUayqQPN0m4twpSqF+xEpsCHNRtauTaVAHVkEG8ADq+wNhm
	 ur37s4io5xiFY0JmUvbgrxXKdjJvE+CqGGMqbQWQ=
Received: (qmail 24586 invoked by uid 510); 11 Oct 2025 17:55:42 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 8.581998 secs; 11 Oct 2025 17:55:42 +0530
X-Spam-Level: 
X-Spam-Pyzor: 
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 11 Oct 2025 17:55:33 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id EC6DC3414EA;
	Sat, 11 Oct 2025 17:55:32 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id D71921E81664;
	Sat, 11 Oct 2025 17:55:32 +0530 (IST)
Date: Sat, 11 Oct 2025 17:55:28 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com
Cc: skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: [PATCH 2/2] iio: pressure: adp810: Add driver for adp810 sensor
Message-ID: <8c202e7ccd332b26217d529a7a73b7a3ef0726ea.1760184859.git.akhilesh@ee.iitb.ac.in>
References: <cover.1760184859.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760184859.git.akhilesh@ee.iitb.ac.in>

Add driver for Aosong adp810 differential pressure and
temperature sensor. This sensor provides I2C interface for
reading data. Calculate CRC of the data received using standard
crc8 library to verify data integrity.

Tested on TI am62x sk board with sensor connected at i2c-2

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 MAINTAINERS                   |   7 ++
 drivers/iio/pressure/Kconfig  |  12 ++
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/adp810.c | 205 ++++++++++++++++++++++++++++++++++
 4 files changed, 225 insertions(+)
 create mode 100644 drivers/iio/pressure/adp810.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e4886604631d..52546cb3dac6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3745,6 +3745,13 @@ S:	Maintained
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
index d2cb8c871f6a..648da292f8de 100644
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
+	  It supports I2C interface for data communication.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called adp810
+
 endmenu
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 6482288e07ee..08f5fa724491 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_ZPA2326_SPI) += zpa2326_spi.o
 
 obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
 obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
+obj-$(CONFIG_ADP810) += adp810.o
diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
new file mode 100644
index 000000000000..ff73330b34fc
--- /dev/null
+++ b/drivers/iio/pressure/adp810.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Akhilesh Patil <akhilesh@ee.iitb.ac.in>
+ *
+ * Driver for adp810 pressure and temperature sensor
+ * Datasheet:
+ *   https://aosong.com/userfiles/files/media/Datasheet%20ADP810-Digital.pdf
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/crc8.h>
+
+/* Time taken in ms by sensor to do measurements after triggering.
+ * As per datahseet, 10ms is sufficient but we define 30 for better margin
+ */
+#define ADP810_MEASURE_LATENCY		30
+/* Trigger command to send to start measurement by the sensor */
+#define ADP810_TRIGGER_COMMAND		0x2d37
+#define ADP810_CRC8_POLYNOMIAL		0x31
+
+DECLARE_CRC8_TABLE(crc_table);
+
+struct adp810_read_buf {
+	u8 dp_msb;
+	u8 dp_lsb;
+	u8 dp_crc;
+	u8 tmp_msb;
+	u8 tmp_lsb;
+	u8 tmp_crc;
+	u8 sf_msb;
+	u8 sf_lsb;
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
+	int ret;
+	u16 trig_cmd = ADP810_TRIGGER_COMMAND;
+
+	/* Send trigger to the sensor for measurement */
+	ret = i2c_master_send(client, (char *)&trig_cmd, sizeof(u16));
+	if (ret < 0) {
+		dev_err(&client->dev, "Error sending trigger command\n");
+		return ret;
+	}
+
+	/* Wait for sensor to aquire data */
+	msleep(ADP810_MEASURE_LATENCY);
+
+	/* Read sensor values */
+	ret = i2c_master_recv(client, (char *)buf, sizeof(*buf));
+	if (ret < 0) {
+		dev_err(&client->dev, "Error reading from sensor\n");
+		return ret;
+	}
+
+	/* CRC checks */
+	crc8_populate_msb(crc_table, ADP810_CRC8_POLYNOMIAL);
+	if (buf->dp_crc != crc8(crc_table, &buf->dp_msb, 0x2, CRC8_INIT_VALUE)) {
+		dev_err(&client->dev, "CRC error for pressure\n");
+		return -EIO;
+	}
+
+	if (buf->tmp_crc != crc8(crc_table, &buf->tmp_msb, 0x2, CRC8_INIT_VALUE)) {
+		dev_err(&client->dev, "CRC error for temperature\n");
+		return -EIO;
+	}
+
+	if (buf->sf_crc != crc8(crc_table, &buf->sf_msb, 0x2, CRC8_INIT_VALUE)) {
+		dev_err(&client->dev, "CRC error for scale\n");
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
+	struct adp810_read_buf buf = {0};
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = adp810_measure(data, &buf);
+	mutex_unlock(&data->lock);
+
+	if (ret) {
+		dev_err(&indio_dev->dev, "Failed to read from device\n");
+		return ret;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			*val = buf.dp_msb << 8 | buf.dp_lsb;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			*val = buf.tmp_msb << 8 | buf.tmp_lsb;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			*val = buf.sf_msb << 8 | buf.sf_lsb;
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
+
+	return -EINVAL;
+}
+
+static const struct iio_info adp810_info = {
+	.read_raw	= adp810_read_raw,
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
+	const struct i2c_device_id *dev_id = i2c_client_get_device_id(client);
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
+	mutex_init(&data->lock);
+
+	indio_dev->name = dev_id->name;
+	indio_dev->channels = adp810_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adp810_channels);
+	indio_dev->info = &adp810_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register IIO device\n");
+
+	return ret;
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


