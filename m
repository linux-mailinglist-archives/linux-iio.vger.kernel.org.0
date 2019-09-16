Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCE4B3BEE
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 15:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388192AbfIPN4j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 09:56:39 -0400
Received: from first.geanix.com ([116.203.34.67]:36388 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388106AbfIPN4j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 09:56:39 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 1BEB764782;
        Mon, 16 Sep 2019 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568642136; bh=4K//zh6W9SIOw6ecLl/IlqI6x2ZoJJgxQ5wa2+IVCOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hpgz9mql4ZRK/M1sdVrYjMum7aU06V9TiCN4n+Qb4PCqqo8yh87CiqDuu47JJNrYp
         bfbIWptTq1M5EwmfeR+VRET/yotHYJRtSiO1YRBhinCbjv4Hjreg2wa/AqW4rwnSd7
         sd+0zAiDSPAbyJ0QnlfE97gw8opdgiAt6M6MylLrx0cn8a4KGGf9PXxczSYCOBNQwG
         rWg9Pa1oTK+o5Kq6dbU6B+9rJ2Y5LizF8SYr/oAyoLVdS/xYTnlIS6yUxSrsDigO+g
         3pce0Lg5bM33xSNXrb4aXskh0VuAYP/5sxkKo4rkj/4NFF9aFnbk8sRcUJbU2ryQ0z
         3cGCb7YmrHKxw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v10 2/5] iio: imu: st_lsm6dsx: add motion events
Date:   Mon, 16 Sep 2019 15:56:27 +0200
Message-Id: <20190916135630.2211714-2-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190916135630.2211714-1-sean@geanix.com>
References: <20190916135630.2211714-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=4.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add event channels that controls the creation of motion events.
Tested on ISM330DLC

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since v4:
 * Added check for event support
 * Added registers for more devices that support this event

Changes since v5:
 * Moved wakeup_src masks to PATCH 5/6

Changes since v6:
 * None

Changes since v7:
 * None

Changes since v8:
 * None

Changes since v10:
 * enable_event changed to a u8

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  41 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 191 ++++++++++++++++++-
 2 files changed, 228 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 21d14072d1c6..6b0ba48394eb 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -12,6 +12,7 @@
 #define ST_LSM6DSX_H
 
 #include <linux/device.h>
+#include <linux/iio/iio.h>
 
 #define ST_LSM6DS3_DEV_NAME	"lsm6ds3"
 #define ST_LSM6DS3H_DEV_NAME	"lsm6ds3h"
