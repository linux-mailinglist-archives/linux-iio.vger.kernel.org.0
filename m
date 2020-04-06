Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC80B19F851
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 16:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgDFOyQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 10:54:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44261 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbgDFOyH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 10:54:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id c15so1931673wro.11;
        Mon, 06 Apr 2020 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTc+CDzDjvfMzshNyOlwCzkOBqQ29jY1Teo5j2sy/U0=;
        b=udG132AeHuCPl7V8Y4gPXoU6iAmnXZgejJgzEzMkKmvBxEAmn6X/JdBWES31k32XPS
         gokt6LyBc03cxTbBjsbcCqtUrgnIZGAxc4zCWNZz3mhKT9cG3e0cq/r8GB2xR6o8LOgu
         rN6o7ahXfaDRfrcmktkHBmrJ2/8PvwkpVjLZBkW3k32QD1jHZ5PwQJKcCsHin3npwjG+
         lX4O1hc2w9jG4hktf0dJ0fbPP4Pozpkws/cEmO8jKTEBMqHCeaiP/sR1kzgAOOJDCOXX
         D6JQq5NqrLiVe3akt55I8lVlgawoGiyaN4IUsVhfRgwrNcZK7rZ3a5ZGPCzb5hATe5Rf
         U0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTc+CDzDjvfMzshNyOlwCzkOBqQ29jY1Teo5j2sy/U0=;
        b=MwS0nypLtBssrFuwqanp74I0VSp662N/nEs1okZBsGX7wM0Ko3Uwzi34/RMo6mVPQ2
         6a9mPvrw+N4RMzjkRZ7gx+WFD3mwY4RVSbByazgbSqKEH4/kkQlzgTjSYqP8l/U6tEb/
         kf9bb0Tw0F7jjbcQprhLUqMVXfVhOYE7ulzyl1sjhjpZssgStKA27IXhzKCh/9Ohgh44
         eb2QIux9k/9kbXUf9oUEqgUtOzOlYUoecOMGD+z01/GyCCKr0mQEM8lXAwQDdboaR/I6
         pqOTJS8/OPOEEkY1n1zfQDHAuUU3id3fHHPhs0kNr7192i7RvieaXPdtk2vzYJYV6mA9
         Us7w==
X-Gm-Message-State: AGi0PuYL7pgTH7FcjB1U+sRbDBUIlKJJvyGSaXm8htlL0jnXRteXcBFx
        jqdtdCYRXDLhpW1J8kaQIGw=
X-Google-Smtp-Source: APiQypJLwtkL0L+Mhsh7YigRig6Xp5BJT2QWVAmn4qfiU9JEtkW4pt+deKlIYmiWQBAo/iNEm0RHlg==
X-Received: by 2002:adf:dfc6:: with SMTP id q6mr23947828wrn.325.1586184844948;
        Mon, 06 Apr 2020 07:54:04 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:586b:b940:d2f2:e882])
        by smtp.gmail.com with ESMTPSA id d7sm26382914wrr.77.2020.04.06.07.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:54:04 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v2 2/4] iio: vcnl4000: Add event support for VCNL4010/20.
Date:   Mon,  6 Apr 2020 16:53:54 +0200
Message-Id: <20200406145356.25883-3-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406145356.25883-1-m.othacehe@gmail.com>
References: <20200406145356.25883-1-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The VCNL4010 and VCNL4020 chips are able to raise interrupts on proximity
threshold events. Add support for threshold rising and falling events for
those two chips.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 435 +++++++++++++++++++++++++++++++----
 1 file changed, 396 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index c95b89740dfa..b0aaa4dd7a50 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -22,7 +22,9 @@
 #include <linux/i2c.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
@@ -43,6 +45,15 @@
 #define VCNL4000_PS_MEAS_FREQ	0x89 /* Proximity test signal frequency */
 #define VCNL4000_PS_MOD_ADJ	0x8a /* Proximity modulator timing adjustment */
 
