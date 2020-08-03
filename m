Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCB323AB92
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgHCRU4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 13:20:56 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12840 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727803AbgHCRUz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 13:20:55 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073H2u2b027348;
        Mon, 3 Aug 2020 13:20:54 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 32n6cjqhu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 13:20:54 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 073HKqvE047747
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 3 Aug 2020 13:20:53 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 3 Aug 2020
 10:20:51 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 3 Aug 2020 10:20:51 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 073HKlai008684;
        Mon, 3 Aug 2020 13:20:50 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v4 2/3] iio: accel: adxl372: add event interface
Date:   Mon, 3 Aug 2020 20:22:18 +0300
Message-ID: <20200803172219.33911-3-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200803172219.33911-1-alexandru.tachici@analog.com>
References: <20200803172219.33911-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_15:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Currently the driver configures adxl372 to work in loop mode.
The inactivity and activity timings  decide how fast the chip
will loop through the awake and waiting states and the
thresholds on x,y,z axis decide when activity or inactivity
will be detected.

This patch adds standard events sysfs entries for the inactivity
and activity timings: thresh_falling_period/thresh_rising_period
and for the in_accel_x_thresh_falling/rising_value.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/accel/adxl372.c | 256 +++++++++++++++++++++++++++++++++++-
 1 file changed, 250 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index cce25cde6252..644c409862b5 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -5,6 +5,7 @@
  * Copyright 2018 Analog Devices Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -113,6 +114,11 @@
 #define ADXL372_STATUS_1_AWAKE(x)		(((x) >> 6) & 0x1)
 #define ADXL372_STATUS_1_ERR_USR_REGS(x)	(((x) >> 7) & 0x1)
 
+/* ADXL372_STATUS_2 */
+#define ADXL372_STATUS_2_INACT(x)		(((x) >> 4) & 0x1)
+#define ADXL372_STATUS_2_ACT(x)			(((x) >> 5) & 0x1)
+#define ADXL372_STATUS_2_AC2(x)			(((x) >> 6) & 0x1)
+
 /* ADXL372_INT1_MAP */
 #define ADXL372_INT1_MAP_DATA_RDY_MSK		BIT(0)
 #define ADXL372_INT1_MAP_DATA_RDY_MODE(x)	(((x) & 0x1) << 0)
@@ -131,6 +137,14 @@
 #define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
 #define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
 
+/* ADX372_THRESH */
+#define ADXL372_THRESH_VAL_H_MSK		GENMASK(10, 3)
+#define ADXL372_THRESH_VAL_H_SEL(x)		\
+		FIELD_GET(ADXL372_THRESH_VAL_H_MSK, x)
+#define ADXL372_THRESH_VAL_L_MSK		GENMASK(2, 0)
+#define ADXL372_THRESH_VAL_L_SEL(x)		\
+		FIELD_GET(ADXL372_THRESH_VAL_L_MSK, x)
+
 /* The ADXL372 includes a deep, 512 sample FIFO buffer */
 #define ADXL372_FIFO_SIZE			512
 #define ADXL372_X_AXIS_EN(x)			(((x) >> 0) & 0x1)
@@ -225,6 +239,22 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	{ BIT(0) | BIT(1) | BIT(2), ADXL372_XYZ_FIFO },
 };
 
+static const struct iio_event_spec adxl372_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD) |
+				      BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD) |
+				      BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -241,6 +271,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 		.storagebits = 16,					\
 		.shift = 4,						\
 	},								\
