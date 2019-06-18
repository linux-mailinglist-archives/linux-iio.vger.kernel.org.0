Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2FF4A14D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 14:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfFRM77 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 08:59:59 -0400
Received: from first.geanix.com ([116.203.34.67]:37318 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfFRM76 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Jun 2019 08:59:58 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 3F349DBE;
        Tue, 18 Jun 2019 12:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560862788; bh=Ibs+xg2iidERhxby47XStXsjJp+Lb1p22viTWAbMrhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=V9OEXykJ/0RWrKGrReuUK6kMyOiLpWTlPlNZlsRQ4tlABtyTg4Q0y7LLnYR43sR+/
         8v0Akk1BUcWQzZI6EZcGb6g/x/feOxGnVVculC6PexuKP86dMfsBIP5FKeEpsTz6ia
         wfPY8/eCSdDUspABeKRD+ImyOfNxY6OfYHpwdY8zK0jiLgy4CeTU/ac0nQ8aBdAccB
         rGWCEk28z3//ytuwbEML5PxfMddcF4i9aDWpTfiUbv3ydm9teGuGvSIgJVCwb8TXGs
         N6wh2wobn5pxRRkynDUH6WzVwYdE2g51WLJn6GYM29BzPRtUc83Gt8pLPVFb73Q8rH
         B9T/W4YLGajgg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        martin@geanix.com
Subject: [PATCH 2/5] iio: imu: st_lsm6dsx: add motion events
Date:   Tue, 18 Jun 2019 14:59:36 +0200
Message-Id: <20190618125939.105903-3-sean@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618125939.105903-1-sean@geanix.com>
References: <20190618125939.105903-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 884f5ce5917a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add event channels that controls the creation of motion events.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 148 ++++++++++++++++++-
 2 files changed, 144 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index a5e373680e9c..966cc6e91c7f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -155,6 +155,8 @@ struct st_lsm6dsx_hw {
 	u8 enable_mask;
 	u8 ts_sip;
 	u8 sip;
+	u8 event_threshold;
+	bool enable_event;
 
 	u8 *buff;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index b5d3fa354de7..351c46f01662 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -78,6 +78,17 @@
 #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
 #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
 
+#define ST_LSM6DSX_REG_TAP_CFG_ADDR		0x58
+#define ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK	BIT(7)
+#define ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK	GENMASK(6, 5)
+
+#define ST_LSM6DSX_DEFAULT_WAKE_THRESH		0
+#define ST_LSM6DSX_REG_WAKE_UP_THS_ADDR		0x5B
+#define ST_LSM6DSX_REG_WAKE_UP_THS_THRES_MASK	GENMASK(5, 0)
+
+#define ST_LSM6DSX_REG_MD1_CFG_ADDR		0x5E
+#define ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK	BIT(5)
+
 #define ST_LSM6DSX_ACC_FS_2G_GAIN		IIO_G_TO_M_S_2(61)
 #define ST_LSM6DSX_ACC_FS_4G_GAIN		IIO_G_TO_M_S_2(122)
 #define ST_LSM6DSX_ACC_FS_8G_GAIN		IIO_G_TO_M_S_2(244)
@@ -303,6 +314,13 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 };
 
+static const struct iio_event_spec st_lsm6dsx_event = {
+	.type = IIO_EV_TYPE_THRESH,
+	.dir = IIO_EV_DIR_EITHER,
+	.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			 BIT(IIO_EV_INFO_ENABLE)
+};
+
 #define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
 {									\
 	.type = chan_type,						\
@@ -319,6 +337,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 		.storagebits = 16,					\
 		.endianness = IIO_LE,					\
 	},								\
+	.event_spec = &st_lsm6dsx_event,				\
+	.num_event_specs = 1,						\
 }
 
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
@@ -435,6 +455,20 @@ static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
 				  ST_LSM6DSX_SHIFT_VAL(val, reg->mask));
 }
 
+static int st_lsm6dsx_set_event_threshold(struct st_lsm6dsx_hw *hw, u8 threshold)
+{
+	int err = 0;
+
+	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_WAKE_UP_THS_ADDR,
+				 ST_LSM6DSX_REG_WAKE_UP_THS_THRES_MASK,
+				 threshold);
+
+	if (!err)
+		hw->event_threshold = threshold;
+
+	return err;
+}
+
 int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor)
 {
 	int err;
@@ -472,18 +506,21 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	int err, delay;
 	__le16 data;
 
-	err = st_lsm6dsx_sensor_enable(sensor);
-	if (err < 0)
-		return err;
+	if (!hw->enable_event) {
+		err = st_lsm6dsx_sensor_enable(sensor);
+		if (err < 0)
+			return err;
 
-	delay = 1000000 / sensor->odr;
-	usleep_range(delay, 2 * delay);
+		delay = 1000000 / sensor->odr;
+		usleep_range(delay, 2 * delay);
+	}
 
 	err = regmap_bulk_read(hw->regmap, addr, &data, sizeof(data));
 	if (err < 0)
 		return err;
 
-	st_lsm6dsx_sensor_disable(sensor);
+	if (!hw->enable_event)
+		st_lsm6dsx_sensor_disable(sensor);
 
 	*val = (s16)le16_to_cpu(data);
 
@@ -556,6 +593,75 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 	return err;
 }
 
+static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int *val, int *val2)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+
+	*val2 = 0;
+	*val = sensor->hw->event_threshold;
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
+
+	if (!hw->enable_event)
+		return -EBUSY;
+
+	if ((val < 0) || (val > 31))
+		return -EINVAL;
+
+	if (st_lsm6dsx_set_event_threshold(sensor->hw, val))
+		return -EINVAL;
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
+
+	if (state && hw->enable_event)
+		return 0;
+
+	hw->enable_event = state;
+	if (state)
+		st_lsm6dsx_sensor_enable(sensor);
+	else
+		st_lsm6dsx_sensor_disable(sensor);
+
+	return 0;
+}
+
 static int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
@@ -632,6 +738,10 @@ static const struct iio_info st_lsm6dsx_acc_info = {
 	.attrs = &st_lsm6dsx_acc_attribute_group,
 	.read_raw = st_lsm6dsx_read_raw,
 	.write_raw = st_lsm6dsx_write_raw,
+	.read_event_value = st_lsm6dsx_read_event,
+	.write_event_value = st_lsm6dsx_write_event,
+	.read_event_config = st_lsm6dsx_read_event_config,
+	.write_event_config = st_lsm6dsx_write_event_config,
 	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
 };
 
@@ -761,6 +871,8 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 	if (err < 0)
 		return err;
 
+	st_lsm6dsx_set_event_threshold(hw, ST_LSM6DSX_DEFAULT_WAKE_THRESH);
+
 	return st_lsm6dsx_init_hw_timer(hw);
 }
 
@@ -811,6 +923,27 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	return iio_dev;
 }
 
+int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw)
+{
+	int err;
+
+	/* Enable inactivity function - low power ACC, GYRO powered-down */
+	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_TAP_CFG_ADDR,
+				 ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK |
+				 ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK,
+				 ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK |
+				 ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK);
+	if (err < 0)
+		return err;
+
+	/* Enable wakeup interrupt */
+	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_MD1_CFG_ADDR,
+				 ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK,
+				 ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK);
+
+	return err;
+}
+
 static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
 {
 	struct st_lsm6dsx_hw *hw = private;
@@ -932,6 +1065,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 		err = st_lsm6dsx_fifo_setup(hw);
 		if (err < 0)
 			return err;
+		err = st_lsm6dsx_event_setup(hw);
+		if (err < 0)
+			return err;
 	}
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
-- 
2.22.0

