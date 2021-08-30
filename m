Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCB23FB23F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 10:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhH3ILg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 04:11:36 -0400
Received: from first.geanix.com ([116.203.34.67]:37280 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232776AbhH3ILg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 04:11:36 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 19429440FC1;
        Mon, 30 Aug 2021 08:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1630311041; bh=XjJlJ3rB4fac9w3qWVIG0ntVZGIEUq4KZLcFS/sIx+c=;
        h=From:To:Cc:Subject:Date;
        b=BsPanEv7o6q4qdh9p8heMKcb5YnrZMZKDt7E6oIlTeO0p3MZNAG/B4VEG5gB8/Fhh
         GUP+O8drVBgIOxgtA+LIlnlCoFqH8D9L0VX2HS+/ptUeOnFb71LlHO210AAh77PmgQ
         yRPjtNx9+7A04IiE/BJUm3bDODfU7pf6Wf0sq9tTXMQqm3Y/S6UniIfkVp82GuK2W1
         Z77JIH02TDSp7mzcf4+9CsboomIUoX/RRjuNMj/noXW2Q1Nb23i4GuKhzwMLjLlEWN
         Sq4fZFZ/Ff9TkVUzco0F8UgLuOKKDGPDjB8GOVUTmu/xsGCUi161Rv5zOP52ssSpzc
         bhbLl3GqDJZGg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org
Subject: [PATCH v3 1/2] iio: accel: fxls8962af: add threshold event handling
Date:   Mon, 30 Aug 2021 10:10:31 +0200
Message-Id: <20210830081032.267891-1-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add event channels that control the creation of motion events.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since v1/v2:
 - Fixed comments fron Andy (Thanks)
 - Corrected sign mess

 drivers/iio/accel/fxls8962af-core.c | 266 +++++++++++++++++++++++++++-
 1 file changed, 264 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 6b36eb362d07..dd639420fb0f 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -22,6 +22,7 @@
 #include <linux/regmap.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/sysfs.h>
@@ -30,6 +31,7 @@
 
 #define FXLS8962AF_INT_STATUS			0x00
 #define FXLS8962AF_INT_STATUS_SRC_BOOT		BIT(0)
+#define FXLS8962AF_INT_STATUS_SRC_SDCD_OT	BIT(4)
 #define FXLS8962AF_INT_STATUS_SRC_BUF		BIT(5)
 #define FXLS8962AF_INT_STATUS_SRC_DRDY		BIT(7)
 #define FXLS8962AF_TEMP_OUT			0x01
@@ -73,6 +75,7 @@
 #define FXLS8962AF_ASLP_COUNT_LSB		0x1e
 
 #define FXLS8962AF_INT_EN			0x20
+#define FXLS8962AF_INT_EN_SDCD_OT_EN		BIT(5)
 #define FXLS8962AF_INT_EN_BUF_EN		BIT(6)
 #define FXLS8962AF_INT_PIN_SEL			0x21
 #define FXLS8962AF_INT_PIN_SEL_MASK		GENMASK(7, 0)
@@ -96,8 +99,14 @@
 #define FXLS8962AF_ORIENT_THS_REG		0x2c
 
 #define FXLS8962AF_SDCD_INT_SRC1		0x2d
+#define FXLS8962AF_SDCD_INT_SRC1_X_OT		BIT(5)
+#define FXLS8962AF_SDCD_INT_SRC1_Y_OT		BIT(3)
+#define FXLS8962AF_SDCD_INT_SRC1_Z_OT		BIT(1)
 #define FXLS8962AF_SDCD_INT_SRC2		0x2e
 #define FXLS8962AF_SDCD_CONFIG1			0x2f
+#define FXLS8962AF_SDCD_CONFIG1_Z_OT_EN		BIT(3)
+#define FXLS8962AF_SDCD_CONFIG1_Y_OT_EN		BIT(4)
+#define FXLS8962AF_SDCD_CONFIG1_X_OT_EN		BIT(5)
 #define FXLS8962AF_SDCD_CONFIG2			0x30
 #define FXLS8962AF_SDCD_OT_DBCNT		0x31
 #define FXLS8962AF_SDCD_WT_DBCNT		0x32
@@ -152,6 +161,9 @@ struct fxls8962af_data {
 	int64_t timestamp, old_timestamp;	/* Only used in hw fifo mode. */
 	struct iio_mount_matrix orientation;
 	u8 watermark;
+	u8 enable_event;
+	u16 lower_thres;
+	u16 upper_thres;
 };
 
 const struct regmap_config fxls8962af_regmap_conf = {
@@ -451,6 +463,15 @@ static int fxls8962af_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int fxls8962af_event_setup(struct fxls8962af_data *data, int state)
+{
+	/* Enable wakeup interrupt */
+	int mask = FXLS8962AF_INT_EN_SDCD_OT_EN;
+	int value = state ? mask : 0;
+
+	return regmap_update_bits(data->regmap, FXLS8962AF_INT_EN, mask, value);
+}
+
 static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
 {
 	struct fxls8962af_data *data = iio_priv(indio_dev);
@@ -463,6 +484,194 @@ static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
 	return 0;
 }
 
+static int __fxls8962af_set_thresholds(struct fxls8962af_data *data,
+				       const struct iio_chan_spec *chan,
+				       int val)
+{
+	int ret;
+
+	/*
+	 * Add the same value to the lower-threshold register with a reversed sign
+	 * in 2-complement 12 bit format.
+	 */
+	data->lower_thres = -val & GENMASK(11, 0);
+	data->upper_thres = val & GENMASK(10, 0);
+
+	ret = regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_LTHS_LSB,
+				&data->lower_thres, chan->scan_type.storagebits / 8);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_UTHS_LSB,
+				&data->upper_thres, chan->scan_type.storagebits / 8);
+
+	return ret;
+}
+
+static int fxls8962af_read_event(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir,
+				 enum iio_event_info info,
+				 int *val, int *val2)
+{
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	u16 raw_val;
+	int ret;
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	/*
+	 * Read only upper-threshold register as the lower-threshold register have the
+	 * same value with reversed sign.
+	 */
+	ret = regmap_bulk_read(data->regmap, FXLS8962AF_SDCD_UTHS_LSB,
+			       &raw_val, chan->scan_type.storagebits / 8);
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(raw_val, chan->scan_type.realbits - 1);
+	*val2 = 0;
+
+	return IIO_VAL_INT;
+}
+
+static int fxls8962af_write_event(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  enum iio_event_type type,
+				  enum iio_event_direction dir,
+				  enum iio_event_info info,
+				  int val, int val2)
+{
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	if (val < 0 || val > 2047)
+		return -EINVAL;
+
+	if (data->enable_event)
+		return -EBUSY;
+
+
+	if (fxls8962af_is_active(data)) {
+		ret = fxls8962af_standby(data);
+		if (ret)
+			return ret;
+
+		ret = __fxls8962af_set_thresholds(data, chan, val);
+		if (ret)
+			return ret;
+
+		ret = fxls8962af_active(data);
+	} else {
+		ret = __fxls8962af_set_thresholds(data, chan, val);
+	}
+
+	return ret;
+}
+
+static int
+fxls8962af_read_event_config(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan,
+			     enum iio_event_type type,
+			     enum iio_event_direction dir)
+{
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		return FXLS8962AF_SDCD_CONFIG1_X_OT_EN & data->enable_event;
+	case IIO_MOD_Y:
+		return FXLS8962AF_SDCD_CONFIG1_Y_OT_EN & data->enable_event;
+	case IIO_MOD_Z:
+		return FXLS8962AF_SDCD_CONFIG1_Z_OT_EN & data->enable_event;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int
+fxls8962af_write_event_config(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      enum iio_event_type type,
+			      enum iio_event_direction dir, int state)
+{
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	u8 enable_event, enable_bits;
+	int ret;
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	fxls8962af_standby(data);
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		enable_bits = FXLS8962AF_SDCD_CONFIG1_X_OT_EN;
+		break;
+	case IIO_MOD_Y:
+		enable_bits = FXLS8962AF_SDCD_CONFIG1_Y_OT_EN;
+		break;
+	case IIO_MOD_Z:
+		enable_bits = FXLS8962AF_SDCD_CONFIG1_Z_OT_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (state)
+		enable_event = data->enable_event | enable_bits;
+	else
+		enable_event = data->enable_event & ~enable_bits;
+
+	if (data->enable_event == enable_event)
+		return 0;
+
+	/* Enable events */
+	ret = regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG1, enable_event | 0x80);
+	if (ret)
+		return ret;
+
+	/*
+	 * Enable update of SDCD_REF_X/Y/Z values with the current decimated and
+	 * trimmed X/Y/Z acceleration input data. This allows for acceleration
+	 * slope detection with Data(n) to Data(n–1) always used as the input
+	 * to the window comparator.
+	 */
+	ret = regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG2, enable_event ? 0xc0 : 0x00);
+	if (ret)
+		return ret;
+
+	ret = fxls8962af_event_setup(data, state);
+	if (ret)
+		return ret;
+
+	data->enable_event = enable_event;
+
+	if (data->enable_event) {
+		fxls8962af_active(data);
+		ret = fxls8962af_power_on(data);
+	} else {
+		if (!iio_buffer_enabled(indio_dev))
+			ret = fxls8962af_power_off(data);
+	}
+
+	return ret;
+}
+
+static const struct iio_event_spec fxls8962af_event = {
+	.type = IIO_EV_TYPE_THRESH,
+	.dir = IIO_EV_DIR_EITHER,
+	.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
+};
+
 #define FXLS8962AF_CHANNEL(axis, reg, idx) { \
 	.type = IIO_ACCEL, \
 	.address = reg, \
