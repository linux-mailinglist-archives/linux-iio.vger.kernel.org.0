Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890AB36EA77
	for <lists+linux-iio@lfdr.de>; Thu, 29 Apr 2021 14:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbhD2M3J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Apr 2021 08:29:09 -0400
Received: from first.geanix.com ([116.203.34.67]:50672 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233731AbhD2M3I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Apr 2021 08:29:08 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 97F18466697;
        Thu, 29 Apr 2021 12:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1619699299; bh=9KNwoN/9slPsT4i6pDC3pLpd9Ibh66p8L4fF3y6OuDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=M5cl237IskeBgudhtsPMMBGFxTAEr/48TpWY0Td6CdAEa9oBbXCiYM6FXxcYK9Byl
         HqGuTwQhavRBasOm5ST8VP0UFkZr1VdnzdDHCVFHYCYmfBm8nLEKZL64vjN4G7Vn8+
         c6k2hwLZgzhqo3o1ccP6lNjkZ2axpMXlpXTXB6yMf2cCzugOxvpfpsiMbO0Tym1Du6
         Lvs2srsolHzREbcap0gMI9/ednIZOdunbMi4bdYGPgT7WaQEFFZUOQQV12MnExOlJg
         9/zZc6MrfeKPthhylRLHXFaCWmIf752g+NMhkRqjLAMl5IUS0TxQEa+t7R6oLxnBJv
         tkFmrQERJ85sQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v4 5/6] iio: accel: fxls8962af: add hw buffered sampling
Date:   Thu, 29 Apr 2021 14:28:05 +0200
Message-Id: <20210429122806.3814330-5-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210429122806.3814330-1-sean@geanix.com>
References: <20210429122806.3814330-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When buffered sampling is enabled, the accelerometer will dump data into
the internal fifo and interrupt at watermark. Then the driver flushes
all data to the iio buffer.
As the accelerometer doesn't have internal timestamps, they are approximated
between the current and last interrupt.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes from RFC:
 - Dropped the claim stuff for read_raw
 - Added watermark get/set
 - Consistent use of u16 for buffer size

 drivers/iio/accel/fxls8962af-core.c | 208 ++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 3696546fe23a..2e863ef71a7d 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -20,13 +20,17 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
 
 #include "fxls8962af.h"
 
 #define FXLS8962AF_INT_STATUS			0x00
 #define FXLS8962AF_INT_STATUS_SRC_BOOT		BIT(0)
+#define FXLS8962AF_INT_STATUS_SRC_BUF		BIT(5)
 #define FXLS8962AF_INT_STATUS_SRC_DRDY		BIT(7)
 #define FXLS8962AF_TEMP_OUT			0x01
 #define FXLS8962AF_VECM_LSB			0x02
@@ -34,6 +38,9 @@
 #define FXLS8962AF_OUT_Y_LSB			0x06
 #define FXLS8962AF_OUT_Z_LSB			0x08
 #define FXLS8962AF_BUF_STATUS			0x0b
+#define FXLS8962AF_BUF_STATUS_BUF_CNT		GENMASK(5, 0)
+#define FXLS8962AF_BUF_STATUS_BUF_OVF		BIT(6)
+#define FXLS8962AF_BUF_STATUS_BUF_WMRK		BIT(7)
 #define FXLS8962AF_BUF_X_LSB			0x0c
 #define FXLS8962AF_BUF_Y_LSB			0x0e
 #define FXLS8962AF_BUF_Z_LSB			0x10
@@ -66,6 +73,7 @@
 #define FXLS8962AF_ASLP_COUNT_LSB		0x1e
 
 #define FXLS8962AF_INT_EN			0x20
+#define FXLS8962AF_INT_EN_BUF_EN		BIT(6)
 #define FXLS8962AF_INT_PIN_SEL			0x21
 #define FXLS8962AF_INT_PIN_SEL_MASK		GENMASK(7, 0)
 #define FXLS8962AF_INT_PIN_SEL_INT1		0x00
