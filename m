Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE4AAD5FC
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 11:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfIIJpR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 05:45:17 -0400
Received: from first.geanix.com ([116.203.34.67]:49132 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389017AbfIIJpR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 05:45:17 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id DDFC26E016;
        Mon,  9 Sep 2019 09:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568022285; bh=q64nM7GE5TJMIXwEMqH4ueogqUHHCfCpeHDJhaY9VnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QRTYp1SR5h79uQ8TFq2btOO01GrWh+k1OYYAOdW0NpjHTo4tQVuiv+RlSNeywURCE
         m71cY4OqZgOwHabvV7urY2SnQuezvW+sq3zW9akGW/P4+LlK6lfXFXVUOd4KvDKOo+
         kgwsLsR0CZ1Xa4Wtm6dZgerVSLkdMOZ8bj8toOiQ6tswUw/16NdBN0R0txEVmlSqZ+
         NT0UQ6TivacSKzBk5AUuS+4BB3ZBK106mAaVEN1r04xmEr44L0Efc5uOJNm3Bxgwn6
         nnIEw5c146NsIUdwYmU+vkaFRk9QEwL3B5aQI4svm2a8+04qhIkYTAU1pRHO9/X1gc
         UeR+X2vNyMLUg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v5 2/6] iio: imu: st_lsm6dsx: add motion events
Date:   Mon,  9 Sep 2019 11:45:02 +0200
Message-Id: <20190909094506.51792-2-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909094506.51792-1-sean@geanix.com>
References: <20190909094506.51792-1-sean@geanix.com>
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

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  41 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 214 ++++++++++++++++++-
 2 files changed, 251 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 5e3cd96b0059..d04473861fba 100644
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
@@ -223,6 +249,9 @@ struct st_lsm6dsx_settings {
 	u8 wai;
 	u8 int1_addr;
 	u8 int2_addr;
+	u8 int1_func_addr;
+	u8 int2_func_addr;
+	u8 int_func_mask;
 	u8 reset_addr;
 	u16 max_fifo_size;
 	struct {
@@ -240,6 +269,7 @@ struct st_lsm6dsx_settings {
 	struct st_lsm6dsx_fifo_ops fifo_ops;
 	struct st_lsm6dsx_hw_ts_settings ts_settings;
 	struct st_lsm6dsx_shub_settings shub_settings;
+	struct st_lsm6dsx_event_settings event_settings;
 };
 
 enum st_lsm6dsx_sensor_id {
@@ -320,6 +350,10 @@ struct st_lsm6dsx_hw {
 	u8 ts_sip;
 	u8 sip;
 
+	u8 event_threshold;
+	bool enable_event;
+	struct st_lsm6dsx_reg irq_routing;
+
 	u8 *buff;
 
 	struct iio_dev *iio_devs[ST_LSM6DSX_ID_MAX];
@@ -327,6 +361,13 @@ struct st_lsm6dsx_hw {
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
index d0bcbbfb6297..fb83076d8f17 100644
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
@@ -275,11 +278,25 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
+		.event_settings = {
+			.wakeup_reg = {
+				.addr = 0x5B,
+				.mask = GENMASK(5, 0),
+			},
+			.wakeup_src_reg = 0x1b,
+			.wakeup_src_status_mask = BIT(3),
+			.wakeup_src_z_mask = BIT(0),
+			.wakeup_src_y_mask = BIT(1),
+			.wakeup_src_x_mask = BIT(2),
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
@@ -387,11 +404,25 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
+		.event_settings = {
+			.wakeup_reg = {
+				.addr = 0x5B,
+				.mask = GENMASK(5, 0),
+			},
+			.wakeup_src_reg = 0x1b,
+			.wakeup_src_status_mask = BIT(3),
+			.wakeup_src_z_mask = BIT(0),
+			.wakeup_src_y_mask = BIT(1),
+			.wakeup_src_x_mask = BIT(2),
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
@@ -508,6 +539,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -646,6 +687,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 		.wai = 0x6b,
 		.int1_addr = 0x0d,
 		.int2_addr = 0x0e,
+		.int1_func_addr = 0x5e,
+		.int2_func_addr = 0x5f,
+		.int_func_mask = BIT(5),
 		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
@@ -745,11 +789,29 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+			.wakeup_src_reg = 0x1b,
+			.wakeup_src_status_mask = BIT(3),
+			.wakeup_src_z_mask = BIT(0),
+			.wakeup_src_y_mask = BIT(1),
+			.wakeup_src_x_mask = BIT(2),
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
@@ -877,6 +939,21 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+			.wakeup_src_reg = 0x1b,
+			.wakeup_src_status_mask = BIT(3),
+			.wakeup_src_z_mask = BIT(0),
+			.wakeup_src_y_mask = BIT(1),
+			.wakeup_src_x_mask = BIT(2),
 		}
 	},
 };
@@ -1083,7 +1160,8 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
-	st_lsm6dsx_sensor_set_enable(sensor, false);
+	if (!hw->enable_event)
+		st_lsm6dsx_sensor_set_enable(sensor, false);
 
 	*val = (s16)le16_to_cpu(data);
 
@@ -1156,6 +1234,126 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
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
+	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS)
+		return -EBUSY;
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
@@ -1240,6 +1438,10 @@ static const struct iio_info st_lsm6dsx_acc_info = {
 	.attrs = &st_lsm6dsx_acc_attribute_group,
 	.read_raw = st_lsm6dsx_read_raw,
 	.write_raw = st_lsm6dsx_write_raw,
+	.read_event_value = st_lsm6dsx_read_event,
+	.write_event_value = st_lsm6dsx_write_event,
+	.read_event_config = st_lsm6dsx_read_event_config,
+	.write_event_config = st_lsm6dsx_write_event_config,
 	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
 };
 
@@ -1285,9 +1487,13 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
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