@@ -54,6 +55,26 @@ enum st_lsm6dsx_hw_id {
 					 * ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
 #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
 
+#define ST_LSM6DSX_CHANNEL_ACC(chan_type, addr, mod, scan_idx)		\
+{									\
+	.type = chan_type,						\
+	.address = addr,						\
+	.modified = 1,							\
+	.channel2 = mod,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = scan_idx,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+	},								\
+	.event_spec = &st_lsm6dsx_event,				\
+	.num_event_specs = 1,						\
+}
+
 #define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
 {									\
 	.type = chan_type,						\
@@ -162,6 +183,11 @@ struct st_lsm6dsx_shub_settings {
 	u8 batch_en;
 };
 
+struct st_lsm6dsx_event_settings {
+	struct st_lsm6dsx_reg enable_reg;
+	struct st_lsm6dsx_reg wakeup_reg;
+};
+
 enum st_lsm6dsx_ext_sensor_id {
 	ST_LSM6DSX_ID_MAGN,
 };
@@ -225,6 +251,9 @@ struct st_lsm6dsx_settings {
 	u8 wai;
 	u8 int1_addr;
 	u8 int2_addr;
+	u8 int1_func_addr;
+	u8 int2_func_addr;
+	u8 int_func_mask;
 	u8 reset_addr;
 	u16 max_fifo_size;
 	struct {
@@ -244,6 +273,7 @@ struct st_lsm6dsx_settings {
 	struct st_lsm6dsx_fifo_ops fifo_ops;
 	struct st_lsm6dsx_hw_ts_settings ts_settings;
 	struct st_lsm6dsx_shub_settings shub_settings;
+	struct st_lsm6dsx_event_settings event_settings;
 };
 
 enum st_lsm6dsx_sensor_id {
@@ -324,6 +354,10 @@ struct st_lsm6dsx_hw {
 	u8 ts_sip;
 	u8 sip;
 
+	u8 event_threshold;
+	u8 enable_event;
+	struct st_lsm6dsx_reg irq_routing;
+
 	u8 *buff;
 
 	struct iio_dev *iio_devs[ST_LSM6DSX_ID_MAX];
@@ -331,6 +365,13 @@ struct st_lsm6dsx_hw {
 	const struct st_lsm6dsx_settings *settings;
 };
 
+static const struct iio_event_spec st_lsm6dsx_event = {
+	.type = IIO_EV_TYPE_THRESH,
+	.dir = IIO_EV_DIR_EITHER,
+	.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			 BIT(IIO_EV_INFO_ENABLE)
+};
+
 static const unsigned long st_lsm6dsx_available_scan_masks[] = {0x7, 0x0};
 extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index ef838206b30f..4198ba263d03 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -73,9 +73,9 @@
 #define ST_LSM6DSX_REG_PP_OD_MASK		BIT(4)
 
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
-	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
-	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
-	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
+	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
+	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
+	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
@@ -168,6 +168,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 		.wai = 0x69,
 		.int1_addr = 0x0d,
 		.int2_addr = 0x0e,
+		.int1_func_addr = 0x5e,
+		.int2_func_addr = 0x5f,
+		.int_func_mask = BIT(5),
 		.reset_addr = 0x12,
 		.max_fifo_size = 1365,
 		.id = {
@@ -279,11 +282,20 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
+		.event_settings = {
+			.wakeup_reg = {
+				.addr = 0x5B,
+				.mask = GENMASK(5, 0),
+			},
+		},
 	},
 	{
 		.wai = 0x69,
 		.int1_addr = 0x0d,
 		.int2_addr = 0x0e,
+		.int1_func_addr = 0x5e,
+		.int2_func_addr = 0x5f,
+		.int_func_mask = BIT(5),
 		.reset_addr = 0x12,
 		.max_fifo_size = 682,
 		.id = {
@@ -395,11 +407,20 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
+		.event_settings = {
+			.wakeup_reg = {
+				.addr = 0x5B,
+				.mask = GENMASK(5, 0),
+			},
+		},
 	},
 	{
 		.wai = 0x6a,
 		.int1_addr = 0x0d,
 		.int2_addr = 0x0e,
+		.int1_func_addr = 0x5e,
+		.int2_func_addr = 0x5f,
+		.int_func_mask = BIT(5),
 		.reset_addr = 0x12,
 		.max_fifo_size = 682,
 		.id = {
@@ -520,6 +541,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
+		.event_settings = {
+			.enable_reg = {
+				.addr = 0x58,
+				.mask = BIT(7),
+			},
+			.wakeup_reg = {
+				.addr = 0x5B,
+				.mask = GENMASK(5, 0),
+			},
+		},
 	},
 	{
 		.wai = 0x6c,
@@ -666,6 +697,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 		.wai = 0x6b,
 		.int1_addr = 0x0d,
 		.int2_addr = 0x0e,
+		.int1_func_addr = 0x5e,
+		.int2_func_addr = 0x5f,
+		.int_func_mask = BIT(5),
 		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
@@ -773,11 +807,24 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 6),
 			},
 		},
+		.event_settings = {
+			.enable_reg = {
+				.addr = 0x58,
+				.mask = BIT(7),
+			},
+			.wakeup_reg = {
+				.addr = 0x5B,
+				.mask = GENMASK(5, 0),
+			},
+		},
 	},
 	{
 		.wai = 0x6b,
 		.int1_addr = 0x0d,
 		.int2_addr = 0x0e,
+		.int1_func_addr = 0x5e,
+		.int2_func_addr = 0x5f,
+		.int_func_mask = BIT(5),
 		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
@@ -913,6 +960,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.slv0_addr = 0x15,
 			.dw_slv0_addr = 0x21,
 			.batch_en = BIT(3),
+		},
+		.event_settings = {
+			.enable_reg = {
+				.addr = 0x58,
+				.mask = BIT(7),
+			},
+			.wakeup_reg = {
+				.addr = 0x5B,
+				.mask = GENMASK(5, 0),
+			},
 		}
 	},
 };
@@ -1119,7 +1176,8 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
-	st_lsm6dsx_sensor_set_enable(sensor, false);
+	if (!hw->enable_event)
+		st_lsm6dsx_sensor_set_enable(sensor, false);
 
 	*val = (s16)le16_to_cpu(data);
 
@@ -1192,6 +1250,123 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 	return err;
 }
 
+int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
+{
+	int err;
+	u8 enable = 0;
+
+	if (!hw->settings->int1_func_addr)
+		return -ENOTSUPP;
+
+	enable = state ? hw->settings->event_settings.enable_reg.mask : 0;
+
+	err = regmap_update_bits(hw->regmap,
+				 hw->settings->event_settings.enable_reg.addr,
+				 hw->settings->event_settings.enable_reg.mask,
+				 enable);
+	if (err < 0)
+		return err;
+
+	enable = state ? hw->irq_routing.mask : 0;
+
+	/* Enable wakeup interrupt */
+	return regmap_update_bits(hw->regmap, hw->irq_routing.addr,
+				  hw->irq_routing.mask,
+				  enable);
+}
+
+static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int *val, int *val2)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	*val2 = 0;
+	*val = hw->event_threshold;
+
+	return IIO_VAL_INT;
+}
+
+static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int val, int val2)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+	int err;
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	if (val < 0 || val > 31)
+		return -EINVAL;
+
+	err = regmap_update_bits(hw->regmap,
+				 hw->settings->event_settings.wakeup_reg.addr,
+				 hw->settings->event_settings.wakeup_reg.mask,
+				 val);
+	if (err)
+		return -EINVAL;
+
+	hw->event_threshold = val;
+
+	return 0;
+}
+
+static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
+					  const struct iio_chan_spec *chan,
+					  enum iio_event_type type,
+					  enum iio_event_direction dir)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	return hw->enable_event;
+}
+
+static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
+					   const struct iio_chan_spec *chan,
+					   enum iio_event_type type,
+					   enum iio_event_direction dir,
+					   int state)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+	int err = 0;
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	/* do not enable events if they are already enabled */
+	if (state && hw->enable_event)
+		return 0;
+
+	err = st_lsm6dsx_event_setup(hw, state);
+	if (err < 0)
+		return err;
+
+	err = st_lsm6dsx_sensor_set_enable(sensor, state);
+	if (err < 0)
+		return err;
+
+	hw->enable_event = state;
+
+	return 0;
+}
+
 int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
@@ -1276,6 +1451,10 @@ static const struct iio_info st_lsm6dsx_acc_info = {
 	.attrs = &st_lsm6dsx_acc_attribute_group,
 	.read_raw = st_lsm6dsx_read_raw,
 	.write_raw = st_lsm6dsx_write_raw,
+	.read_event_value = st_lsm6dsx_read_event,
+	.write_event_value = st_lsm6dsx_write_event,
+	.read_event_config = st_lsm6dsx_read_event_config,
+	.write_event_config = st_lsm6dsx_write_event_config,
 	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
 };
 
@@ -1321,9 +1500,13 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
 	switch (drdy_pin) {
 	case 1:
 		*drdy_reg = hw->settings->int1_addr;
+		hw->irq_routing.addr = hw->settings->int1_func_addr;
+		hw->irq_routing.mask = hw->settings->int_func_mask;
 		break;
 	case 2:
 		*drdy_reg = hw->settings->int2_addr;
+		hw->irq_routing.addr = hw->settings->int2_func_addr;
+		hw->irq_routing.mask = hw->settings->int_func_mask;
 		break;
 	default:
 		dev_err(hw->dev, "unsupported data ready pin\n");
-- 
2.23.0