+	.event_spec = adxl372_events,					\
+	.num_event_specs = ARRAY_SIZE(adxl372_events)			\
 }
 
 static const struct iio_chan_spec adxl372_channels[] = {
@@ -270,6 +302,7 @@ struct adxl372_state {
 	u16				watermark;
 	__be16				fifo_buf[ADXL372_FIFO_SIZE];
 	bool				peak_fifo_mode_en;
+	struct mutex			threshold_m; /* lock for threshold */
 };
 
 static const unsigned long adxl372_channel_masks[] = {
@@ -281,6 +314,49 @@ static const unsigned long adxl372_channel_masks[] = {
 	0
 };
 
+static ssize_t adxl372_read_threshold_value(struct iio_dev *indio_dev,
+					    unsigned int addr,
+					    u16 *threshold)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	__be16 raw_regval;
+	u16 regval;
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, addr, &raw_regval,
+			       sizeof(raw_regval));
+	if (ret < 0)
+		return ret;
+
+	regval = be16_to_cpu(raw_regval);
+	regval >>= 5;
+
+	*threshold = regval;
+
+	return 0;
+}
+
+static ssize_t adxl372_write_threshold_value(struct iio_dev *indio_dev,
+					     unsigned int addr,
+					     u16 threshold)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->threshold_m);
+	ret = regmap_write(st->regmap, addr,
+			   ADXL372_THRESH_VAL_H_SEL(threshold));
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, addr + 1, GENMASK(7, 5),
+				 ADXL372_THRESH_VAL_L_SEL(threshold) << 5);
+
+	mutex_unlock(&st->threshold_m);
+
+	return ret;
+}
+
 static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
 {
 	__be16 regval;
@@ -544,6 +620,27 @@ static void adxl372_arrange_axis_data(struct adxl372_state *st, __be16 *sample)
 	memcpy(sample, axis_sample, 3 * sizeof(__be16));
 }
 