+#define VCNL4010_PROX_RATE      0x82 /* Proximity rate */
+#define VCNL4010_ALS_PARAM      0x84 /* ALS rate */
+#define VCNL4010_INT_CTRL	0x89 /* Interrupt control */
+#define VCNL4010_LOW_THR_HI     0x8a /* Low threshold, MSB */
+#define VCNL4010_LOW_THR_LO     0x8b /* Low threshold, LSB */
+#define VCNL4010_HIGH_THR_HI    0x8c /* High threshold, MSB */
+#define VCNL4010_HIGH_THR_LO    0x8d /* High threshold, LSB */
+#define VCNL4010_ISR		0x8e /* Interrupt status */
+
 #define VCNL4200_AL_CONF	0x00 /* Ambient light configuration */
 #define VCNL4200_PS_CONF1	0x03 /* Proximity configuration */
 #define VCNL4200_PS_DATA	0x08 /* Proximity data */
@@ -56,6 +67,26 @@
 #define VCNL4000_PS_RDY		BIT(5) /* proximity data ready? */
 #define VCNL4000_AL_OD		BIT(4) /* start on-demand ALS measurement */
 #define VCNL4000_PS_OD		BIT(3) /* start on-demand proximity measurement */
+#define VCNL4000_ALS_EN		BIT(2) /* start ALS measurement */
+#define VCNL4000_PROX_EN	BIT(1) /* start proximity measurement */
+#define VCNL4000_SELF_TIMED_EN	BIT(0) /* start self-timed measurement */
+
+/* Bit masks for interrupt registers. */
+#define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt source */
+#define VCNL4010_INT_THR_EN	BIT(1) /* Threshold interrupt type */
+#define VCNL4010_INT_ALS_EN	BIT(2) /* Enable on ALS data ready */
+#define VCNL4010_INT_PROX_EN	BIT(3) /* Enable on proximity data ready */
+
+#define VCNL4010_INT_THR_HIGH	0 /* High threshold exceeded */
+#define VCNL4010_INT_THR_LOW	1 /* Low threshold exceeded */
+#define VCNL4010_INT_ALS	2 /* ALS data ready */
+#define VCNL4010_INT_PROXIMITY	3 /* Proximity data ready */
+
+#define VCNL4010_INT_THR \
+	(BIT(VCNL4010_INT_THR_LOW) | BIT(VCNL4010_INT_THR_HIGH))
+#define VCNL4010_INT_DRDY \
+	(BIT(VCNL4010_INT_PROXIMITY) | BIT(VCNL4010_INT_ALS))
+
 
 enum vcnl4000_device_ids {
 	VCNL4000,
@@ -84,6 +115,10 @@ struct vcnl4000_data {
 
 struct vcnl4000_chip_spec {
 	const char *prod;
+	struct iio_chan_spec const *channels;
+	const int num_channels;
+	const struct iio_info *info;
+	bool irq_support;
 	int (*init)(struct vcnl4000_data *data);
 	int (*measure_light)(struct vcnl4000_data *data, int *val);
 	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
@@ -332,43 +367,23 @@ static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
 	return vcnl4200_measure(data, &data->vcnl4200_ps, val);
 }
 
-static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
-	[VCNL4000] = {
-		.prod = "VCNL4000",
-		.init = vcnl4000_init,
-		.measure_light = vcnl4000_measure_light,
-		.measure_proximity = vcnl4000_measure_proximity,
-	},
-	[VCNL4010] = {
-		.prod = "VCNL4010/4020",
-		.init = vcnl4000_init,
-		.measure_light = vcnl4000_measure_light,
-		.measure_proximity = vcnl4000_measure_proximity,
-	},
-	[VCNL4040] = {
-		.prod = "VCNL4040",
-		.init = vcnl4200_init,
-		.measure_light = vcnl4200_measure_light,
-		.measure_proximity = vcnl4200_measure_proximity,
-	},
-	[VCNL4200] = {
-		.prod = "VCNL4200",
-		.init = vcnl4200_init,
-		.measure_light = vcnl4200_measure_light,
-		.measure_proximity = vcnl4200_measure_proximity,
-	},
-};
+static int vcnl4010_in_periodic_mode(struct vcnl4000_data *data)
+{
+	int ret;
 
-static const struct iio_chan_spec vcnl4000_channels[] = {
-	{
-		.type = IIO_LIGHT,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_SCALE),
-	}, {
-		.type = IIO_PROXIMITY,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-	}
-};
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
+	if (ret < 0)
+		goto end;
+
+	ret = (ret & VCNL4000_SELF_TIMED_EN) > 0;
+
+end:
+	mutex_unlock(&data->vcnl4000_lock);
+
+	return ret;
+}
 
 static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