@@ -481,6 +690,8 @@ static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
 		.shift = 4, \
 		.endianness = IIO_BE, \
 	}, \
+	.event_spec = &fxls8962af_event, \
+	.num_event_specs = 1, \
 }
 
 #define FXLS8962AF_TEMP_CHANNEL { \
@@ -522,6 +733,10 @@ static const struct iio_info fxls8962af_info = {
 	.read_raw = &fxls8962af_read_raw,
 	.write_raw = &fxls8962af_write_raw,
 	.write_raw_get_fmt = fxls8962af_write_raw_get_fmt,
+	.read_event_value = fxls8962af_read_event,
+	.write_event_value = fxls8962af_write_event,
+	.read_event_config = fxls8962af_read_event_config,
+	.write_event_config = fxls8962af_write_event_config,
 	.read_avail = fxls8962af_read_avail,
 	.hwfifo_set_watermark = fxls8962af_set_watermark,
 };
@@ -605,7 +820,8 @@ static int fxls8962af_buffer_predisable(struct iio_dev *indio_dev)
 
 	ret = __fxls8962af_fifo_set_mode(data, false);
 
-	fxls8962af_active(data);
+	if (data->enable_event)
+		fxls8962af_active(data);
 
 	return ret;
 }
@@ -614,7 +830,10 @@ static int fxls8962af_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct fxls8962af_data *data = iio_priv(indio_dev);
 
