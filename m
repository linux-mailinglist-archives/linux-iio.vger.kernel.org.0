Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1046F3F0066
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 11:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhHRJ2p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 05:28:45 -0400
Received: from first.geanix.com ([116.203.34.67]:37260 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231769AbhHRJ2h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Aug 2021 05:28:37 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 62C97440E26;
        Wed, 18 Aug 2021 09:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1629278878; bh=3oQPaB7fw73JQseoKRVBdxU4lIDDdfS4UVgzJHoINHE=;
        h=From:To:Cc:Subject:Date;
        b=dtPX2V9k21B4QvAGqgXljbVd/s6RQ3guWD+zxKwLtAuXK3ynltqjiQAriTS0EX10F
         CzkE50T6nOi9+rzi8y8AYkvTGexYUertShdcMS3A4oGQMr0u3fQArYdbXzn+h4hM+I
         cVV1NHVz/EJUOiezpoUm4HA8rPA5N7TuCQTWQtMTWetpRM1uhizbiyTIUJUyOYS2iX
         UaftBSHY72C4tDmW2qul/lS2UFS1mlf/V2/AS8+BdabWQfHjYtluRV7Opsk2EY1g73
         mDTf/pVsFgKwMyVefnZ3+bZdA5+qzjRrZxn4FgNqAFz8hw45lUYearqNquSbzPnELs
         8dSwXId4fw7Jg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: accel: fxls8962af: add threshold event handling
Date:   Wed, 18 Aug 2021 11:27:40 +0200
Message-Id: <20210818092741.2114155-1-sean@geanix.com>
X-Mailer: git-send-email 2.32.0
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

Add event channels that controls the creation of motion events.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 257 +++++++++++++++++++++++++++-
 1 file changed, 255 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 6b36eb362d07..1b97c82b5b05 100644
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
@@ -451,6 +463,18 @@ static int fxls8962af_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int fxls8962af_event_setup(struct fxls8962af_data *data, int state)
+{
+	int ret;
+
+	/* Enable wakeup interrupt */
+	ret = regmap_update_bits(data->regmap, FXLS8962AF_INT_EN,
+				 FXLS8962AF_INT_EN_SDCD_OT_EN,
+				 state ? FXLS8962AF_INT_EN_SDCD_OT_EN : 0);
+
+	return ret;
+}
+
 static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
 {
 	struct fxls8962af_data *data = iio_priv(indio_dev);
@@ -463,6 +487,182 @@ static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
 	return 0;
 }
 
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
+			       &raw_val, (chan->scan_type.storagebits / 8));
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
+	int is_active;
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
+	/* Add the same value to the lower-threshold register with a reversed sign */
+	data->lower_thres = (-val & 0x80000000) >> 20 | (val & 0x7FF);
+	data->upper_thres = (val & 0x80000000) >> 20 | (val & 0x7FF);
+
+	is_active = fxls8962af_is_active(data);
+	if (is_active) {
+		ret = fxls8962af_standby(data);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_LTHS_LSB,
+				&data->lower_thres, (chan->scan_type.storagebits / 8));
+	ret = regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_UTHS_LSB,
+				&data->upper_thres, (chan->scan_type.storagebits / 8));
+
+	if (is_active)
+		ret = fxls8962af_active(data);
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
+	int ret;
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		ret = FXLS8962AF_SDCD_CONFIG1_X_OT_EN & data->enable_event;
+		break;
+	case IIO_MOD_Y:
+		ret = FXLS8962AF_SDCD_CONFIG1_Y_OT_EN & data->enable_event;
+		break;
+	case IIO_MOD_Z:
+		ret = FXLS8962AF_SDCD_CONFIG1_Z_OT_EN & data->enable_event;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return !!ret;
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
+	ret = regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG2, enable_event > 0 ? 0xC0 : 0x00);
+	if (ret)
+		return ret;
+
+	ret = fxls8962af_event_setup(data, state);
+	if (ret)
+		return ret;
+
+	data->enable_event = enable_event;
+
+	if (data->enable_event > 0) {
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
+	.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			 BIT(IIO_EV_INFO_ENABLE)
+};
+
 #define FXLS8962AF_CHANNEL(axis, reg, idx) { \
 	.type = IIO_ACCEL, \
 	.address = reg, \
@@ -481,6 +681,8 @@ static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
 		.shift = 4, \
 		.endianness = IIO_BE, \
 	}, \
+	.event_spec = &fxls8962af_event, \
+	.num_event_specs = 1, \
 }
 
 #define FXLS8962AF_TEMP_CHANNEL { \
@@ -522,6 +724,10 @@ static const struct iio_info fxls8962af_info = {
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
@@ -605,7 +811,8 @@ static int fxls8962af_buffer_predisable(struct iio_dev *indio_dev)
 
 	ret = __fxls8962af_fifo_set_mode(data, false);
 
-	fxls8962af_active(data);
+	if (data->enable_event)
+		fxls8962af_active(data);
 
 	return ret;
 }
@@ -614,7 +821,10 @@ static int fxls8962af_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct fxls8962af_data *data = iio_priv(indio_dev);
 
-	return fxls8962af_power_off(data);
+	if (data->enable_event == 0)
+		fxls8962af_power_off(data);
+
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops fxls8962af_buffer_ops = {
@@ -725,6 +935,41 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
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
+	if (ret | (reg < 0))
+		return -EINVAL;
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
@@ -744,6 +989,14 @@ static irqreturn_t fxls8962af_interrupt(int irq, void *p)
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
2.32.0

