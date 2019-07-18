Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80BC96D6FC
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 00:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfGRWzA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 18:55:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:65198 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391326AbfGRWzA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 18:55:00 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IMqFnq028128;
        Fri, 19 Jul 2019 00:54:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=asIeISpOgkx+TiCcFdnLkb6JZYvkc7jtrC5nUgiix0M=;
 b=KlaQifU/iYRDw+EzQWPMTcde+Ax29+I4TMquIrsEC6LaC1vuYoGGm+toAty5wa8cprHl
 BZFppkdK2AcYYeehwvgdJg+z6anye+KzIKU1Cax9fV4KwDrEV1B3trew0Sdej7TPgdTW
 n6/c2BurK41uJw6CkJQzc5Tff0ogZXGauaEbIF2NuxvaTio5JFN4f9oDPm3+TRWahy3w
 XNo8BxFU+So3xsnOr3AnBZ9E7xEIJLJ1xYmc4JoEaZx4RlXdfq3Kz3bL4xNA+Nkg9+1U
 2fj7GdVDkNE+xwQk0VmE0JlGezEEn14gSlsy2fYzoIMeXjUNac6cGmqx5W9L2vNQP0q7 +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tq4s24j7b-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 19 Jul 2019 00:54:53 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2F24431;
        Thu, 18 Jul 2019 22:54:52 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0A56910AD;
        Thu, 18 Jul 2019 22:54:52 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 19 Jul 2019 00:54:50
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <denis.ciocca@st.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v2 11/11] iio: make st_sensors drivers use regmap
Date:   Thu, 18 Jul 2019 15:53:53 -0700
Message-ID: <20190718225353.2078-12-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718225353.2078-1-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_12:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch is meant to replace the i2c/spi transfer functions with
regmap. SPI framework requires DMA safe buffers so let's add GFP_DMA
flag for memory allocation used by bulk_read functions.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
Changes in v2:
 memory allocation uses GFP_DMA if buffer is used in bulk_read
 fix struct fields doc

 drivers/iio/accel/st_accel_buffer.c           |   3 +-
 drivers/iio/accel/st_accel_core.c             |   3 -
 drivers/iio/accel/st_accel_i2c.c              |   4 +-
 .../iio/common/st_sensors/st_sensors_buffer.c |  10 +-
 .../iio/common/st_sensors/st_sensors_core.c   |  41 +++----
 .../iio/common/st_sensors/st_sensors_i2c.c    |  73 ++++++-------
 .../iio/common/st_sensors/st_sensors_spi.c    | 100 ++++--------------
 .../common/st_sensors/st_sensors_trigger.c    |  10 +-
 drivers/iio/gyro/st_gyro_buffer.c             |   3 +-
 drivers/iio/gyro/st_gyro_core.c               |   3 -
 drivers/iio/gyro/st_gyro_i2c.c                |   4 +-
 drivers/iio/magnetometer/st_magn_buffer.c     |   3 +-
 drivers/iio/magnetometer/st_magn_core.c       |   3 -
 drivers/iio/magnetometer/st_magn_i2c.c        |   4 +-
 drivers/iio/pressure/st_pressure_buffer.c     |   3 +-
 drivers/iio/pressure/st_pressure_core.c       |   3 -
 drivers/iio/pressure/st_pressure_i2c.c        |   4 +-
 include/linux/iio/common/st_sensors.h         |  40 +------
 include/linux/iio/common/st_sensors_i2c.h     |   4 +-
 19 files changed, 105 insertions(+), 213 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 0205c0167cdd..05f9aea431e2 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -39,7 +39,8 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 	int err;
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 
-	adata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	adata->buffer_data = kmalloc(indio_dev->scan_bytes,
+				     GFP_DMA | GFP_KERNEL);
 	if (adata->buffer_data == NULL) {
 		err = -ENOMEM;
 		goto allocate_memory_error;
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 630909702a19..0b17004cb12e 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -13,7 +13,6 @@
 #include <linux/acpi.h>
 #include <linux/errno.h>
 #include <linux/types.h>
-#include <linux/mutex.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
@@ -1177,7 +1176,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &accel_info;
-	mutex_init(&adata->tb.buf_lock);
 
 	err = st_sensors_power_enable(indio_dev);
 	if (err)
@@ -1188,7 +1186,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 		goto st_accel_power_off;
 
 	adata->num_data_channels = ST_ACCEL_NUMBER_DATA_CHANNELS;
-	adata->multiread_bit = adata->sensor_settings->multi_read_bit;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
 	channels_size = indio_dev->num_channels * sizeof(struct iio_chan_spec);
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index a92cf776031e..50fa0fc32baa 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -174,7 +174,9 @@ static int st_accel_i2c_probe(struct i2c_client *client)
 	adata = iio_priv(indio_dev);
 	adata->sensor_settings = (struct st_sensor_settings *)settings;
 
-	st_sensors_i2c_configure(indio_dev, client, adata);
+	ret = st_sensors_i2c_configure(indio_dev, client);
+	if (ret < 0)
+		return ret;
 
 	ret = st_accel_common_probe(indio_dev);
 	if (ret < 0)
diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index 4a68669dc555..eee30130ae23 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -17,15 +17,16 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/irqreturn.h>
+#include <linux/regmap.h>
 
 #include <linux/iio/common/st_sensors.h>
 
 
 static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 {
-	int i;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 	unsigned int num_data_channels = sdata->num_data_channels;
+	int i;
 
 	for_each_set_bit(i, indio_dev->active_scan_mask, num_data_channels) {
 		const struct iio_chan_spec *channel = &indio_dev->channels[i];
@@ -36,11 +37,8 @@ static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 			channel->scan_type.storagebits >> 3;
 
 		buf = PTR_ALIGN(buf, storage_bytes);
-		if (sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
-						  channel->address,
-						  bytes_to_read, buf,
-						  sdata->multiread_bit) <
-		    bytes_to_read)
+		if (regmap_bulk_read(sdata->regmap, channel->address,
+				     buf, bytes_to_read) < 0)
 			return -EIO;
 
 		/* Advance the buffer pointer */
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 40977d2ee400..4a3064fb6cd9 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -15,6 +15,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/regmap.h>
 #include <asm/unaligned.h>
 #include <linux/iio/common/st_sensors.h>
 
@@ -28,19 +29,10 @@ static inline u32 st_sensors_get_unaligned_le24(const u8 *p)
 int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
 				    u8 reg_addr, u8 mask, u8 data)
 {
-	int err;
-	u8 new_data;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	err = sdata->tf->read_byte(&sdata->tb, sdata->dev, reg_addr, &new_data);
-	if (err < 0)
-		goto st_sensors_write_data_with_mask_error;
-
-	new_data = ((new_data & (~mask)) | ((data << __ffs(mask)) & mask));
-	err = sdata->tf->write_byte(&sdata->tb, sdata->dev, reg_addr, new_data);
-
-st_sensors_write_data_with_mask_error:
-	return err;
+	return regmap_update_bits(sdata->regmap,
+				  reg_addr, mask, data << __ffs(mask));
 }
 
 int st_sensors_debugfs_reg_access(struct iio_dev *indio_dev,
@@ -48,19 +40,15 @@ int st_sensors_debugfs_reg_access(struct iio_dev *indio_dev,
 				  unsigned *readval)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
-	u8 readdata;
 	int err;
 
 	if (!readval)
-		return sdata->tf->write_byte(&sdata->tb, sdata->dev,
-					     (u8)reg, (u8)writeval);
+		return regmap_write(sdata->regmap, reg, writeval);
 
-	err = sdata->tf->read_byte(&sdata->tb, sdata->dev, (u8)reg, &readdata);
+	err = regmap_read(sdata->regmap, reg, readval);
 	if (err < 0)
 		return err;
 
-	*readval = (unsigned)readdata;
-
 	return 0;
 }
 EXPORT_SYMBOL(st_sensors_debugfs_reg_access);
@@ -545,7 +533,7 @@ int st_sensors_set_fullscale_by_gain(struct iio_dev *indio_dev, int scale)
 EXPORT_SYMBOL(st_sensors_set_fullscale_by_gain);
 
 static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
-				struct iio_chan_spec const *ch, int *data)
+				     struct iio_chan_spec const *ch, int *data)
 {
 	int err;
 	u8 *outdata;
@@ -554,13 +542,12 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 
 	byte_for_channel = DIV_ROUND_UP(ch->scan_type.realbits +
 					ch->scan_type.shift, 8);
-	outdata = kmalloc(byte_for_channel, GFP_KERNEL);
+	outdata = kmalloc(byte_for_channel, GFP_DMA | GFP_KERNEL);
 	if (!outdata)
 		return -ENOMEM;
 
-	err = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
-				ch->address, byte_for_channel,
-				outdata, sdata->multiread_bit);
+	err = regmap_bulk_read(sdata->regmap, ch->address,
+			       outdata, byte_for_channel);
 	if (err < 0)
 		goto st_sensors_free_memory;
 