-	return fxls8962af_power_off(data);
+	if (!data->enable_event)
+		fxls8962af_power_off(data);
+
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops fxls8962af_buffer_ops = {
@@ -725,6 +944,41 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
 	return count;
 }
 
+static int fxls8962af_event_interrupt(struct iio_dev *indio_dev)
+{
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	s64 ts = iio_get_time_ns(indio_dev);
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(data->regmap, FXLS8962AF_SDCD_INT_SRC1, &reg);
+	if (ret)
+		return ret;
+
+	if (reg & FXLS8962AF_SDCD_INT_SRC1_X_OT)
+		iio_push_event(indio_dev,
+				IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
+					IIO_EV_TYPE_THRESH,
+					IIO_EV_DIR_EITHER),
+				ts);
+
+	if (reg & FXLS8962AF_SDCD_INT_SRC1_Y_OT)
+		iio_push_event(indio_dev,
+				IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Y,
+					IIO_EV_TYPE_THRESH,
+					IIO_EV_DIR_EITHER),
+				ts);
+
+	if (reg & FXLS8962AF_SDCD_INT_SRC1_Z_OT)
+		iio_push_event(indio_dev,
+				IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Z,
+					IIO_EV_TYPE_THRESH,
+					IIO_EV_DIR_EITHER),
+				ts);
+
+	return ret;
+}
+
 static irqreturn_t fxls8962af_interrupt(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
@@ -744,6 +998,14 @@ static irqreturn_t fxls8962af_interrupt(int irq, void *p)
 		return IRQ_HANDLED;
 	}
 
+	if (reg & FXLS8962AF_INT_STATUS_SRC_SDCD_OT) {
+		ret = fxls8962af_event_interrupt(indio_dev);
+		if (ret < 0)
+			return IRQ_NONE;
+
+		return IRQ_HANDLED;
+	}
+
 	return IRQ_NONE;
 }
 
-- 
2.33.0

