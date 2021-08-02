Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABE73DD3AF
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 12:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhHBK2w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 06:28:52 -0400
Received: from smtpcmd14162.aruba.it ([62.149.156.162]:35398 "EHLO
        smtpcmd14162.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhHBK2w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 06:28:52 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 06:28:52 EDT
Received: from polimar.homenet.telecomitalia.it ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id AV4dmcNSqrIRlAV4dmu9af; Mon, 02 Aug 2021 12:21:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1627899692; bh=PicATUGtKBTivGr8+mm0RjYViUESLKxdGV3g0s45TPA=;
        h=From:To:Subject:Date:MIME-Version;
        b=IYXtAT5/v+kKkLbSFM3wFe7HY+8iq6YzP7MWay038LGB/R/zINgEujmiAFzuuwli4
         T7FqpWk27bJ050WeK4y1LvkNHlSCY8QHNNqDIrUqK7uNNOj0B6Aw/Nk3JQW9+/lbSX
         ZAYHOHbmQ38slB/uoLb6q8LfA9M/yyEKH69qbKa/IjyXbKthdjV8SLOxEn0/hm6be4
         DrKqrQq+iP6gMzfHeUvxOrxnKGjlyZbaHn3RDgGIVnwFimUVl9/1YxV6iGftcZFfNU
         Q4LwxnW5oNcXkzUuqqNf3Mor4I8FxH8Mkv2WcnnmhSoL4+h5GDcpR4DpbQNKDyVDgS
         W26Fi0J4RP8vw==
From:   Rodolfo Giometti <giometti@enneenne.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH] drivers iio/adc: add driver for Texas Instruments TLA2528 adc
Date:   Mon,  2 Aug 2021 12:21:31 +0200
Message-Id: <20210802102131.856129-1-giometti@enneenne.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOnmeGXLq/lYQo9eh0zd2tqNgCJd0c6kExeVI8YBtehWTOwV8tk5Tins3MCdXwF+2PZT6GxkIuigBAUNEJYtwpqjM8inY9EvD3ZBaoF3ZCvTXe6zJ+vZ
 jNU3CH4BFiUUIqErtd36VE2sPJMydp+UIz4Uv/IKW03AEFeUvZZw+1GzI1JhHEazCNS+pwLmKfNsnFei0zPTH+vmFASS2RXVeXRZs1oxoLdstAwuon2jdAS2
 mfPhpZjFU+afXS0tXdMJgg==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds a new driver for the TI TLA2528 ADC chip.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 drivers/iio/adc/Kconfig      |  10 ++
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-tla2528.c | 246 +++++++++++++++++++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 drivers/iio/adc/ti-tla2528.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index db0c8fb60515..f42e6d84c8f3 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1178,6 +1178,16 @@ config TI_AM335X_ADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called ti_am335x_adc.
 
+config TI_TLA2528
+	tristate "Texas Instruments TLA2528 ADC driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Texas Instruments TLA2528
+	  12-Bit 8-Channel ADC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ti-tla2528.
+
 config TI_TLC4541
 	tristate "Texas Instruments TLC4541 ADC driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index f70d877c555a..0bf287672838 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
 obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
+obj-$(CONFIG_TI_TLA2528) += ti-tla2528.o
 obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
 obj-$(CONFIG_TI_TSC2046) += ti-tsc2046.o
 obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