@@ -405,10 +420,339 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int vcnl4010_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	int ret;
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_SCALE:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		/* Protect against event capture. */
+		if (vcnl4010_in_periodic_mode(data)) {
+			ret = -EBUSY;
+		} else {
+			ret = vcnl4000_read_raw(indio_dev, chan, val, val2,
+						mask);
+		}
+
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl4010_read_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int *val, int *val2)
+{
+	int ret;
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = vcnl4000_read_data(data, VCNL4010_HIGH_THR_HI,
+						 val);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		case IIO_EV_DIR_FALLING:
+			ret = vcnl4000_read_data(data, VCNL4010_LOW_THR_HI,
+						 val);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl4010_write_event(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	int ret;
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = vcnl4000_write_data(data, VCNL4010_HIGH_THR_HI,
+						  val);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		case IIO_EV_DIR_FALLING:
+			ret = vcnl4000_write_data(data, VCNL4010_LOW_THR_HI,
+						  val);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl4010_thr_enabled(struct vcnl4000_data *data)
+{
+	int ret;
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_INT_CTRL);
+	if (ret < 0)
+		goto end;
+
+	ret = (ret & VCNL4010_INT_THR_EN) > 0;
+
+end:
+	mutex_unlock(&data->vcnl4000_lock);
+
+	return ret;
+}
+
+static int vcnl4010_read_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir)
+{
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		return vcnl4010_thr_enabled(data);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl4010_prox_threshold(struct iio_dev *indio_dev, int state)
+{
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+	int ret;
+	int icr;
+	int command;
+
+	if (state) {
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		/* Enable periodic measurement of proximity data. */
+		command = VCNL4000_SELF_TIMED_EN | VCNL4000_PROX_EN;
+
+		/*
+		 * Enable interrupts on threshold, for proximity data by
+		 * default.
+		 */
+		icr = VCNL4010_INT_THR_EN;
+	} else {
+		if (!vcnl4010_thr_enabled(data))
+			return 0;
+
+		command = 0;
+		icr = 0;
+	}
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
+					command);
+	if (ret < 0)
+		goto end;
+
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, icr);
+
+end:
+	mutex_unlock(&data->vcnl4000_lock);
+
+	if (state)
+		iio_device_release_direct_mode(indio_dev);
+
+	return ret;
+}
+
+static int vcnl4010_write_event_config(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir,
+				       int state)
+{
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		return vcnl4010_prox_threshold(indio_dev, state);
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct iio_event_spec vcnl4000_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	}
+};
+
+static const struct iio_chan_spec vcnl4000_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+	}, {
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	}
+};
+
+static const struct iio_chan_spec vcnl4010_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.scan_index = -1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+	}, {
+		.type = IIO_PROXIMITY,
+		.scan_index = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.event_spec = vcnl4000_event_spec,
+		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
+	},
+};
+
 static const struct iio_info vcnl4000_info = {
 	.read_raw = vcnl4000_read_raw,
 };
 
