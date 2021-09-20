Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAD44113AF
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 13:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhITLn5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 07:43:57 -0400
Received: from first.geanix.com ([116.203.34.67]:37314 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhITLn5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Sep 2021 07:43:57 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 13473ADDE2;
        Mon, 20 Sep 2021 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1632138148; bh=TyRN7pDrQf1BsSzW8SBQ0RsFq50DzBZEy4XL0B1LErg=;
        h=From:To:Cc:Subject:Date;
        b=AVF3mBOCEYtkxBh8w2KTzYELaEqcQR5JoNaK+B7tnsRl18atFa9EA/KuU9BIHbrYY
         7BC8OtMTDMK4h0LCNL+ChHEsaZpzArgcJvtrnodoIeFwxgiyD0LHz31zlKiUaB80EF
         dFDCr/YUBmiHBxCICIIDnsXlJrJXMC09eImVIJBVFX4FJYYzOov5X4REfzaIHFMiIv
         0RvB/rxKeYwEIcBOjf5gFptSozXFjadNtnpBTbG0zcl5i8dZeQC5geghL1EtcV6B9i
         izFUJF66KBUm4pUhKXfSN9KdSbKw/9iYzKRdCpT2TaVWlR4zFcPQ+M60O/Rx89cv8j
         RJcdoSYUrzP7A==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org
Subject: [PATCH v5 1/2] iio: accel: fxls8962af: add threshold event handling
Date:   Mon, 20 Sep 2021 13:42:20 +0200
Message-Id: <20210920114221.1595543-1-sean@geanix.com>
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
Changes since v4:
 - moved return into switches and if's to reduce code size
 - done nothing about the error paths :) If a write fails, the next one
   will most likely fail as well...
 - Fixed iio_device_claim_direct_mode() in write_event_config()

 drivers/iio/accel/fxls8962af-core.c | 301 +++++++++++++++++++++++++++-
 1 file changed, 298 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index f41db9e0249a..b55b73fbfe4e 100644
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
@@ -96,9 +99,21 @@
 #define FXLS8962AF_ORIENT_THS_REG		0x2c
 
 #define FXLS8962AF_SDCD_INT_SRC1		0x2d
+#define FXLS8962AF_SDCD_INT_SRC1_X_OT		BIT(5)
+#define FXLS8962AF_SDCD_INT_SRC1_X_POL		BIT(4)
+#define FXLS8962AF_SDCD_INT_SRC1_Y_OT		BIT(3)
+#define FXLS8962AF_SDCD_INT_SRC1_Y_POL		BIT(2)
+#define FXLS8962AF_SDCD_INT_SRC1_Z_OT		BIT(1)
+#define FXLS8962AF_SDCD_INT_SRC1_Z_POL		BIT(0)
 #define FXLS8962AF_SDCD_INT_SRC2		0x2e
 #define FXLS8962AF_SDCD_CONFIG1			0x2f
+#define FXLS8962AF_SDCD_CONFIG1_Z_OT_EN		BIT(3)
+#define FXLS8962AF_SDCD_CONFIG1_Y_OT_EN		BIT(4)
+#define FXLS8962AF_SDCD_CONFIG1_X_OT_EN		BIT(5)
+#define FXLS8962AF_SDCD_CONFIG1_OT_ELE		BIT(7)
 #define FXLS8962AF_SDCD_CONFIG2			0x30
+#define FXLS8962AF_SDCD_CONFIG2_SDCD_EN		BIT(7)
+#define FXLS8962AF_SC2_REF_UPDM_AC		GENMASK(6, 5)
 #define FXLS8962AF_SDCD_OT_DBCNT		0x31
 #define FXLS8962AF_SDCD_WT_DBCNT		0x32
 #define FXLS8962AF_SDCD_LTHS_LSB		0x33
@@ -152,6 +167,9 @@ struct fxls8962af_data {
 	int64_t timestamp, old_timestamp;	/* Only used in hw fifo mode. */
 	struct iio_mount_matrix orientation;
 	u8 watermark;
+	u8 enable_event;
+	u16 lower_thres;
+	u16 upper_thres;
 };
 
 const struct regmap_config fxls8962af_regmap_conf = {
@@ -238,7 +256,7 @@ static int fxls8962af_get_out(struct fxls8962af_data *data,
 	}
 
 	ret = regmap_bulk_read(data->regmap, chan->address,
-			       &raw_val, (chan->scan_type.storagebits / 8));
+			       &raw_val, sizeof(data->lower_thres));
 
 	if (!is_active)
 		fxls8962af_power_off(data);
@@ -451,6 +469,15 @@ static int fxls8962af_write_raw(struct iio_dev *indio_dev,
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
@@ -463,6 +490,217 @@ static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
 	return 0;
 }
 