@@ -645,13 +632,11 @@ EXPORT_SYMBOL(st_sensors_get_settings_index);
 int st_sensors_verify_id(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
-	int err;
-	u8 wai;
+	int wai, err;
 
-	if (settings->wai_addr) {
-		err = sdata->tf->read_byte(&sdata->tb, sdata->dev,
-					   sdata->sensor_settings->wai_addr,
-					   &wai);
+	if (sdata->sensor_settings->wai_addr) {
+		err = regmap_read(sdata->regmap,
+				  sdata->sensor_settings->wai_addr, &wai);
 		if (err < 0) {
 			dev_err(&indio_dev->dev,
 				"failed to read Who-Am-I register.\n");
diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index b1c9812407e7..9240625534df 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -13,6 +13,7 @@
 #include <linux/iio/iio.h>
 #include <linux/of_device.h>
 #include <linux/acpi.h>
+#include <linux/regmap.h>
 
 #include <linux/iio/common/st_sensors_i2c.h>
 
@@ -26,55 +27,51 @@ static unsigned int st_sensors_i2c_get_irq(struct iio_dev *indio_dev)
 	return to_i2c_client(sdata->dev)->irq;
 }
 
-static int st_sensors_i2c_read_byte(struct st_sensor_transfer_buffer *tb,
-				struct device *dev, u8 reg_addr, u8 *res_byte)
-{
-	int err;
-
-	err = i2c_smbus_read_byte_data(to_i2c_client(dev), reg_addr);
-	if (err < 0)
-		goto st_accel_i2c_read_byte_error;
-
-	*res_byte = err & 0xff;
-
-st_accel_i2c_read_byte_error:
-	return err < 0 ? err : 0;
-}
-
-static int st_sensors_i2c_read_multiple_byte(
-		struct st_sensor_transfer_buffer *tb, struct device *dev,
-			u8 reg_addr, int len, u8 *data, bool multiread_bit)
-{
-	if (multiread_bit)
-		reg_addr |= ST_SENSORS_I2C_MULTIREAD;
-
-	return i2c_smbus_read_i2c_block_data_or_emulated(to_i2c_client(dev),
-							 reg_addr, len, data);
-}
-
-static int st_sensors_i2c_write_byte(struct st_sensor_transfer_buffer *tb,
-				struct device *dev, u8 reg_addr, u8 data)
-{
-	return i2c_smbus_write_byte_data(to_i2c_client(dev), reg_addr, data);
-}
+static const struct regmap_config st_sensors_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
 
-static const struct st_sensor_transfer_function st_sensors_tf_i2c = {
-	.read_byte = st_sensors_i2c_read_byte,
-	.write_byte = st_sensors_i2c_write_byte,
-	.read_multiple_byte = st_sensors_i2c_read_multiple_byte,
+static const struct regmap_config st_sensors_i2c_regmap_multiread_bit_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.read_flag_mask = ST_SENSORS_I2C_MULTIREAD,
 };
 
-void st_sensors_i2c_configure(struct iio_dev *indio_dev,
-		struct i2c_client *client, struct st_sensor_data *sdata)
+/*
+ * st_sensors_i2c_configure() - configure I2C interface
+ * @indio_dev: IIO device reference.
+ * @client: i2c client reference.
+ *
+ * Return: 0 on success, else a negative error code.
+ */
+int st_sensors_i2c_configure(struct iio_dev *indio_dev,
+			     struct i2c_client *client)
 {
+	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	const struct regmap_config *config;
+
+	if (sdata->sensor_settings->multi_read_bit)
+		config = &st_sensors_i2c_regmap_multiread_bit_config;
+	else
+		config = &st_sensors_i2c_regmap_config;
+
+	sdata->regmap = devm_regmap_init_i2c(client, config);
+	if (IS_ERR(sdata->regmap)) {
+		dev_err(&client->dev, "Failed to register i2c regmap (%d)\n",
+			(int)PTR_ERR(sdata->regmap));
+		return PTR_ERR(sdata->regmap);
+	}
+
 	i2c_set_clientdata(client, indio_dev);
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = client->name;
 
 	sdata->dev = &client->dev;
-	sdata->tf = &st_sensors_tf_i2c;
 	sdata->get_irq_data_ready = st_sensors_i2c_get_irq;
+
+	return 0;
 }
 EXPORT_SYMBOL(st_sensors_i2c_configure);
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index a57cd648975c..9c0661a283d0 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -11,12 +11,12 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/iio/iio.h>
+#include <linux/regmap.h>
 
 #include <linux/iio/common/st_sensors_spi.h>
-
+#include "st_sensors_core.h"
 
 #define ST_SENSORS_SPI_MULTIREAD	0xc0
-#define ST_SENSORS_SPI_READ		0x80
 
 static unsigned int st_sensors_spi_get_irq(struct iio_dev *indio_dev)
 {
@@ -25,81 +25,15 @@ static unsigned int st_sensors_spi_get_irq(struct iio_dev *indio_dev)
 	return to_spi_device(sdata->dev)->irq;
 }
 
-static int st_sensors_spi_read(struct st_sensor_transfer_buffer *tb,
-	struct device *dev, u8 reg_addr, int len, u8 *data, bool multiread_bit)
-{
-	int err;
-
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = tb->tx_buf,
-			.bits_per_word = 8,
-			.len = 1,
-		},
-		{
-			.rx_buf = tb->rx_buf,
-			.bits_per_word = 8,
-			.len = len,
-		}
-	};
-
-	mutex_lock(&tb->buf_lock);
-	if ((multiread_bit) && (len > 1))
-		tb->tx_buf[0] = reg_addr | ST_SENSORS_SPI_MULTIREAD;
-	else
-		tb->tx_buf[0] = reg_addr | ST_SENSORS_SPI_READ;
-
-	err = spi_sync_transfer(to_spi_device(dev), xfers, ARRAY_SIZE(xfers));
-	if (err)
-		goto acc_spi_read_error;
-
-	memcpy(data, tb->rx_buf, len);
-	mutex_unlock(&tb->buf_lock);
-	return len;
-
-acc_spi_read_error:
-	mutex_unlock(&tb->buf_lock);
-	return err;
-}
-
-static int st_sensors_spi_read_byte(struct st_sensor_transfer_buffer *tb,
-				struct device *dev, u8 reg_addr, u8 *res_byte)
-{
-	return st_sensors_spi_read(tb, dev, reg_addr, 1, res_byte, false);
-}
-
-static int st_sensors_spi_read_multiple_byte(
-	struct st_sensor_transfer_buffer *tb, struct device *dev,
-			u8 reg_addr, int len, u8 *data, bool multiread_bit)
-{
-	return st_sensors_spi_read(tb, dev, reg_addr, len, data, multiread_bit);
-}
-
-static int st_sensors_spi_write_byte(struct st_sensor_transfer_buffer *tb,
-				struct device *dev, u8 reg_addr, u8 data)
-{
-	int err;
-
-	struct spi_transfer xfers = {
-		.tx_buf = tb->tx_buf,
-		.bits_per_word = 8,
-		.len = 2,
-	};
-
-	mutex_lock(&tb->buf_lock);
-	tb->tx_buf[0] = reg_addr;
-	tb->tx_buf[1] = data;
-
-	err = spi_sync_transfer(to_spi_device(dev), &xfers, 1);
-	mutex_unlock(&tb->buf_lock);
-
-	return err;
-}
+static const struct regmap_config st_sensors_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
 
-static const struct st_sensor_transfer_function st_sensors_tf_spi = {
-	.read_byte = st_sensors_spi_read_byte,
-	.write_byte = st_sensors_spi_write_byte,
-	.read_multiple_byte = st_sensors_spi_read_multiple_byte,
+static const struct regmap_config st_sensors_spi_regmap_multiread_bit_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.read_flag_mask = ST_SENSORS_SPI_MULTIREAD,
 };
 
 /*
@@ -155,6 +89,7 @@ int st_sensors_spi_configure(struct iio_dev *indio_dev,
 			     struct spi_device *spi)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	const struct regmap_config *config;
 	int err;
 
 	if (st_sensors_is_spi_3_wire(spi)) {
@@ -164,13 +99,24 @@ int st_sensors_spi_configure(struct iio_dev *indio_dev,
 			return err;
 	}
 
+	if (sdata->sensor_settings->multi_read_bit)
+		config = &st_sensors_spi_regmap_multiread_bit_config;
+	else
+		config = &st_sensors_spi_regmap_config;
+
+	sdata->regmap = devm_regmap_init_spi(spi, config);
+	if (IS_ERR(sdata->regmap)) {
+		dev_err(&spi->dev, "Failed to register spi regmap (%d)\n",
+			(int)PTR_ERR(sdata->regmap));
+		return PTR_ERR(sdata->regmap);
+	}
+
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi->modalias;
 
 	sdata->dev = &spi->dev;
-	sdata->tf = &st_sensors_tf_spi;
 	sdata->get_irq_data_ready = st_sensors_spi_get_irq;
 
 	return 0;
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 630c8cb35e8b..bed7b8682b17 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -13,6 +13,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 #include <linux/interrupt.h>
+#include <linux/regmap.h>
 #include <linux/iio/common/st_sensors.h>
 #include "st_sensors_core.h"
 
@@ -26,8 +27,7 @@
 static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
 					    struct st_sensor_data *sdata)
 {
-	u8 status;
-	int ret;
+	int ret, status;
 
 	/* How would I know if I can't check it? */
 	if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
@@ -37,9 +37,9 @@ static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
 	if (!indio_dev->active_scan_mask)
 		return 0;
 
-	ret = sdata->tf->read_byte(&sdata->tb, sdata->dev,
-			sdata->sensor_settings->drdy_irq.stat_drdy.addr,
-			&status);
+	ret = regmap_read(sdata->regmap,
+			  sdata->sensor_settings->drdy_irq.stat_drdy.addr,
+			  &status);
 	if (ret < 0) {
 		dev_err(sdata->dev,
 			"error checking samples available\n");
diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index 6e362f735e92..21360681d4dd 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -39,7 +39,8 @@ static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
 	int err;
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
 
-	gdata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	gdata->buffer_data = kmalloc(indio_dev->scan_bytes,
+				     GFP_DMA | GFP_KERNEL);
 	if (gdata->buffer_data == NULL) {
 		err = -ENOMEM;
 		goto allocate_memory_error;
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 4b87e79aa744..02e42c945181 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -12,7 +12,6 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/types.h>
-#include <linux/mutex.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
@@ -394,7 +393,6 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &gyro_info;
-	mutex_init(&gdata->tb.buf_lock);
 
 	err = st_sensors_power_enable(indio_dev);
 	if (err)
@@ -405,7 +403,6 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 		goto st_gyro_power_off;
 
 	gdata->num_data_channels = ST_GYRO_NUMBER_DATA_CHANNELS;
-	gdata->multiread_bit = gdata->sensor_settings->multi_read_bit;
 	indio_dev->channels = gdata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index fa71e94b76f4..05a1a0874bd5 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -87,7 +87,9 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 	gdata = iio_priv(indio_dev);
 	gdata->sensor_settings = (struct st_sensor_settings *)settings;
 
-	st_sensors_i2c_configure(indio_dev, client, gdata);
+	err = st_sensors_i2c_configure(indio_dev, client);
+	if (err < 0)
+		return err;
 
 	err = st_gyro_common_probe(indio_dev);
 	if (err < 0)
diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 11d7806655bc..9dba93539a99 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -34,7 +34,8 @@ static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 	int err;
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
 
-	mdata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	mdata->buffer_data = kmalloc(indio_dev->scan_bytes,
+				     GFP_DMA | GFP_KERNEL);
 	if (mdata->buffer_data == NULL) {
 		err = -ENOMEM;
 		goto allocate_memory_error;
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 3f313aefece6..804353a483c7 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -12,7 +12,6 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/types.h>
-#include <linux/mutex.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
@@ -496,7 +495,6 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &magn_info;
-	mutex_init(&mdata->tb.buf_lock);
 
 	err = st_sensors_power_enable(indio_dev);
 	if (err)
@@ -507,7 +505,6 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 		goto st_magn_power_off;
 
 	mdata->num_data_channels = ST_MAGN_NUMBER_DATA_CHANNELS;
-	mdata->multiread_bit = mdata->sensor_settings->multi_read_bit;
 	indio_dev->channels = mdata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index d5d565639bed..fdba480a12be 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -79,7 +79,9 @@ static int st_magn_i2c_probe(struct i2c_client *client,
 	mdata = iio_priv(indio_dev);
 	mdata->sensor_settings = (struct st_sensor_settings *)settings;
 
-	st_sensors_i2c_configure(indio_dev, client, mdata);
+	err = st_sensors_i2c_configure(indio_dev, client);
+	if (err < 0)
+		return err;
 
 	err = st_magn_common_probe(indio_dev);
 	if (err < 0)
diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
index 4566e08a64a1..f21b630abaa0 100644
--- a/drivers/iio/pressure/st_pressure_buffer.c
+++ b/drivers/iio/pressure/st_pressure_buffer.c
@@ -39,7 +39,8 @@ static int st_press_buffer_postenable(struct iio_dev *indio_dev)
 	int err;
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
 
-	press_data->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	press_data->buffer_data = kmalloc(indio_dev->scan_bytes,
+					  GFP_DMA | GFP_KERNEL);
 	if (press_data->buffer_data == NULL) {
 		err = -ENOMEM;
 		goto allocate_memory_error;
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index a783fc075c26..9ef92a501286 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -12,7 +12,6 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/types.h>
-#include <linux/mutex.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
@@ -692,7 +691,6 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &press_info;
-	mutex_init(&press_data->tb.buf_lock);
 
 	err = st_sensors_power_enable(indio_dev);
 	if (err)
@@ -709,7 +707,6 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 	 * element.
 	 */
 	press_data->num_data_channels = press_data->sensor_settings->num_ch - 1;
-	press_data->multiread_bit = press_data->sensor_settings->multi_read_bit;
 	indio_dev->channels = press_data->sensor_settings->ch;
 	indio_dev->num_channels = press_data->sensor_settings->num_ch;
 
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 466e7dde5eae..71d2ed6b4948 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -112,7 +112,9 @@ static int st_press_i2c_probe(struct i2c_client *client,
 	press_data = iio_priv(indio_dev);
 	press_data->sensor_settings = (struct st_sensor_settings *)settings;
 
-	st_sensors_i2c_configure(indio_dev, client, press_data);
+	ret = st_sensors_i2c_configure(indio_dev, client);
+	if (ret < 0)
+		return ret;
 
 	ret = st_press_common_probe(indio_dev);
 	if (ret < 0)
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 566b955e2980..28fc1f9fa7d5 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -16,6 +16,7 @@
 #include <linux/iio/trigger.h>
 #include <linux/bitops.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
 
 #include <linux/platform_data/st_sensors_pdata.h>
 
@@ -169,36 +170,6 @@ struct st_sensor_data_ready_irq {
 	} ig1;
 };
 
-/**
- * struct st_sensor_transfer_buffer - ST sensor device I/O buffer
- * @buf_lock: Mutex to protect rx and tx buffers.
- * @tx_buf: Buffer used by SPI transfer function to send data to the sensors.
- *	This buffer is used to avoid DMA not-aligned issue.
- * @rx_buf: Buffer used by SPI transfer to receive data from sensors.
- *	This buffer is used to avoid DMA not-aligned issue.
- */
-struct st_sensor_transfer_buffer {
-	struct mutex buf_lock;
-	u8 rx_buf[ST_SENSORS_RX_MAX_LENGTH];
-	u8 tx_buf[ST_SENSORS_TX_MAX_LENGTH] ____cacheline_aligned;
-};
-
-/**
- * struct st_sensor_transfer_function - ST sensor device I/O function
- * @read_byte: Function used to read one byte.
- * @write_byte: Function used to write one byte.
- * @read_multiple_byte: Function used to read multiple byte.
- */
-struct st_sensor_transfer_function {
-	int (*read_byte) (struct st_sensor_transfer_buffer *tb,
-				struct device *dev, u8 reg_addr, u8 *res_byte);
-	int (*write_byte) (struct st_sensor_transfer_buffer *tb,
-				struct device *dev, u8 reg_addr, u8 data);
-	int (*read_multiple_byte) (struct st_sensor_transfer_buffer *tb,
-		struct device *dev, u8 reg_addr, int len, u8 *data,
-							bool multiread_bit);
-};
-
 /**
  * struct st_sensor_settings - ST specific sensor settings
  * @wai: Contents of WhoAmI register.
@@ -242,16 +213,14 @@ struct st_sensor_settings {
  * @current_fullscale: Maximum range of measure by the sensor.
  * @vdd: Pointer to sensor's Vdd power supply
  * @vdd_io: Pointer to sensor's Vdd-IO power supply
+ * @regmap: Pointer to specific sensor regmap configuration.
  * @enabled: Status of the sensor (false->off, true->on).
- * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
  * @buffer_data: Data used by buffer part.
  * @odr: Output data rate of the sensor [Hz].
  * num_data_channels: Number of data channels used in buffer.
  * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
  * @int_pin_open_drain: Set the interrupt/DRDY to open drain.
  * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
- * @tf: Transfer function structure used by I/O operations.
- * @tb: Transfer buffers and mutex used by I/O operations.
  * @edge_irq: the IRQ triggers on edges and need special handling.
  * @hw_irq_trigger: if we're using the hardware interrupt on the sensor.
  * @hw_timestamp: Latest timestamp from the interrupt handler, when in use.
@@ -264,9 +233,9 @@ struct st_sensor_data {
 	struct st_sensor_fullscale_avl *current_fullscale;
 	struct regulator *vdd;
 	struct regulator *vdd_io;
+	struct regmap *regmap;
 
 	bool enabled;
-	bool multiread_bit;
 
 	char *buffer_data;
 
@@ -278,9 +247,6 @@ struct st_sensor_data {
 
 	unsigned int (*get_irq_data_ready) (struct iio_dev *indio_dev);
 
-	const struct st_sensor_transfer_function *tf;
-	struct st_sensor_transfer_buffer tb;
-
 	bool edge_irq;
 	bool hw_irq_trigger;
 	s64 hw_timestamp;
diff --git a/include/linux/iio/common/st_sensors_i2c.h b/include/linux/iio/common/st_sensors_i2c.h
index 5ada89944698..01e424e2af4f 100644
--- a/include/linux/iio/common/st_sensors_i2c.h
+++ b/include/linux/iio/common/st_sensors_i2c.h
@@ -14,8 +14,8 @@
 #include <linux/iio/common/st_sensors.h>
 #include <linux/of.h>
 
-void st_sensors_i2c_configure(struct iio_dev *indio_dev,
-		struct i2c_client *client, struct st_sensor_data *sdata);
+int st_sensors_i2c_configure(struct iio_dev *indio_dev,
+			     struct i2c_client *client);
 
 #ifdef CONFIG_ACPI
 int st_sensors_match_acpi_device(struct device *dev);
-- 
2.22.0