+static void adxl372_push_event(struct iio_dev *indio_dev, s64 timestamp,
+			       u8 status2)
+{
+	unsigned int ev_dir = IIO_EV_DIR_NONE;
+
+	if (ADXL372_STATUS_2_ACT(status2))
+		ev_dir = IIO_EV_DIR_RISING;
+
+	if (ADXL372_STATUS_2_INACT(status2))
+		ev_dir = IIO_EV_DIR_FALLING;
+
+	if (ev_dir != IIO_EV_DIR_NONE)
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
+						  0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_THRESH,
+						  ev_dir),
+						  timestamp);
+}
+
 static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 {
 	struct iio_poll_func *pf = p;
@@ -557,6 +654,8 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 	if (ret < 0)
 		goto err;
 
+	adxl372_push_event(indio_dev, iio_get_time_ns(indio_dev), status2);
+
 	if (st->fifo_mode != ADXL372_FIFO_BYPASSED &&
 	    ADXL372_STATUS_1_FIFO_FULL(status1)) {
 		/*
@@ -748,6 +847,143 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl372_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	unsigned int addr;
+	u16 raw_value;
+	int ret;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			addr = ADXL372_X_THRESH_ACT_H + 2 * chan->scan_index;
+			ret = adxl372_read_threshold_value(indio_dev, addr,
+							   &raw_value);
+			if (ret < 0)
+				return ret;
+			*val = raw_value * ADXL372_USCALE;
+			*val2 = 1000000;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_EV_DIR_FALLING:
+			addr = ADXL372_X_THRESH_INACT_H + 2 * chan->scan_index;
+			ret =  adxl372_read_threshold_value(indio_dev, addr,
+							    &raw_value);
+			if (ret < 0)
+				return ret;
+			*val = raw_value * ADXL372_USCALE;
+			*val2 = 1000000;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_PERIOD:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			*val = st->act_time_ms;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_EV_DIR_FALLING:
+			*val = st->inact_time_ms;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl372_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	unsigned int val_ms;
+	unsigned int addr;
+	u16 raw_val;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		raw_val = DIV_ROUND_UP(val * 1000000, ADXL372_USCALE);
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			addr = ADXL372_X_THRESH_ACT_H + 2 * chan->scan_index;
+			return adxl372_write_threshold_value(indio_dev, addr,
+							     raw_val);
+		case IIO_EV_DIR_FALLING:
+			addr = ADXL372_X_THRESH_INACT_H + 2 * chan->scan_index;
+			return adxl372_write_threshold_value(indio_dev, addr,
+							     raw_val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_PERIOD:
+		val_ms = val * 1000 + DIV_ROUND_UP(val2, 1000);
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl372_set_activity_time_ms(st, val_ms);
+		case IIO_EV_DIR_FALLING:
+			return adxl372_set_inactivity_time_ms(st, val_ms);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl372_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return FIELD_GET(ADXL372_INT1_MAP_ACT_MSK, st->int1_bitmask);
+	case IIO_EV_DIR_FALLING:
+		return FIELD_GET(ADXL372_INT1_MAP_INACT_MSK, st->int1_bitmask);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl372_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      int state)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		set_mask_bits(&st->int1_bitmask, ADXL372_INT1_MAP_ACT_MSK,
+			      ADXL372_INT1_MAP_ACT_MODE(state));
+		break;
+	case IIO_EV_DIR_FALLING:
+		set_mask_bits(&st->int1_bitmask, ADXL372_INT1_MAP_INACT_MSK,
+			      ADXL372_INT1_MAP_INACT_MODE(state));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return adxl372_set_interrupts(st, st->int1_bitmask, 0);
+}
+
 static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
@@ -824,7 +1060,8 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
+	st->int1_bitmask |= ADXL372_INT1_MAP_FIFO_FULL_MSK;
+	ret = adxl372_set_interrupts(st, st->int1_bitmask, 0);
 	if (ret < 0)
 		goto err;
 
@@ -866,7 +1103,8 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 	ret = adxl372_configure_fifo(st);
 	if (ret < 0) {
 		st->fifo_mode = ADXL372_FIFO_BYPASSED;
-		adxl372_set_interrupts(st, 0, 0);
+		st->int1_bitmask &= ~ADXL372_INT1_MAP_FIFO_FULL_MSK;
+		adxl372_set_interrupts(st, st->int1_bitmask, 0);
 		goto err;
 	}
 
@@ -881,7 +1119,8 @@ static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct adxl372_state *st = iio_priv(indio_dev);
 
-	adxl372_set_interrupts(st, 0, 0);
+	st->int1_bitmask &= ~ADXL372_INT1_MAP_FIFO_FULL_MSK;
+	adxl372_set_interrupts(st, st->int1_bitmask, 0);
 	st->fifo_mode = ADXL372_FIFO_BYPASSED;
 	adxl372_configure_fifo(st);
 
@@ -898,12 +1137,11 @@ static int adxl372_dready_trig_set_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct adxl372_state *st = iio_priv(indio_dev);
-	unsigned long int mask = 0;
 
 	if (state)
-		mask = ADXL372_INT1_MAP_FIFO_FULL_MSK;
+		st->int1_bitmask |= ADXL372_INT1_MAP_FIFO_FULL_MSK;
 
-	return adxl372_set_interrupts(st, mask, 0);
+	return adxl372_set_interrupts(st, st->int1_bitmask, 0);
 }
 
 static int adxl372_validate_trigger(struct iio_dev *indio_dev,
@@ -960,6 +1198,10 @@ static const struct iio_info adxl372_info = {
 	.attrs = &adxl372_attrs_group,
 	.read_raw = adxl372_read_raw,
 	.write_raw = adxl372_write_raw,
+	.read_event_config = adxl372_read_event_config,
+	.write_event_config = adxl372_write_event_config,
+	.read_event_value = adxl372_read_event_value,
+	.write_event_value = adxl372_write_event_value,
 	.debugfs_reg_access = &adxl372_reg_access,
 	.hwfifo_set_watermark = adxl372_set_watermark,
 };
@@ -988,6 +1230,8 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 	st->regmap = regmap;
 	st->irq = irq;
 
+	mutex_init(&st->threshold_m);
+
 	indio_dev->channels = adxl372_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
 	indio_dev->available_scan_masks = adxl372_channel_masks;
-- 
2.20.1