+static int __fxls8962af_set_thresholds(struct fxls8962af_data *data,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_direction dir,
+				       int val)
+{
+	switch (dir) {
+	case IIO_EV_DIR_FALLING:
+		data->lower_thres = val;
+		return regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_LTHS_LSB,
+				&data->lower_thres, sizeof(data->lower_thres));
+	case IIO_EV_DIR_RISING:
+		data->upper_thres = val;
+		return regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_UTHS_LSB,
+				&data->upper_thres, sizeof(data->upper_thres));
+	default:
+		return -EINVAL;
+	}
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
+	int ret;
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_FALLING:
+		ret = regmap_bulk_read(data->regmap, FXLS8962AF_SDCD_LTHS_LSB,
+				       &data->lower_thres, sizeof(data->lower_thres));
+		if (ret)
+			return ret;
+
+		*val = sign_extend32(data->lower_thres, chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	case IIO_EV_DIR_RISING:
+		ret = regmap_bulk_read(data->regmap, FXLS8962AF_SDCD_UTHS_LSB,
+				       &data->upper_thres, sizeof(data->upper_thres));
+		if (ret)
+			return ret;
+
+		*val = sign_extend32(data->upper_thres, chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
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
+	int ret, val_masked;
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	if (val < -2048 || val > 2047)
+		return -EINVAL;
+
+	if (data->enable_event)
+		return -EBUSY;
+
+	val_masked = val & GENMASK(11, 0);
+	if (fxls8962af_is_active(data)) {
+		ret = fxls8962af_standby(data);
+		if (ret)
+			return ret;
+
+		ret = __fxls8962af_set_thresholds(data, chan, dir, val_masked);
+		if (ret)
+			return ret;
+
+		return fxls8962af_active(data);
+	} else {
+		return __fxls8962af_set_thresholds(data, chan, dir, val_masked);
+	}
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
+		return !!(FXLS8962AF_SDCD_CONFIG1_X_OT_EN & data->enable_event);
+	case IIO_MOD_Y:
+		return !!(FXLS8962AF_SDCD_CONFIG1_Y_OT_EN & data->enable_event);
+	case IIO_MOD_Z:
+		return !!(FXLS8962AF_SDCD_CONFIG1_Z_OT_EN & data->enable_event);
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
+	int ret, value;
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
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
+	ret = fxls8962af_standby(data);
+	if (ret)
+		return ret;
+
+	/* Enable events */
+	value = enable_event | FXLS8962AF_SDCD_CONFIG1_OT_ELE;
+	ret = regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG1, value);
+	if (ret)
+		return ret;
+
+	/*
+	 * Enable update of SDCD_REF_X/Y/Z values with the current decimated and
+	 * trimmed X/Y/Z acceleration input data. This allows for acceleration
+	 * slope detection with Data(n) to Data(n–1) always used as the input
+	 * to the window comparator.
+	 */
+	value = enable_event ?
+		FXLS8962AF_SDCD_CONFIG2_SDCD_EN | FXLS8962AF_SC2_REF_UPDM_AC :
+		0x00;
+	ret = regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG2, value);
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
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		/* Not in buffered mode so disable power */
+		ret = fxls8962af_power_off(data);
+
+		iio_device_release_direct_mode(indio_dev);
+	}
+
+	return ret;
+}
+
+static const struct iio_event_spec fxls8962af_event[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 #define FXLS8962AF_CHANNEL(axis, reg, idx) { \
 	.type = IIO_ACCEL, \
 	.address = reg, \
@@ -481,6 +719,8 @@ static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
 		.shift = 4, \
 		.endianness = IIO_BE, \
 	}, \
+	.event_spec = fxls8962af_event, \
+	.num_event_specs = ARRAY_SIZE(fxls8962af_event), \
 }
 
 #define FXLS8962AF_TEMP_CHANNEL { \
@@ -522,6 +762,10 @@ static const struct iio_info fxls8962af_info = {
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
@@ -605,7 +849,8 @@ static int fxls8962af_buffer_predisable(struct iio_dev *indio_dev)
 
 	ret = __fxls8962af_fifo_set_mode(data, false);
 
-	fxls8962af_active(data);
+	if (data->enable_event)
+		fxls8962af_active(data);
 
 	return ret;
 }
@@ -614,7 +859,10 @@ static int fxls8962af_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct fxls8962af_data *data = iio_priv(indio_dev);
 
-	return fxls8962af_power_off(data);
+	if (!data->enable_event)
+		fxls8962af_power_off(data);
+
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops fxls8962af_buffer_ops = {
@@ -725,6 +973,45 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
 	return count;
 }
 
+static int fxls8962af_event_interrupt(struct iio_dev *indio_dev)
+{
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	s64 ts = iio_get_time_ns(indio_dev);
+	unsigned int reg;
+	u64 ev_code;
+	int ret;
+
+	ret = regmap_read(data->regmap, FXLS8962AF_SDCD_INT_SRC1, &reg);
+	if (ret)
+		return ret;
+
+	if (reg & FXLS8962AF_SDCD_INT_SRC1_X_OT) {
+		ev_code = reg & FXLS8962AF_SDCD_INT_SRC1_X_POL ?
+			IIO_EV_DIR_RISING : IIO_EV_DIR_FALLING;
+		iio_push_event(indio_dev,
+				IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
+					IIO_EV_TYPE_THRESH, ev_code), ts);
+	}
+
+	if (reg & FXLS8962AF_SDCD_INT_SRC1_Y_OT) {
+		ev_code = reg & FXLS8962AF_SDCD_INT_SRC1_Y_POL ?
+			IIO_EV_DIR_RISING : IIO_EV_DIR_FALLING;
+		iio_push_event(indio_dev,
+				IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
+					IIO_EV_TYPE_THRESH, ev_code), ts);
+	}
+
+	if (reg & FXLS8962AF_SDCD_INT_SRC1_Z_OT) {
+		ev_code = reg & FXLS8962AF_SDCD_INT_SRC1_Z_POL ?
+			IIO_EV_DIR_RISING : IIO_EV_DIR_FALLING;
+		iio_push_event(indio_dev,
+				IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
+					IIO_EV_TYPE_THRESH, ev_code), ts);
+	}
+
+	return 0;
+}
+
 static irqreturn_t fxls8962af_interrupt(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
@@ -744,6 +1031,14 @@ static irqreturn_t fxls8962af_interrupt(int irq, void *p)
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