@@ -76,7 +84,10 @@
 #define FXLS8962AF_OFF_Z			0x24
 
 #define FXLS8962AF_BUF_CONFIG1			0x26
+#define FXLS8962AF_BC1_BUF_MODE_MASK		GENMASK(6, 5)
+#define FXLS8962AF_BC1_BUF_MODE_PREP(x)		FIELD_PREP(FXLS8962AF_BC1_BUF_MODE_MASK, (x))
 #define FXLS8962AF_BUF_CONFIG2			0x27
+#define FXLS8962AF_BUF_CONFIG2_BUF_WMRK		GENMASK(5, 0)
 
 #define FXLS8962AF_ORIENT_STATUS		0x28
 #define FXLS8962AF_ORIENT_CONFIG		0x29
@@ -106,6 +117,7 @@
 
 #define FXLS8962AF_AUTO_SUSPEND_DELAY_MS	2000
 
+#define FXLS8962AF_FIFO_LENGTH			32
 #define FXLS8962AF_SCALE_TABLE_LEN		4
 #define FXLS8962AF_SAMP_FREQ_TABLE_LEN		13
 
@@ -133,7 +145,13 @@ struct fxls8962af_data {
 	struct regmap *regmap;
 	const struct fxls8962af_chip_info *chip_info;
 	struct regulator *vdd_reg;
+	struct {
+		__le16 channels[3];
+		s64 ts __aligned(8);
+	} scan;
+	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
 	struct iio_mount_matrix orientation;
+	u8 watermark;
 };
 
 const struct regmap_config fxls8962af_regmap_conf = {
@@ -436,6 +454,18 @@ static int fxls8962af_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
+{
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+
+	if (val > FXLS8962AF_FIFO_LENGTH)
+		val = FXLS8962AF_FIFO_LENGTH;
+
+	data->watermark = val;
+
+	return 0;
+}
+
 #define FXLS8962AF_CHANNEL(axis, reg, idx) { \
 	.type = IIO_ACCEL, \
 	.address = reg, \
@@ -496,6 +526,7 @@ static const struct iio_info fxls8962af_info = {
 	.write_raw = &fxls8962af_write_raw,
 	.write_raw_get_fmt = fxls8962af_write_raw_get_fmt,
 	.read_avail = fxls8962af_read_avail,
+	.hwfifo_set_watermark = fxls8962af_set_watermark,
 };
 
 static int fxls8962af_reset(struct fxls8962af_data *data)
@@ -519,6 +550,158 @@ static int fxls8962af_reset(struct fxls8962af_data *data)
 	return ret;
 }
 
