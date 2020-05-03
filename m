Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1D1C2AEF
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 11:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgECJc2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 05:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728047AbgECJcZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2020 05:32:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281E8C061A0E;
        Sun,  3 May 2020 02:32:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 188so4962980wmc.2;
        Sun, 03 May 2020 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iBxDiU+CamaXyOQdcXuQVfY5fjkbVOeNQ02mkqzq6XI=;
        b=EnzguCZTrD0gioTuKnKil3ROWWHIpWFjLG3RwE8dP1Gad5hw9NYHrfBiTSW0qwAl7V
         YgfhUSaomRsOBkQ1wCElCARuaoCkYTf7lNQINg0FbwmRBzLmZfi7JvTtZWPSuT3aWSmU
         xbmFoWGcR/9NaZdTgylwcW62/+54Gb4dastwCOHRNQ3zsZ6new9+N0eywm94+op77neV
         06C3PvNCevRVevDI1fYC2SzWZd6zWQVLCkakUvgRZ1pA5jXMZjT795zSYwYdzveH6Wd0
         E9C7WYp0dfGUsCKvIZojDSJZgya6rZTXslQzy6udyKCbRC0pEV4LnvqE2QhzNRcxF1tO
         6OMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iBxDiU+CamaXyOQdcXuQVfY5fjkbVOeNQ02mkqzq6XI=;
        b=nyVG6r/e1tcK1MmiQZ3IQHa8o+yU59AmKXL7vKoctcacWogOKC9z1wf0ztbaCOZ+6Z
         azCBV+WAhFfDbe9hn4JSI+k11QcfNw5XrTe5kWarKrfxF1aEKM+T1qWohGxd1O4t8yqB
         xgWwRSt8fEcGqBayBpfYctGefpn0G8GwQAeT5dsaPQ1qTEmlRTZUt9g/i6dABn19fUyk
         J2LWIDv0OjhUA9UeY0P4M4hw2W2PO9kyGXT7axAxrnuPwz8ukyaF7XB/7QMD+dOqVeqc
         m4L1QQ6EGDdH7N8iW0yEaezJO0E+AC94Muto0ZaoQz7k7ppwlQOVwvboGGYYZtccYgfJ
         BJkw==
X-Gm-Message-State: AGi0PuaUq/XmZaSiiY/KlDXbgIjiEySHL0egpAFyiqu8+BOG3j5v4lQu
        3vWWqshJhTgqTESGvGF3JoKMWLqs3ZM=
X-Google-Smtp-Source: APiQypJ5qY6EAghhy/rPWuuID71Mi8WcKl1k+Joptbgh9xGdywe3rfPj2QAVns3ISB+rBSuO5oHM+w==
X-Received: by 2002:a1c:3182:: with SMTP id x124mr9394677wmx.54.1588498342701;
        Sun, 03 May 2020 02:32:22 -0700 (PDT)
Received: from meru.home ([2a01:cb18:832e:5f00:1cf0:acc0:9003:83d6])
        by smtp.gmail.com with ESMTPSA id e17sm10086963wrr.32.2020.05.03.02.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 02:32:22 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v7 3/5] iio: vcnl4000: Add event support for VCNL4010/20.
Date:   Sun,  3 May 2020 11:29:57 +0200
Message-Id: <20200503092959.8806-4-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200503092959.8806-1-m.othacehe@gmail.com>
References: <20200503092959.8806-1-m.othacehe@gmail.com>
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
 drivers/iio/light/vcnl4000.c | 454 ++++++++++++++++++++++++++++++-----
 1 file changed, 392 insertions(+), 62 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index b976e29f2fda..e7653037fa5d 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -13,7 +13,6 @@
  *
  * TODO:
  *   allow to adjust IR current
- *   proximity threshold and event handling
  *   periodic ALS/proximity measurement (VCNL4010/20)
  *   interrupts (VCNL4010/20/40, VCNL4200)
  */
