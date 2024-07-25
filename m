Return-Path: <linux-iio+bounces-7891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3EE93C6A7
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 17:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850D62826B9
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 15:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D166719DF64;
	Thu, 25 Jul 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsCqfwpP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8019D8BA;
	Thu, 25 Jul 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921967; cv=none; b=pW490zaXi+zO/1yXClZhVdkJY1kDP6lTtEHhAw2/jdcv9SJuZMulgWlsMTM5vEwp2Xd6sr/0iYQQC7dApWz8iY6PH3LOFCkiSfG3ZdxT6qR/9W57eBcnqijbeQatkDb4n5cRY+ML40LJu/joR26cC5YL1Y4VFj9BPj18qALeLB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921967; c=relaxed/simple;
	bh=rJC8TnzVzczQ8OjMGgUHyz88SCI7N13JVouBp5NnY0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fJZVY2WHDw5oG9hEbsC94WxvzdH6xGtmqCWgCVMoiCUYAY97Yo93VfQnxBYteDuk1AlKOEzObFKtHa5m45TpC7s4EXaQrxgY1GtvUyzcxeRS51v6RysRYVGs1wyLRH42HzJx9ke+W5AIGlXNEnmdnW4mycZqIg5uekNVXrt+lzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsCqfwpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07ADFC4AF0F;
	Thu, 25 Jul 2024 15:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721921967;
	bh=rJC8TnzVzczQ8OjMGgUHyz88SCI7N13JVouBp5NnY0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gsCqfwpPeG/6MOK0O9K7tRki4+LTHnrjjOCJlszuXmKb60r93YCK3LjwmNecZfW9I
	 WLrpFk/LVP6TQr3tYM065OCWogvlDbqb6vLovWFFQJscsUjWvVLcP16bEurma4CE+6
	 ld7EdWsj4Fv33hZCwfS3cWirQPC2L81bXuVapOfk9Ygt3QhyKi0BpXUsHfwDDn9KZ+
	 fqIa8gRFzFpBphsvSlkdbtpHxz3Mymm88bD5a8/51Zy19cJW45m2YsUlxJPCrN9wL5
	 bFvjqzbCnbiVUNfB/bVzoXg419qBpYYYd1MIQ62Ysra4DI66771/eEiKXM9QwsfNwc
	 PTDDF8GX6jXrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2EEC3DA49;
	Thu, 25 Jul 2024 15:39:26 +0000 (UTC)
From: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>
Date: Thu, 25 Jul 2024 17:37:28 +0200
Subject: [PATCH v4 2/3] iio: pressure: Add driver for Sensirion SDP500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-mainline_sdp500-v4-2-ea2f5b189958@gmail.com>
References: <20240725-mainline_sdp500-v4-0-ea2f5b189958@gmail.com>
In-Reply-To: <20240725-mainline_sdp500-v4-0-ea2f5b189958@gmail.com>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petar Stoykov <pd.pstoykov@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721921965; l=6101;
 i=pd.pstoykov@gmail.com; s=20240702; h=from:subject:message-id;
 bh=gsTGfB1B8JVxf9xS9ZBNvloEoNT22K5Qk0yTwqauMHs=;
 b=x9FuG6EE/hk2Q9rCIZ2UxyaBvbsttbPVQa8Po/wgUSdNs5CjVMCEcDHczaaH777vMtBtvrUGP
 kM1KHOAzg6sBf/yvKZLliCcXvsAuzVe1QDnAS67Z8/K53r2/m8E5URu
X-Developer-Key: i=pd.pstoykov@gmail.com; a=ed25519;
 pk=oxcGqcVV5O6wqlTh+39SbOwfbpD763i5x4TavUAHiCg=
X-Endpoint-Received: by B4 Relay for pd.pstoykov@gmail.com/20240702 with
 auth_id=179
X-Original-From: Petar Stoykov <pd.pstoykov@gmail.com>
Reply-To: pd.pstoykov@gmail.com

From: Petar Stoykov <pd.pstoykov@gmail.com>

Sensirion SDP500 is a digital differential pressure sensor. The sensor is
accessed over I2C.

Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
---
 drivers/iio/pressure/Kconfig  |   9 +++
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/sdp500.c | 157 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 95efa32e4289..5debdfbd5324 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -212,6 +212,15 @@ config MS5637
 	  This driver can also be built as a module. If so, the module will
 	  be called ms5637.
 