+static int __fxls8962af_fifo_set_mode(struct fxls8962af_data *data, bool onoff)
+{
+	int ret;
+
+	/* Enable watermark at max fifo size*/
+	ret = regmap_update_bits(data->regmap, FXLS8962AF_BUF_CONFIG2,
+				 FXLS8962AF_BUF_CONFIG2_BUF_WMRK,
+				 data->watermark);
+	if (ret < 0)
+		return ret;
+
+	return regmap_update_bits(data->regmap, FXLS8962AF_BUF_CONFIG1,
+				  FXLS8962AF_BC1_BUF_MODE_MASK,
+				  FXLS8962AF_BC1_BUF_MODE_PREP(onoff));
+}
+
+static int fxls8962af_buffer_preenable(struct iio_dev *indio_dev)
+{
+	return fxls8962af_power_on(iio_priv(indio_dev));
+}
+
+static int fxls8962af_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	int ret;
+
+	fxls8962af_standby(data);
+
+	/* Enable buffer interrupt*/
+	ret = regmap_update_bits(data->regmap, FXLS8962AF_INT_EN,
+				 FXLS8962AF_INT_EN_BUF_EN,
+				 FXLS8962AF_INT_EN_BUF_EN);
+	if (ret < 0)
+		return ret;
+
+	ret = __fxls8962af_fifo_set_mode(data, true);
+
+	fxls8962af_active(data);
+
+	return ret;
+}
+
+static int fxls8962af_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	fxls8962af_standby(data);
+
+	/* Disable buffer interrupt*/
+	ret = regmap_update_bits(data->regmap, FXLS8962AF_INT_EN,
+			FXLS8962AF_INT_EN_BUF_EN, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = __fxls8962af_fifo_set_mode(data, false);
+
+	fxls8962af_active(data);
+
+	return ret;
+}
+
+static int fxls8962af_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+
+	return fxls8962af_power_off(data);
+}
+
+static const struct iio_buffer_setup_ops fxls8962af_buffer_ops = {
+	.preenable = fxls8962af_buffer_preenable,
+	.postenable = fxls8962af_buffer_postenable,
+	.predisable = fxls8962af_buffer_predisable,
+	.postdisable = fxls8962af_buffer_postdisable,
+};
+
+static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
+				    u16 *buffer, int samples)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int sample_length = 3 * sizeof(*buffer);
+	int ret;
+	int total_length = samples * sample_length;
+
+	ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB, buffer,
+			      total_length);
+	if (ret < 0)
+		dev_err(dev, "Error transferring data from fifo: %d\n", ret);
+
+	return ret;
+}
+
+static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
+{
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	u16 buffer[FXLS8962AF_FIFO_LENGTH * 3];
+	uint64_t sample_period;
+	unsigned int reg;
+	int64_t tstamp;
+	int ret, i;
+	u8 count;
+
+	ret = regmap_read(data->regmap, FXLS8962AF_BUF_STATUS, &reg);
+	if (ret < 0)
+		return ret;
+
+	if (reg & FXLS8962AF_BUF_STATUS_BUF_OVF) {
+		dev_err(dev, "Buffer overflown");
+		return -1;
+	}
+
+	count = reg & FXLS8962AF_BUF_STATUS_BUF_CNT;
+
+	if (!count)
+		return 0;
+
+	data->old_timestamp = data->timestamp;
+	data->timestamp = iio_get_time_ns(indio_dev);
+
+	/*
+	 * Approximate timestamps for each of the sample based on the sampling,
+	 * frequency, timestamp for last sample and number of samples.
+	 */
+	sample_period = (data->timestamp - data->old_timestamp);
+	do_div(sample_period, count);
+	tstamp = data->timestamp - (count - 1) * sample_period;
+
+	ret = fxls8962af_fifo_transfer(data, buffer, count);
+	if (ret)
+		return ret;
+
+	/* Demux hw FIFO into kfifo. */
+	for (i = 0; i < count; i++) {
+		int j, bit;
+
+		j = 0;
+		for_each_set_bit(bit, indio_dev->active_scan_mask,
+				 indio_dev->masklength) {
+			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
+			       sizeof(data->scan.channels[0]));
+		}
+
+		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+						   tstamp);
+
+		tstamp += sample_period;
+	}
+
+	return count;
+}
+
 static irqreturn_t fxls8962af_interrupt(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
@@ -530,9 +713,32 @@ static irqreturn_t fxls8962af_interrupt(int irq, void *p)
 	if (ret < 0)
 		return IRQ_NONE;
 
+	if (reg & FXLS8962AF_INT_STATUS_SRC_BUF) {
+		ret = fxls8962af_fifo_flush(indio_dev);
+		if (ret < 0)
+			return IRQ_NONE;
+
+		return IRQ_HANDLED;
+	}
+
 	return IRQ_NONE;
 }
 
+static int fxls8962af_fifo_setup(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer;
+
+	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
+	if (!buffer)
+		return -ENOMEM;
+
+	iio_device_attach_buffer(indio_dev, buffer);
+	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
+	indio_dev->setup_ops = &fxls8962af_buffer_ops;
+
+	return 0;
+}
+
 static void fxls8962af_regulator_disable(void *data_ptr)
 {
 	struct fxls8962af_data *data = data_ptr;
@@ -693,6 +899,8 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 		ret = fxls8962af_irq_setup(indio_dev, irq);
 		if (ret < 0)
 			return ret;
+
+		fxls8962af_fifo_setup(indio_dev);
 	}
 
 	ret = pm_runtime_set_active(dev);
-- 
2.31.0

