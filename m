Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F697A7F1A
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2019 11:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfIDJRr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Sep 2019 05:17:47 -0400
Received: from first.geanix.com ([116.203.34.67]:60366 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfIDJRr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Sep 2019 05:17:47 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 9FF7162F89;
        Wed,  4 Sep 2019 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567588657; bh=bXjudIY4mm313PblyUpO/mvVE1c2VLX8UD+pckYOQGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iFOKMORaDtsmjCDccLcqQ0HJ51Lv33LG1Frjvi6kALECHcaofMuoX98PqnisDxk4m
         5u7laQQ5MVKikiCoZViM6W1xYYUHvtcEAiTjFN1CJgbg2lVcLSpczPBmZjsny/fGRF
         pXeBcQ2wWelsQdL9/n75D018vmd8/GqyWUseHowgPuH6ePfgGk/BztNyf1eUZUVqEx
         IeaYmZ5UFK4VDNJ44yJHxsFDy0RQy5YcJa4AyYqfHgZryKj6lqAzzlQ17/fD3kqeYt
         IB1tq8AYrhfdpo4hthAbcA9/L83XXrWLoWyVaPcyR7I23vyzJEcW3yrpbuQrLQWZot
         d3Z7CuZhhOsvQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v3 2/6] iio: imu: st_lsm6dsx: add motion events
Date:   Wed,  4 Sep 2019 11:17:28 +0200
Message-Id: <20190904091732.112281-2-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904091732.112281-1-sean@geanix.com>
References: <20190904091732.112281-1-sean@geanix.com>
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

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since v1:
 * added handling of LSM6
 * added CHANNEL info with events for ACC
 * removed st_lsm6dsx_set_event_threshold function
 * added check of event type to event channels

Changes since v2:
 * added devices specific registers to st_lsm6dsx_sensor_settings
 * allow to write threshold when the events are disabled

How do we use the existing macro's when I want to expand them with
events for the accelerometer only?

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  43 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 156 +++++++++++++++++--
 2 files changed, 190 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 5e3cd96b0059..10f3191e8695 100644
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
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+			      BIT(IIO_CHAN_INFO_SCALE),			\
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
@@ -162,6 +183,13 @@ struct st_lsm6dsx_shub_settings {
 	u8 batch_en;
 };
 
+struct st_lsm6dsx_event_settings {
+	u8 enable_addr;
+	u8 enable_mask;
+	u8 wakeup_addr;
+	u8 wakeup_thres_mask;
+};
+
 enum st_lsm6dsx_ext_sensor_id {
 	ST_LSM6DSX_ID_MAGN,
 };
@@ -223,6 +251,9 @@ struct st_lsm6dsx_settings {
 	u8 wai;
 	u8 int1_addr;
 	u8 int2_addr;
+	u8 int1_func_addr;
+	u8 int2_func_addr;
+	u8 int_func_mask;
 	u8 reset_addr;
 	u16 max_fifo_size;
 	struct {
@@ -240,6 +271,7 @@ struct st_lsm6dsx_settings {
 	struct st_lsm6dsx_fifo_ops fifo_ops;
 	struct st_lsm6dsx_hw_ts_settings ts_settings;
 	struct st_lsm6dsx_shub_settings shub_settings;
+	struct st_lsm6dsx_event_settings event_settings;
 };
 
 enum st_lsm6dsx_sensor_id {
@@ -320,6 +352,10 @@ struct st_lsm6dsx_hw {
 	u8 ts_sip;
 	u8 sip;
 
+	u8 event_threshold;
+	bool enable_event;
+	struct st_lsm6dsx_reg irq_routing;
+
 	u8 *buff;
 
 	struct iio_dev *iio_devs[ST_LSM6DSX_ID_MAX];
@@ -327,6 +363,13 @@ struct st_lsm6dsx_hw {
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
index 8e0da5eb4283..d4d6ba934b6d 100644
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
 
@@ -392,6 +392,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 		.wai = 0x6a,
 		.int1_addr = 0x0d,
 		.int2_addr = 0x0e,
+		.int1_func_addr = 0x5e,
+		.int2_func_addr = 0x5f,
+		.int_func_mask = BIT(5),
 		.reset_addr = 0x12,
 		.max_fifo_size = 682,
 		.id = {
@@ -508,6 +511,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
+		.event_settings = {
+			.enable_addr = 0x58,
+			.enable_mask = BIT(7),
+			.wakeup_addr = 0x5B,
+			.wakeup_thres_mask = GENMASK(5, 0),
+		},
 	},
 	{
 		.wai = 0x6c,
@@ -1072,18 +1081,21 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	int err, delay;
 	__le16 data;
 
-	err = st_lsm6dsx_sensor_set_enable(sensor, true);
-	if (err < 0)
-		return err;
+	if (!hw->enable_event) {
+		err = st_lsm6dsx_sensor_set_enable(sensor, true);
+		if (err < 0)
+			return err;
 
-	delay = 1000000 / sensor->odr;
-	usleep_range(delay, 2 * delay);
+		delay = 1000000 / sensor->odr;
+		usleep_range(delay, 2 * delay);
+	}
 
 	err = st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));
 	if (err < 0)
 		return err;
 
-	st_lsm6dsx_sensor_set_enable(sensor, false);
+	if (!hw->enable_event)
+		st_lsm6dsx_sensor_set_enable(sensor, false);
 
 	*val = (s16)le16_to_cpu(data);
 
@@ -1156,6 +1168,124 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 	return err;
 }
 
+int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
+{
+	int err;
+	u8 enable = 0;
+
+	if (state)
+		enable = hw->settings->event_settings.enable_mask;
+
+	err = regmap_update_bits(hw->regmap,
+				 hw->settings->event_settings.enable_addr,
+				 hw->settings->event_settings.enable_mask,
+				 enable);
+	if (err < 0)
+		return err;
+
+	enable = 0;
+	if (state)
+		enable = hw->irq_routing.mask;
+
+	/* Enable wakeup interrupt */
+	err = regmap_update_bits(hw->regmap, hw->irq_routing.addr,
+				 hw->irq_routing.mask,
+				 enable);
+
+	return err;
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
+				 hw->settings->event_settings.wakeup_addr,
+				 hw->settings->event_settings.wakeup_thres_mask,
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
@@ -1240,6 +1370,10 @@ static const struct iio_info st_lsm6dsx_acc_info = {
 	.attrs = &st_lsm6dsx_acc_attribute_group,
 	.read_raw = st_lsm6dsx_read_raw,
 	.write_raw = st_lsm6dsx_write_raw,
+	.read_event_value = st_lsm6dsx_read_event,
+	.write_event_value = st_lsm6dsx_write_event,
+	.read_event_config = st_lsm6dsx_read_event_config,
+	.write_event_config = st_lsm6dsx_write_event_config,
 	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
 };
 
@@ -1285,9 +1419,13 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
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