+config SDP500
+	tristate "Sensirion SDP500 differential pressure sensor I2C driver"
+	depends on I2C
+	help
+	  Say Y here to build support for Sensirion SDP500 differential pressure
+	  sensor I2C driver.
+	  To compile this driver as a module, choose M here: the core module
+	  will be called sdp500.
+
 config IIO_ST_PRESS
 	tristate "STMicroelectronics pressure sensor Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 436aec7e65f3..489ef7b7befa 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_MS5611) += ms5611_core.o
 obj-$(CONFIG_MS5611_I2C) += ms5611_i2c.o
 obj-$(CONFIG_MS5611_SPI) += ms5611_spi.o
 obj-$(CONFIG_MS5637) += ms5637.o
+obj-$(CONFIG_SDP500) += sdp500.o
 obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
 st_pressure-y := st_pressure_core.o
 st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
diff --git a/drivers/iio/pressure/sdp500.c b/drivers/iio/pressure/sdp500.c
new file mode 100644
index 000000000000..77d7e68f5dea
--- /dev/null
+++ b/drivers/iio/pressure/sdp500.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Sensirion sdp500 and sdp510 pressure sensors
+ *
+ * Datasheet: https://sensirion.com/resource/datasheet/sdp600
+ */
+
+#include <linux/i2c.h>
+#include <linux/crc8.h>
+#include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regulator/consumer.h>
+#include <asm/unaligned.h>
+
+#define SDP500_CRC8_POLYNOMIAL  0x31   /* x8+x5+x4+1 (normalized to 0x31) */
+#define SDP500_READ_SIZE        3
+
+#define SDP500_I2C_START_MEAS 0xF1
+
+struct sdp500_data {
+	struct device *dev;
+};
+
+DECLARE_CRC8_TABLE(sdp500_crc8_table);
+
+static int sdp500_start_measurement(struct sdp500_data *data)
+{
+	struct i2c_client *client = to_i2c_client(data->dev);
+
+	return i2c_smbus_write_byte(client, SDP500_I2C_START_MEAS);
+}
+
+static const struct iio_chan_spec sdp500_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static int sdp500_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  int *val, int *val2, long mask)
+{
+	int ret;
+	u8 rxbuf[SDP500_READ_SIZE];
+	u8 received_crc, calculated_crc;
+	struct sdp500_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = to_i2c_client(data->dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
+		if (ret < 0) {
+			dev_err(data->dev, "Failed to receive data");
+			return ret;
+		}
+		if (ret != SDP500_READ_SIZE) {
+			dev_err(data->dev, "Data is received wrongly");
+			return -EIO;
+		}
+
+		received_crc = rxbuf[2];
+		calculated_crc = crc8(sdp500_crc8_table, rxbuf,
+			sizeof(rxbuf) - 1, 0x00);
+		if (received_crc != calculated_crc) {
+			dev_err(data->dev,
+				"calculated crc = 0x%.2X, received 0x%.2X",
+				calculated_crc, received_crc);
+			return -EIO;
+		}
+
+		*val = get_unaligned_be16(rxbuf);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1;
+		*val2 = 60;
+
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info sdp500_info = {
+	.read_raw = &sdp500_read_raw,
+};
+
+static int sdp500_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct sdp500_data *data;
+	struct device *dev = &client->dev;
+	int ret;
+	u8 rxbuf[SDP500_READ_SIZE];
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"Failed to get and enable regulator\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	/* has to be done before the first i2c communication */
+	crc8_populate_msb(sdp500_crc8_table, SDP500_CRC8_POLYNOMIAL);
+
+	data = iio_priv(indio_dev);
+	data->dev = dev;
+
+	indio_dev->name = "sdp500";
+	indio_dev->channels = sdp500_channels;
+	indio_dev->info = &sdp500_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->num_channels = ARRAY_SIZE(sdp500_channels);
+
+	ret = sdp500_start_measurement(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to start measurement");
+
+	/* First measurement is not correct, read it out to get rid of it */
+	i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register indio_dev");
+
+	return 0;
+}
+
+static const struct i2c_device_id sdp500_id[] = {
+	{ "sdp500" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sdp500_id);
+
+static const struct of_device_id sdp500_of_match[] = {
+	{ .compatible = "sensirion,sdp500" },
+	{ .compatible = "sensirion,sdp510" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sdp500_of_match);
+
+static struct i2c_driver sdp500_driver = {
+	.driver = {
+		.name = "sensirion,sdp500",
+		.of_match_table = sdp500_of_match,
+	},
+	.probe = sdp500_probe,
+	.id_table = sdp500_id,
+};
+module_i2c_driver(sdp500_driver);
+
+MODULE_AUTHOR("Thomas Sioutas <thomas.sioutas@prodrive-technologies.com>");
+MODULE_DESCRIPTION("Driver for Sensirion SDP500 differential pressure sensor");
+MODULE_LICENSE("GPL");

-- 
2.39.2