+static const struct iio_info vcnl4010_info = {
+	.read_raw = vcnl4010_read_raw,
+	.read_event_value = vcnl4010_read_event,
+	.write_event_value = vcnl4010_write_event,
+	.read_event_config = vcnl4010_read_event_config,
+	.write_event_config = vcnl4010_write_event_config,
+};
+
+static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
+	[VCNL4000] = {
+		.prod = "VCNL4000",
+		.init = vcnl4000_init,
+		.measure_light = vcnl4000_measure_light,
+		.measure_proximity = vcnl4000_measure_proximity,
+		.channels = vcnl4000_channels,
+		.num_channels = ARRAY_SIZE(vcnl4000_channels),
+		.info = &vcnl4000_info,
+		.irq_support = false,
+	},
+	[VCNL4010] = {
+		.prod = "VCNL4010/4020",
+		.init = vcnl4000_init,
+		.measure_light = vcnl4000_measure_light,
+		.measure_proximity = vcnl4000_measure_proximity,
+		.channels = vcnl4010_channels,
+		.num_channels = ARRAY_SIZE(vcnl4010_channels),
+		.info = &vcnl4010_info,
+		.irq_support = true,
+	},
+	[VCNL4040] = {
+		.prod = "VCNL4040",
+		.init = vcnl4200_init,
+		.measure_light = vcnl4200_measure_light,
+		.measure_proximity = vcnl4200_measure_proximity,
+		.channels = vcnl4000_channels,
+		.num_channels = ARRAY_SIZE(vcnl4000_channels),
+		.info = &vcnl4000_info,
+		.irq_support = false,
+	},
+	[VCNL4200] = {
+		.prod = "VCNL4200",
+		.init = vcnl4200_init,
+		.measure_light = vcnl4200_measure_light,
+		.measure_proximity = vcnl4200_measure_proximity,
+		.channels = vcnl4000_channels,
+		.num_channels = ARRAY_SIZE(vcnl4000_channels),
+		.info = &vcnl4000_info,
+		.irq_support = false,
+	},
+};
+
+static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+	unsigned long isr;
+	int ret;
+
+	mutex_lock(&data->vcnl4000_lock);
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
+	mutex_unlock(&data->vcnl4000_lock);
+
+	if (ret < 0)
+		goto end;
+
+	isr = ret;
+
+	if (isr & VCNL4010_INT_THR) {
+		if (test_bit(VCNL4010_INT_THR_LOW, &isr)) {
+			iio_push_event(indio_dev,
+				       IIO_UNMOD_EVENT_CODE(
+					       IIO_PROXIMITY,
+					       1,
+					       IIO_EV_TYPE_THRESH,
+					       IIO_EV_DIR_FALLING),
+				       iio_get_time_ns(indio_dev));
+		}
+
+		if (test_bit(VCNL4010_INT_THR_HIGH, &isr)) {
+			iio_push_event(indio_dev,
+				       IIO_UNMOD_EVENT_CODE(
+					       IIO_PROXIMITY,
+					       1,
+					       IIO_EV_TYPE_THRESH,
+					       IIO_EV_DIR_RISING),
+				       iio_get_time_ns(indio_dev));
+		}
+
+		mutex_lock(&data->vcnl4000_lock);
+		i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
+					  isr & VCNL4010_INT_THR);
+		mutex_unlock(&data->vcnl4000_lock);
+	}
+
+end:
+	return IRQ_HANDLED;
+}
+
 static int vcnl4000_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -434,12 +778,25 @@ static int vcnl4000_probe(struct i2c_client *client,
 		data->chip_spec->prod, data->rev);
 
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->info = &vcnl4000_info;
-	indio_dev->channels = vcnl4000_channels;
-	indio_dev->num_channels = ARRAY_SIZE(vcnl4000_channels);
+	indio_dev->info = data->chip_spec->info;
+	indio_dev->channels = data->chip_spec->channels;
+	indio_dev->num_channels = data->chip_spec->num_channels;
 	indio_dev->name = VCNL4000_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	if (client->irq && data->chip_spec->irq_support) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, vcnl4010_irq_thread,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						"vncl4010_irq",
+						indio_dev);
+		if (ret < 0) {
+			dev_err(&client->dev, "irq request failed\n");
+			return ret;
+		}
+	}
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.26.0