@@ -23,7 +22,9 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
@@ -35,14 +36,22 @@
 
 #define VCNL4000_COMMAND	0x80 /* Command register */
 #define VCNL4000_PROD_REV	0x81 /* Product ID and Revision ID */
+#define VCNL4010_PROX_RATE      0x82 /* Proximity rate */
 #define VCNL4000_LED_CURRENT	0x83 /* IR LED current for proximity mode */
 #define VCNL4000_AL_PARAM	0x84 /* Ambient light parameter register */
+#define VCNL4010_ALS_PARAM      0x84 /* ALS rate */
 #define VCNL4000_AL_RESULT_HI	0x85 /* Ambient light result register, MSB */
 #define VCNL4000_AL_RESULT_LO	0x86 /* Ambient light result register, LSB */
 #define VCNL4000_PS_RESULT_HI	0x87 /* Proximity result register, MSB */
 #define VCNL4000_PS_RESULT_LO	0x88 /* Proximity result register, LSB */
 #define VCNL4000_PS_MEAS_FREQ	0x89 /* Proximity test signal frequency */
+#define VCNL4010_INT_CTRL	0x89 /* Interrupt control */
 #define VCNL4000_PS_MOD_ADJ	0x8a /* Proximity modulator timing adjustment */
+#define VCNL4010_LOW_THR_HI     0x8a /* Low threshold, MSB */
+#define VCNL4010_LOW_THR_LO     0x8b /* Low threshold, LSB */
+#define VCNL4010_HIGH_THR_HI    0x8c /* High threshold, MSB */
+#define VCNL4010_HIGH_THR_LO    0x8d /* High threshold, LSB */
+#define VCNL4010_ISR		0x8e /* Interrupt status */
 
 #define VCNL4200_AL_CONF	0x00 /* Ambient light configuration */
 #define VCNL4200_PS_CONF1	0x03 /* Proximity configuration */
@@ -57,6 +66,26 @@
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
 
@@ -88,6 +117,10 @@ struct vcnl4000_data {
 
 struct vcnl4000_chip_spec {
 	const char *prod;
+	struct iio_chan_spec const *channels;
+	const int num_channels;
+	const struct iio_info *info;
+	bool irq_support;
 	int (*init)(struct vcnl4000_data *data);
 	int (*measure_light)(struct vcnl4000_data *data, int *val);
 	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
@@ -330,67 +363,16 @@ static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
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
+static bool vcnl4010_is_in_periodic_mode(struct vcnl4000_data *data)
 {
-	struct vcnl4000_data *data = iio_priv(indio_dev);
-
-	return sprintf(buf, "%u\n", data->near_level);
-}
+	int ret;
 
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
+		return false;
 
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
+	return !!(ret & VCNL4000_SELF_TIMED_EN);
+}
 
 static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
 {
@@ -450,10 +432,345 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
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
+		if (vcnl4010_is_in_periodic_mode(data)) {
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
+static bool vcnl4010_is_thr_enabled(struct vcnl4000_data *data)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_INT_CTRL);
+	if (ret < 0)
+		return false;
+
+	return !!(ret & VCNL4010_INT_THR_EN);
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
+		return vcnl4010_is_thr_enabled(data);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl4010_config_threshold(struct iio_dev *indio_dev, bool state)
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
+		if (!vcnl4010_is_thr_enabled(data))
+			return 0;
+
+		command = 0;
+		icr = 0;
+	}
+
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
+					command);
+	if (ret < 0)
+		goto end;
+
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, icr);
+
+end:
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
+		return vcnl4010_config_threshold(indio_dev, state);
+	default:
+		return -EINVAL;
+	}
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
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+	}, {
+		.type = IIO_PROXIMITY,
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
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
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
+		i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
+					  isr & VCNL4010_INT_THR);
+	}
+
+end:
+	return IRQ_HANDLED;
+}
+
 static int vcnl4000_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -483,12 +800,25 @@ static int vcnl4000_probe(struct i2c_client *client,
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
+						"vcnl4010_irq",
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