diff --git a/drivers/iio/adc/ti-tla2528.c b/drivers/iio/adc/ti-tla2528.c
new file mode 100644
index 000000000000..4512362e1d2e
--- /dev/null
+++ b/drivers/iio/adc/ti-tla2528.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Texas Instruments TLA2528 ADC
+ *
+ * Copyright (C) 2020-2021 Rodolfo Giometti <giometti@enneenne.com>
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/regulator/consumer.h>
+#include <linux/of.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define TLA2528_OP_READ_REG		0x10
+#define TLA2528_OP_WRITE_REG		0x08
+
+#define TLA2528_GENERAL_CFG		0x01
+#define TLA2528_GENERAL_CFG_CNVST	BIT(3)
+#define TLA2528_DATA_CFG		0x02
+#define TLA2528_DATA_CFG_APPEND_STATUS	BIT(4)
+#define TLA2528_DATA_CFG_FIX_PAT	BIT(7)
+#define TLA2528_PIN_CFG			0x05
+#define TLA2528_SEQUENCE_CFG		0x10
+#define TLA2528_CHANNEL_SEL		0x11
+
+struct tla2528_st {
+	struct i2c_client *client;
+	struct regulator *ref;
+
+	u8 last_read_channel;
+};
+
+static s32 i2c_smbus_read_sample(const struct i2c_client *client)
+{
+	struct i2c_msg msg[1];
+	u8 data[2];
+	int ret;
+
+	msg[0].addr = client->addr;
+	msg[0].flags = I2C_M_RD;
+	msg[0].buf = (u8 *) &data;
+	msg[0].len = 2;
+
+	ret = i2c_transfer(client->adapter, msg, 1);
+
+	return (ret < 0) ? ret : le16_to_cpu(data[1] | (data[0] << 8));
+}
+
+static s32 i2c_smbus_write_reg(const struct i2c_client *client, u8 reg, u8 val)
+{
+	struct i2c_msg msg[1];
+	u8 cmd[3] = {TLA2528_OP_WRITE_REG, reg, val};
+
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].buf = cmd;
+	msg[0].len = 3;
+
+	return i2c_transfer(client->adapter, msg, 1);
+}
+
+static int tla2528_read(struct tla2528_st *st, u8 channel, int *val)
+{
+	struct i2c_client *client = st->client;
+	int ret;
+
+	if (channel != st->last_read_channel) {
+		ret = i2c_smbus_write_reg(st->client,
+					TLA2528_CHANNEL_SEL, channel);
+		if (ret < 0)
+			return ret;
+
+		st->last_read_channel = channel;
+	}
+
+	/* Read ADC data (2 bytes) */
+	ret = i2c_smbus_read_sample(client);
+	if (ret < 0)  {
+		dev_err(&client->dev, "i2c_master_recv failed\n");
+		return ret;
+	}
+	*val = ret >> 4;
+
+	return 0;
+}
+
+static int tla2528_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct tla2528_st *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&indio_dev->mlock);
+		ret = tla2528_read(st, chan->channel, val);
+		mutex_unlock(&indio_dev->mlock);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = regulator_get_voltage(st->ref);
+		if (ret < 0)
+			return ret;
+
+		*val = ret / 1000;
+		*val2 = 12;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+#define TLA2528_CHAN(_chan, _name) { \
+	.type = IIO_VOLTAGE,					\
+	.channel = (_chan),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.datasheet_name = _name,				\
+	.indexed = 1,						\
+}
+
+static const struct iio_chan_spec tla2528_channel[] = {
+	TLA2528_CHAN(0, "AIN0"),
+	TLA2528_CHAN(1, "AIN1"),
+	TLA2528_CHAN(2, "AIN2"),
+	TLA2528_CHAN(3, "AIN3"),
+	TLA2528_CHAN(4, "AIN4"),
+	TLA2528_CHAN(5, "AIN5"),
+	TLA2528_CHAN(6, "AIN6"),
+	TLA2528_CHAN(7, "AIN7"),
+};
+
+static const struct iio_info tla2528_info = {
+	.read_raw = tla2528_read_raw,
+};
+
+static int tla2528_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct tla2528_st *st;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
+				     I2C_FUNC_SMBUS_WRITE_BYTE))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	st->client = client;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = id->name;
+	indio_dev->info = &tla2528_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = tla2528_channel;
+	indio_dev->num_channels = ARRAY_SIZE(tla2528_channel);
+
+	st->ref = devm_regulator_get(&client->dev, "vref");
+	if (IS_ERR(st->ref))
+		return PTR_ERR(st->ref);
+
+	ret = regulator_enable(st->ref);
+	if (ret < 0)
+		return ret;
+
+	/* Set all inputs as analog */
+	ret = i2c_smbus_write_reg(st->client, TLA2528_PIN_CFG, 0x00);
+	if (ret < 0)
+		goto err_regulator_disable;
+
+	ret = i2c_smbus_write_reg(st->client, TLA2528_DATA_CFG,
+					TLA2528_DATA_CFG_APPEND_STATUS);
+	if (ret < 0)
+		goto err_regulator_disable;
+
+	/* Set manual mode */
+	ret = i2c_smbus_write_reg(st->client, TLA2528_SEQUENCE_CFG, 0x00);
+	if (ret < 0)
+		goto err_regulator_disable;
+
+	/* Init private data */
+	st->last_read_channel = ~0;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto err_regulator_disable;
+
+	return 0;
+
+err_regulator_disable:
+	regulator_disable(st->ref);
+
+	return ret;
+}
+
+static int tla2528_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct tla2528_st *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	regulator_disable(st->ref);
+
+	return 0;
+}
+
+static const struct i2c_device_id tla2528_id[] = {
+	{ "tla2528", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tla2528_id);
+
+static const struct of_device_id tla2528_of_match[] = {
+	{ .compatible = "ti,tla2528", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, tla2528_of_match);
+
+static struct i2c_driver tla2528_driver = {
+	.driver = {
+		.name = "tla2528",
+		.of_match_table = of_match_ptr(tla2528_of_match),
+	},
+	.probe = tla2528_probe,
+	.remove = tla2528_remove,
+	.id_table = tla2528_id,
+};
+module_i2c_driver(tla2528_driver);
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti@enneenne.com>");
+MODULE_DESCRIPTION("Texas Instruments TLA2528 ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

