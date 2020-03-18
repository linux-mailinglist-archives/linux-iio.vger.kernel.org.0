Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9377718979C
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 10:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgCRJKF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 05:10:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53520 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgCRJKF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 05:10:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id 25so2316499wmk.3;
        Wed, 18 Mar 2020 02:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YDmwUcQNRZhnkXHg+yuTVeVtIA4cniAPgojch/2lNOU=;
        b=Jh+4TsKYaf1i1yMYdz5ALeCspRk/X5iyzr8npeJYoInEnalBLU7eGre+6GnEOKXElH
         5d22oaDTEq9ICZcDPEUHbSw2oqdRfGNqEFPp3uDJGM+7yVBWmbOWejGcAd8w0+0a4dxx
         6Ntw1i5uj4DAD6pub5ymD3SIK0nULmnReDApnuC3/bEebminsuf2uvQaUUVjr8+MMNPv
         36RmijR+VtcLQAkOZeykDfQLtNt8sdKWD4iHGO/s2R2EU8z80zcH9zoEPE2mwvXnuAfF
         aShdgy/kbiJjZmn4zqvE6Xz4m0Zmx7M0eJga7OqYb/oOC2F7/tgFiM1sKw3NUFsS7Lsq
         XnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDmwUcQNRZhnkXHg+yuTVeVtIA4cniAPgojch/2lNOU=;
        b=O4N2fDQMdbTeGRAaJmaYeP08WXZfsNAepePE4UZIjyFtnrI1+ynCZBOhGCjr/kOvKO
         nRBRWvQzlMuQw3FdvxbdWv+a1/RXOScaEAoUongwnS++oT2rHK4aakvAI94kvNzkqEjg
         NVv0uGHYPtnT95J+mAyAtxgS2V9Qwg9IereBDGEsk4zRkLoGFMfDRoya4IT3o2tX4b0+
         1TYtxzEKb2VokwHFs5WOz9pg71gVEEPZmQrgnfT+f6o9YpURHnKZRmK07wpsTBtqtot/
         0g8qLk5g0jjqcfLBhrgmA4Ta1ZTQpVUW4olLkhI0EepBB/tsur/DifwGnzixWEddik+6
         qq+A==
X-Gm-Message-State: ANhLgQ3CWF9LQlN+NBU+wT5Gxthrv7U5IOaWQtCYr20zYA1dpPqBtbmW
        7yrvfCxfwH9PwP9wT0lWDQP2vI+IPNM=
X-Google-Smtp-Source: ADFU+vt/NNaIkO6ZN/Sz1RExtaZ2WhZF8IH1l87+tleUuBNZX0ct+tishaJ9FBcaN5HW1jt/7BZzuw==
X-Received: by 2002:a1c:26c4:: with SMTP id m187mr4060692wmm.43.1584522602335;
        Wed, 18 Mar 2020 02:10:02 -0700 (PDT)
Received: from localhost.localdomain ([95.77.248.51])
        by smtp.gmail.com with ESMTPSA id w1sm2823986wmc.11.2020.03.18.02.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 02:10:01 -0700 (PDT)
From:   Alexandru Tachici <tachicialex@gmail.com>
X-Google-Original-From: Alexandru Tachici <alexandru.tachici@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
Subject: [PATCH v3 2/4] iio: accel: adxl372: add event interface
Date:   Wed, 18 Mar 2020 13:09:56 +0200
Message-Id: <20200318110958.8621-3-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318110958.8621-1-alexandru.tachici@analog.com>
References: <20200318110958.8621-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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
 drivers/iio/accel/adxl372.c | 247 +++++++++++++++++++++++++++++++++++-
 1 file changed, 241 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 90c37d6f10d3..d8f95c9f9587 100644
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
+	.num_event_specs = 2						\
 }
 
 static const struct iio_chan_spec adxl372_channels[] = {
@@ -280,6 +312,43 @@ static const unsigned long adxl372_channel_masks[] = {
 	0
 };
 
+static ssize_t adxl372_read_threshold_value(struct iio_dev *indio_dev,
+					    unsigned int addr,
+					    u16 *threshold)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	__be16 __regval;
+	u16 regval;
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, addr, &__regval, sizeof(__regval));
+	if (ret < 0)
+		return ret;
+
+	regval = be16_to_cpu(__regval);
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
+	ret = regmap_write(st->regmap, addr,
+			   ADXL372_THRESH_VAL_H_SEL(threshold));
+	if (ret < 0)
+		return ret;
+
+	return regmap_update_bits(st->regmap, addr + 1, GENMASK(7, 5),
+				  ADXL372_THRESH_VAL_L_SEL(threshold) << 5);
+}
+
 static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
 {
 	__be16 regval;
@@ -543,6 +612,27 @@ static void adxl372_arrange_axis_data(struct adxl372_state *st, __be16 *sample)
 	memcpy(sample, axis_sample, 3 * sizeof(__be16));
 }
 
+static void adxl372_push_event(struct iio_dev *indio_dev, s64 timestamp,
+			       u8 status2)
+{
+	unsigned int ev_dir;
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
@@ -556,6 +646,8 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 	if (ret < 0)
 		goto err;
 
+	adxl372_push_event(indio_dev, iio_get_time_ns(indio_dev), status2);
+
 	if (st->fifo_mode != ADXL372_FIFO_BYPASSED &&
 	    ADXL372_STATUS_1_FIFO_FULL(status1)) {
 		/*
@@ -747,6 +839,143 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
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
 static ssize_t adxl372_peak_fifo_en_get(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -860,7 +1089,8 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
+	st->int1_bitmask |= ADXL372_INT1_MAP_FIFO_FULL_MSK;
+	ret = adxl372_set_interrupts(st, st->int1_bitmask, 0);
 	if (ret < 0)
 		goto err;
 
@@ -902,7 +1132,8 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 	ret = adxl372_configure_fifo(st);
 	if (ret < 0) {
 		st->fifo_mode = ADXL372_FIFO_BYPASSED;
-		adxl372_set_interrupts(st, 0, 0);
+		st->int1_bitmask &= ~ADXL372_INT1_MAP_FIFO_FULL_MSK;
+		adxl372_set_interrupts(st, st->int1_bitmask, 0);
 		goto err;
 	}
 
@@ -917,7 +1148,8 @@ static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct adxl372_state *st = iio_priv(indio_dev);
 
-	adxl372_set_interrupts(st, 0, 0);
+	st->int1_bitmask &= ~ADXL372_INT1_MAP_FIFO_FULL_MSK;
+	adxl372_set_interrupts(st, st->int1_bitmask, 0);
 	st->fifo_mode = ADXL372_FIFO_BYPASSED;
 	adxl372_configure_fifo(st);
 
@@ -934,12 +1166,11 @@ static int adxl372_dready_trig_set_state(struct iio_trigger *trig,
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
@@ -978,6 +1209,10 @@ static const struct iio_info adxl372_info = {
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
-- 
2.20.1

