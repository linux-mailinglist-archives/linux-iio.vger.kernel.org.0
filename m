Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF85B1B04AD
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 10:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgDTInJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 04:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgDTInH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 04:43:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C58C061A0F;
        Mon, 20 Apr 2020 01:43:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b11so11033530wrs.6;
        Mon, 20 Apr 2020 01:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRdUj8Kiu9tDFDXbrOvi5JT/YiPAsxYGKNqygqhF9rI=;
        b=Y3U2nb6xHdqqQ/YMgbzdfouag67OZwrWWBml6v+XAa/e607XM3B2tAH8okFcCxNqIo
         NWa0pckZPGkI+jqnj4SOhYNW22FhK/deSDzO8r3SZUbu3bZy4H+9kORSKklyHyxFL0+y
         wtQDQRlgSLeHur/hJZne2jsz/bT2Xno7upXhwD5+N5RuXx7i5bcQgObpzoDdBj/FQMp2
         dxlCYMA82UuaR07eQsNRlOs3187BWeIcnC0H+KQbky7tXApXPJ9FRNxUkm8q41WWpash
         sX8UJdX/8mBx4nLekeG60FqrKosCDUiefPtnEyX3GC6CnglC3SYFvsUjXoEtZvfZYYQj
         dN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRdUj8Kiu9tDFDXbrOvi5JT/YiPAsxYGKNqygqhF9rI=;
        b=bBiJLCgOF7AIFsm+94j/gqWsR95fia0ePX1G6q23UrJfA3olKjvm5kskdimLMKY62J
         cpJq1ZwLd11fnEBoWvnaPvASd3mF4k1qQ10qD5j91AgsEG8JtgTcf/9RyHQ6RfMSLYhH
         q3rYDueOZX//++IWEfEIkAKmZe868pubEVDbxZmPelLKH8KpcGcz6+GJHndxGaLDtda3
         J0NUuNx/WHl66v1OKMWrBBRR+3S28MBrpODLinQFSIZV7dkd+YnErgz0FJjJ/99ZNxHb
         RgOCpBRe+bQKdLSeQ5reFEpIePl0QA+O5EKHOCBv/h093b2yDoPsrexscG34D/S4w7uw
         OEmQ==
X-Gm-Message-State: AGi0Pua8utLGF2N4Um9fAis6BODWP9waJTsgTbaDAPzOgeOV0plMaA76
        fPq+hu9Ev6TeI03plMSHupE=
X-Google-Smtp-Source: APiQypIxTKq+DnNFjQx/fljvO1dkwy8aRsuuUKuRKfHg0+CUeChncX5oIqHjWvK6xbgHAdPYH/kuRg==
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr17217718wrj.165.1587372185633;
        Mon, 20 Apr 2020 01:43:05 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:c546:5ea:178b:4074])
        by smtp.gmail.com with ESMTPSA id g74sm403183wme.44.2020.04.20.01.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:43:05 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v3 2/4] iio: vcnl4000: Add event support for VCNL4010/20.
Date:   Mon, 20 Apr 2020 10:42:08 +0200
Message-Id: <20200420084210.14245-3-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420084210.14245-1-m.othacehe@gmail.com>
References: <20200420084210.14245-1-m.othacehe@gmail.com>
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
 drivers/iio/light/vcnl4000.c | 478 ++++++++++++++++++++++++++++++-----
 1 file changed, 418 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 4e87d2cf1100..73a3627d12b8 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -23,7 +23,9 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
@@ -44,6 +46,15 @@
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
@@ -57,6 +68,26 @@
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
 
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
@@ -88,6 +119,10 @@ struct vcnl4000_data {
 
 struct vcnl4000_chip_spec {
 	const char *prod;
+	struct iio_chan_spec const *channels;
+	const int num_channels;
+	const struct iio_info *info;
+	bool irq_support;
 	int (*init)(struct vcnl4000_data *data);
 	int (*measure_light)(struct vcnl4000_data *data, int *val);
 	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
@@ -358,67 +393,23 @@ static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
 	return vcnl4200_measure(data, &data->vcnl4200_ps, val);
 }
 
-static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
-	[VCNL4000] = {
-		.prod = "VCNL4000",
-		.init = vcnl4000_init,
-		.measure_light = vcnl4000_measure_light,
-		.measure_proximity = vcnl4000_measure_proximity,
-		.set_power_state = vcnl4000_set_power_state,
-	},
-	[VCNL4010] = {
-		.prod = "VCNL4010/4020",
-		.init = vcnl4000_init,
-		.measure_light = vcnl4000_measure_light,
-		.measure_proximity = vcnl4000_measure_proximity,
-		.set_power_state = vcnl4000_set_power_state,
-	},
-	[VCNL4040] = {
-		.prod = "VCNL4040",
-		.init = vcnl4200_init,
-		.measure_light = vcnl4200_measure_light,
-		.measure_proximity = vcnl4200_measure_proximity,
-		.set_power_state = vcnl4200_set_power_state,
-	},
-	[VCNL4200] = {
-		.prod = "VCNL4200",
-		.init = vcnl4200_init,
-		.measure_light = vcnl4200_measure_light,
-		.measure_proximity = vcnl4200_measure_proximity,
-		.set_power_state = vcnl4200_set_power_state,
-	},
-};
-
-static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
-					uintptr_t priv,
-					const struct iio_chan_spec *chan,
-					char *buf)
+static int vcnl4010_in_periodic_mode(struct vcnl4000_data *data)
 {
-	struct vcnl4000_data *data = iio_priv(indio_dev);
+	int ret;
 
-	return sprintf(buf, "%u\n", data->near_level);
-}
+	mutex_lock(&data->vcnl4000_lock);
 
-static const struct iio_chan_spec_ext_info vcnl4000_ext_info[] = {
-	{
-		.name = "nearlevel",
-		.shared = IIO_SEPARATE,
-		.read = vcnl4000_read_near_level,
-	},
-	{ /* sentinel */ }
-};
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
+	if (ret < 0)
+		goto end;
 
-static const struct iio_chan_spec vcnl4000_channels[] = {
-	{
-		.type = IIO_LIGHT,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_SCALE),
-	}, {
-		.type = IIO_PROXIMITY,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.ext_info = vcnl4000_ext_info,
-	}
-};
+	ret = (ret & VCNL4000_SELF_TIMED_EN) > 0;
+
+end:
+	mutex_unlock(&data->vcnl4000_lock);
+
+	return ret;
+}
 
 static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
 {
@@ -478,10 +469,364 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
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
+static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
+					uintptr_t priv,
+					const struct iio_chan_spec *chan,
+					char *buf)
+{
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%u\n", data->near_level);
+}
+
+static const struct iio_chan_spec_ext_info vcnl4000_ext_info[] = {
+	{
+		.name = "nearlevel",
+		.shared = IIO_SEPARATE,
+		.read = vcnl4000_read_near_level,
+	},
+	{ /* sentinel */ }
+};
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
+		.ext_info = vcnl4000_ext_info,
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
+		.ext_info = vcnl4000_ext_info,
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
+		.set_power_state = vcnl4000_set_power_state,
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
+		.set_power_state = vcnl4000_set_power_state,
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
+		.set_power_state = vcnl4200_set_power_state,
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
+		.set_power_state = vcnl4200_set_power_state,
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
@@ -511,12 +856,25 @@ static int vcnl4000_probe(struct i2c_client *client,
 		data->near_level = 0;
 
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
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret < 0)
 		goto fail_poweroff;
-- 
2.26.0

