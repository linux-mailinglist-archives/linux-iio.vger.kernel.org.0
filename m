Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA447444F7C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 08:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhKDHP4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 03:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKDHPx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 03:15:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B42C061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 00:13:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k2so4941928pff.11
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 00:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fI1j1EZrFFt8k+2/FKIGkcvD/bpuPRi2wEEkbqAA/M0=;
        b=IOInMXzYYSRn+R6/uCw5503+maxcCJAGgjh/39oNJ6JTBtem0LHw58Mk2o1Pk8hIp7
         vde9C8/ZZp71sEjsnX1So4CKdvxZcSp4Ibiu7KtniWeROq0GuELBV3ASd0+6k4prMouZ
         aQ1wXQNr/Gt2ullbMVldyNYbOsIVU/LWhdtPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fI1j1EZrFFt8k+2/FKIGkcvD/bpuPRi2wEEkbqAA/M0=;
        b=z1YEt1W4fReP8/zAijr7b2XIV8aPRYi0JrkxvqFpu6YmLGFfiJJa8oRjf5uOcOr0QH
         y+8ttVj/m14bTdosfjpmEiTOFoTXS5tU98LwpmTPDLz81j2vizlW5F31MtcNcfl58AUs
         m+vU4tI1h6kyBwhJsTm/C16TWXWxUL3SA9JbUFjnZEZtit5Z91dRjjbPApYr+phZTlE3
         edjXSpM7CAkeIIf7POr0+0drPJoXpNcAcCSXwP0czsntaoNG0/HzNrQWVOAhzC4nNfVR
         1f+s/9YBFE0ETwZcrMNbY/idDViNXwN3h9JILIJgJxIPwI2jZ26hmWkukwOAy/3y8HfJ
         Mdfw==
X-Gm-Message-State: AOAM533Df6+bIlY6mHeTVZ13/plA+yM6hIrIdFgfiAKJG4DkW8hr/l3d
        z4mfUXOalACXm/T5XQWOin/g0w==
X-Google-Smtp-Source: ABdhPJz812H3jp+LlNbE7SkULI/jeODYMeajEQhjVApqssJqElPcC2WkxGPMpsjzhR7/YLDAcrCHIg==
X-Received: by 2002:a65:448a:: with SMTP id l10mr36980049pgq.313.1636009992666;
        Thu, 04 Nov 2021 00:13:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id i68sm4004455pfc.158.2021.11.04.00.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 00:13:12 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 2/5] iio: sx9310: Extract common Semtech sensor logic
Date:   Thu,  4 Nov 2021 00:13:00 -0700
Message-Id: <20211104071303.3604314-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211104071303.3604314-1-gwendal@chromium.org>
References: <20211104071303.3604314-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Before adding new Semtech sensors, move common logic to all Semtech SAR
sensor in its own file:
- interface with IIO subsystem,
- interrupt management,
- channel access conrol,
- event processing.

The change adds a bidirectional interface between sx93xx and sx_common.

The change is quite mechanical, as the impacted functions are moved
and renamed.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v2:
- Add Kconfig/Makefile that were in the wrong patch
- Define a better interface between common code and driver code
- Move back read_avail() to driver code:
  As it now contains frequency table, it will differ from sensor to
  sensor.
- Check whoami and set driver name back in the driver code.
- Use a common probe routine.
- Fix kernel doc comments.

 drivers/iio/proximity/Kconfig     |   4 +
 drivers/iio/proximity/Makefile    |   2 +-
 drivers/iio/proximity/sx9310.c    | 676 +++++-------------------------
 drivers/iio/proximity/sx_common.c | 575 +++++++++++++++++++++++++
 drivers/iio/proximity/sx_common.h | 158 +++++++
 5 files changed, 835 insertions(+), 580 deletions(-)
 create mode 100644 drivers/iio/proximity/sx_common.c
 create mode 100644 drivers/iio/proximity/sx_common.h

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 7c7203ca3ac63..e88fc373c2c90 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -112,11 +112,15 @@ config SRF04
 	  To compile this driver as a module, choose M here: the
 	  module will be called srf04.
 
+config SX_COMMON
+	tristate
+
 config SX9310
 	tristate "SX9310/SX9311 Semtech proximity sensor"
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select REGMAP_I2C
+	select SX_COMMON
 	depends on I2C
 	help
 	  Say Y here to build a driver for Semtech's SX9310/SX9311 capacitive
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index cbdac09433eb5..81a4716904ee2 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_RFD77402)		+= rfd77402.o
 obj-$(CONFIG_SRF04)		+= srf04.o
 obj-$(CONFIG_SRF08)		+= srf08.o
 obj-$(CONFIG_SX9310)		+= sx9310.o
+obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
 obj-$(CONFIG_SX9500)		+= sx9500.o
 obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
 obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
-
diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 1647268b6471f..994b23beca5ca 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -22,19 +22,16 @@
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
-#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
-#include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/trigger.h>
-#include <linux/iio/triggered_buffer.h>
-#include <linux/iio/trigger_consumer.h>
+
+#include "sx_common.h"
 
 /* Register definitions. */
-#define SX9310_REG_IRQ_SRC				0x00
+#define SX9310_REG_IRQ_SRC				SX_COMMON_REG_IRQ_SRC
 #define SX9310_REG_STAT0				0x01
 #define SX9310_REG_STAT1				0x02
 #define SX9310_REG_STAT1_COMPSTAT_MASK			GENMASK(3, 0)
@@ -132,86 +129,37 @@
 #define SX9310_REG_I2C_ADDR				0x40
 #define SX9310_REG_PAUSE				0x41
 #define SX9310_REG_WHOAMI				0x42
-#define   SX9310_WHOAMI_VALUE				0x01
-#define   SX9311_WHOAMI_VALUE				0x02
 #define SX9310_REG_RESET				0x7f
-#define   SX9310_SOFT_RESET				0xde
 
 
 /* 4 hardware channels, as defined in STAT0: COMB, CS2, CS1 and CS0. */
 #define SX9310_NUM_CHANNELS				4
-static_assert(SX9310_NUM_CHANNELS < BITS_PER_LONG);
-
-struct sx9310_data {
-	/* Serialize access to registers and channel configuration */
-	struct mutex mutex;
-	struct i2c_client *client;
-	struct iio_trigger *trig;
-	struct regmap *regmap;
-	struct regulator_bulk_data supplies[2];
-	/*
-	 * Last reading of the proximity status for each channel.
-	 * We only send an event to user space when this changes.
-	 */
-	unsigned long chan_prox_stat;
-	bool trigger_enabled;
-	/* Ensure correct alignment of timestamp when present. */
-	struct {
-		__be16 channels[SX9310_NUM_CHANNELS];
-		s64 ts __aligned(8);
-	} buffer;
-	/* Remember enabled channels and sample rate during suspend. */
-	unsigned int suspend_ctrl0;
-	struct completion completion;
-	unsigned long chan_read;
-	unsigned long chan_event;
-	unsigned int whoami;
-};
-
-static const struct iio_event_spec sx9310_events[] = {
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_RISING,
-		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
-	},
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_FALLING,
-		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
-	},
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
-				 BIT(IIO_EV_INFO_HYSTERESIS) |
-				 BIT(IIO_EV_INFO_VALUE),
-	},
-};
-
-#define SX9310_NAMED_CHANNEL(idx, name)					 \
-	{								 \
-		.type = IIO_PROXIMITY,					 \
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		 \
-				      BIT(IIO_CHAN_INFO_HARDWAREGAIN),   \
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
-		.info_mask_separate_available =				 \
-			BIT(IIO_CHAN_INFO_HARDWAREGAIN),		 \
-		.info_mask_shared_by_all_available =			 \
-			BIT(IIO_CHAN_INFO_SAMP_FREQ),			 \
-		.indexed = 1,						 \
-		.channel = idx,						 \
-		.extend_name = name,					 \
-		.address = SX9310_REG_DIFF_MSB,				 \
-		.event_spec = sx9310_events,				 \
-		.num_event_specs = ARRAY_SIZE(sx9310_events),		 \
-		.scan_index = idx,					 \
-		.scan_type = {						 \
-			.sign = 's',					 \
-			.realbits = 12,					 \
-			.storagebits = 16,				 \
-			.endianness = IIO_BE,				 \
-		},							 \
-	}
+static_assert(SX9310_NUM_CHANNELS <= SX_COMMON_MAX_NUM_CHANNELS);
+
+#define SX9310_NAMED_CHANNEL(idx, name)				 \
+{								 \
+	.type = IIO_PROXIMITY,					 \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		 \
+			      BIT(IIO_CHAN_INFO_HARDWAREGAIN),   \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.info_mask_separate_available =				 \
+		BIT(IIO_CHAN_INFO_HARDWAREGAIN),		 \
+	.info_mask_shared_by_all_available =			 \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			 \
+	.indexed = 1,						 \
+	.channel = idx,						 \
+	.extend_name = name,					 \
+	.address = SX9310_REG_DIFF_MSB,				 \
+	.event_spec = sx_common_events,				 \
+	.num_event_specs = ARRAY_SIZE(sx_common_events),	 \
+	.scan_index = idx,					 \
+	.scan_type = {						 \
+		.sign = 's',					 \
+		.realbits = 12,					 \
+		.storagebits = 16,				 \
+		.endianness = IIO_BE,				 \
+	},							 \
+}
 #define SX9310_CHANNEL(idx) SX9310_NAMED_CHANNEL(idx, NULL)
 
 static const struct iio_chan_spec sx9310_channels[] = {
@@ -306,64 +254,7 @@ static const struct regmap_config sx9310_regmap_config = {
 	.volatile_table = &sx9310_volatile_regs,
 };
 
-static int sx9310_update_chan_en(struct sx9310_data *data,
-				 unsigned long chan_read,
-				 unsigned long chan_event)
-{
-	int ret;
-	unsigned long channels = chan_read | chan_event;
-
-	if ((data->chan_read | data->chan_event) != channels) {
-		ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL0,
-					 SX9310_REG_PROX_CTRL0_SENSOREN_MASK,
-					 channels);
-		if (ret)
-			return ret;
-	}
-	data->chan_read = chan_read;
-	data->chan_event = chan_event;
-	return 0;
-}
-
-static int sx9310_get_read_channel(struct sx9310_data *data, int channel)
-{
-	return sx9310_update_chan_en(data, data->chan_read | BIT(channel),
-				     data->chan_event);
-}
-
-static int sx9310_put_read_channel(struct sx9310_data *data, int channel)
-{
-	return sx9310_update_chan_en(data, data->chan_read & ~BIT(channel),
-				     data->chan_event);
-}
-
-static int sx9310_get_event_channel(struct sx9310_data *data, int channel)
-{
-	return sx9310_update_chan_en(data, data->chan_read,
-				     data->chan_event | BIT(channel));
-}
-
-static int sx9310_put_event_channel(struct sx9310_data *data, int channel)
-{
-	return sx9310_update_chan_en(data, data->chan_read,
-				     data->chan_event & ~BIT(channel));
-}
-
-static int sx9310_enable_irq(struct sx9310_data *data, unsigned int irq)
-{
-	if (!data->client->irq)
-		return 0;
-	return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, irq);
-}
-
-static int sx9310_disable_irq(struct sx9310_data *data, unsigned int irq)
-{
-	if (!data->client->irq)
-		return 0;
-	return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, 0);
-}
-
-static int sx9310_read_prox_data(struct sx9310_data *data,
+static int sx9310_read_prox_data(struct sx_common_data *data,
 				 const struct iio_chan_spec *chan, __be16 *val)
 {
 	int ret;
@@ -379,7 +270,7 @@ static int sx9310_read_prox_data(struct sx9310_data *data,
  * If we have no interrupt support, we have to wait for a scan period
  * after enabling a channel to get a result.
  */
-static int sx9310_wait_for_sample(struct sx9310_data *data)
+static int sx9310_wait_for_sample(struct sx_common_data *data)
 {
 	int ret;
 	unsigned int val;
@@ -395,66 +286,7 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
 	return 0;
 }
 
-static int sx9310_read_proximity(struct sx9310_data *data,
-				 const struct iio_chan_spec *chan, int *val)
-{
-	int ret;
-	__be16 rawval;
-
-	mutex_lock(&data->mutex);
-
-	ret = sx9310_get_read_channel(data, chan->channel);
-	if (ret)
-		goto out;
-
-	ret = sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);
-	if (ret)
-		goto out_put_channel;
-
-	mutex_unlock(&data->mutex);
-
-	if (data->client->irq) {
-		ret = wait_for_completion_interruptible(&data->completion);
-		reinit_completion(&data->completion);
-	} else {
-		ret = sx9310_wait_for_sample(data);
-	}
-
-	mutex_lock(&data->mutex);
-
-	if (ret)
-		goto out_disable_irq;
-
-	ret = sx9310_read_prox_data(data, chan, &rawval);
-	if (ret)
-		goto out_disable_irq;
-
-	*val = sign_extend32(be16_to_cpu(rawval),
-			     chan->address == SX9310_REG_DIFF_MSB ? 11 : 15);
-
-	ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
-	if (ret)
-		goto out_put_channel;
-
-	ret = sx9310_put_read_channel(data, chan->channel);
-	if (ret)
-		goto out;
-
-	mutex_unlock(&data->mutex);
-
-	return IIO_VAL_INT;
-
-out_disable_irq:
-	sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
-out_put_channel:
-	sx9310_put_read_channel(data, chan->channel);
-out:
-	mutex_unlock(&data->mutex);
-
-	return ret;
-}
-
-static int sx9310_read_gain(struct sx9310_data *data,
+static int sx9310_read_gain(struct sx_common_data *data,
 			    const struct iio_chan_spec *chan, int *val)
 {
 	unsigned int regval, gain;
@@ -482,7 +314,7 @@ static int sx9310_read_gain(struct sx9310_data *data,
 	return IIO_VAL_INT;
 }
 
-static int sx9310_read_samp_freq(struct sx9310_data *data, int *val, int *val2)
+static int sx9310_read_samp_freq(struct sx_common_data *data, int *val, int *val2)
 {
 	unsigned int regval;
 	int ret;
@@ -502,7 +334,7 @@ static int sx9310_read_raw(struct iio_dev *indio_dev,
 			   const struct iio_chan_spec *chan, int *val,
 			   int *val2, long mask)
 {
-	struct sx9310_data *data = iio_priv(indio_dev);
+	struct sx_common_data *data = iio_priv(indio_dev);
 	int ret;
 
 	if (chan->type != IIO_PROXIMITY)
@@ -514,7 +346,7 @@ static int sx9310_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		ret = sx9310_read_proximity(data, chan, val);
+		ret = sx_common_read_proximity(data, chan, val);
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_HARDWAREGAIN:
@@ -577,7 +409,7 @@ static int sx9310_get_thresh_reg(unsigned int channel)
 	return -EINVAL;
 }
 
-static int sx9310_read_thresh(struct sx9310_data *data,
+static int sx9310_read_thresh(struct sx_common_data *data,
 			      const struct iio_chan_spec *chan, int *val)
 {
 	unsigned int reg;
@@ -600,7 +432,7 @@ static int sx9310_read_thresh(struct sx9310_data *data,
 	return IIO_VAL_INT;
 }
 
-static int sx9310_read_hysteresis(struct sx9310_data *data,
+static int sx9310_read_hysteresis(struct sx_common_data *data,
 				  const struct iio_chan_spec *chan, int *val)
 {
 	unsigned int regval, pthresh;
@@ -624,7 +456,7 @@ static int sx9310_read_hysteresis(struct sx9310_data *data,
 	return IIO_VAL_INT;
 }
 
-static int sx9310_read_far_debounce(struct sx9310_data *data, int *val)
+static int sx9310_read_far_debounce(struct sx_common_data *data, int *val)
 {
 	unsigned int regval;
 	int ret;
@@ -642,7 +474,7 @@ static int sx9310_read_far_debounce(struct sx9310_data *data, int *val)
 	return IIO_VAL_INT;
 }
 
-static int sx9310_read_close_debounce(struct sx9310_data *data, int *val)
+static int sx9310_read_close_debounce(struct sx_common_data *data, int *val)
 {
 	unsigned int regval;
 	int ret;
@@ -666,7 +498,7 @@ static int sx9310_read_event_val(struct iio_dev *indio_dev,
 				 enum iio_event_direction dir,
 				 enum iio_event_info info, int *val, int *val2)
 {
-	struct sx9310_data *data = iio_priv(indio_dev);
+	struct sx_common_data *data = iio_priv(indio_dev);
 
 	if (chan->type != IIO_PROXIMITY)
 		return -EINVAL;
@@ -690,7 +522,7 @@ static int sx9310_read_event_val(struct iio_dev *indio_dev,
 	}
 }
 
-static int sx9310_write_thresh(struct sx9310_data *data,
+static int sx9310_write_thresh(struct sx_common_data *data,
 			       const struct iio_chan_spec *chan, int val)
 {
 	unsigned int reg;
@@ -720,7 +552,7 @@ static int sx9310_write_thresh(struct sx9310_data *data,
 	return ret;
 }
 
-static int sx9310_write_hysteresis(struct sx9310_data *data,
+static int sx9310_write_hysteresis(struct sx_common_data *data,
 				   const struct iio_chan_spec *chan, int _val)
 {
 	unsigned int hyst, val = _val;
@@ -750,7 +582,7 @@ static int sx9310_write_hysteresis(struct sx9310_data *data,
 	return ret;
 }
 
-static int sx9310_write_far_debounce(struct sx9310_data *data, int val)
+static int sx9310_write_far_debounce(struct sx_common_data *data, int val)
 {
 	int ret;
 	unsigned int regval;
@@ -771,7 +603,7 @@ static int sx9310_write_far_debounce(struct sx9310_data *data, int val)
 	return ret;
 }
 
-static int sx9310_write_close_debounce(struct sx9310_data *data, int val)
+static int sx9310_write_close_debounce(struct sx_common_data *data, int val)
 {
 	int ret;
 	unsigned int regval;
@@ -798,7 +630,7 @@ static int sx9310_write_event_val(struct iio_dev *indio_dev,
 				  enum iio_event_direction dir,
 				  enum iio_event_info info, int val, int val2)
 {
-	struct sx9310_data *data = iio_priv(indio_dev);
+	struct sx_common_data *data = iio_priv(indio_dev);
 
 	if (chan->type != IIO_PROXIMITY)
 		return -EINVAL;
@@ -822,7 +654,7 @@ static int sx9310_write_event_val(struct iio_dev *indio_dev,
 	}
 }
 
-static int sx9310_set_samp_freq(struct sx9310_data *data, int val, int val2)
+static int sx9310_set_samp_freq(struct sx_common_data *data, int val, int val2)
 {
 	int i, ret;
 
@@ -846,8 +678,8 @@ static int sx9310_set_samp_freq(struct sx9310_data *data, int val, int val2)
 	return ret;
 }
 
-static int sx9310_write_gain(struct sx9310_data *data,
-			    const struct iio_chan_spec *chan, int val)
+static int sx9310_write_gain(struct sx_common_data *data,
+			     const struct iio_chan_spec *chan, int val)
 {
 	unsigned int gain, mask;
 	int ret;
@@ -881,7 +713,7 @@ static int sx9310_write_raw(struct iio_dev *indio_dev,
 			    const struct iio_chan_spec *chan, int val, int val2,
 			    long mask)
 {
-	struct sx9310_data *data = iio_priv(indio_dev);
+	struct sx_common_data *data = iio_priv(indio_dev);
 
 	if (chan->type != IIO_PROXIMITY)
 		return -EINVAL;
@@ -896,238 +728,7 @@ static int sx9310_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static irqreturn_t sx9310_irq_handler(int irq, void *private)
-{
-	struct iio_dev *indio_dev = private;
-	struct sx9310_data *data = iio_priv(indio_dev);
-
-	if (data->trigger_enabled)
-		iio_trigger_poll(data->trig);
-
-	/*
-	 * Even if no event is enabled, we need to wake the thread to clear the
-	 * interrupt state by reading SX9310_REG_IRQ_SRC.
-	 * It is not possible to do that here because regmap_read takes a mutex.
-	 */
-	return IRQ_WAKE_THREAD;
-}
-
-static void sx9310_push_events(struct iio_dev *indio_dev)
-{
-	int ret;
-	unsigned int val, chan;
-	struct sx9310_data *data = iio_priv(indio_dev);
-	s64 timestamp = iio_get_time_ns(indio_dev);
-	unsigned long prox_changed;
-
-	/* Read proximity state on all channels */
-	ret = regmap_read(data->regmap, SX9310_REG_STAT0, &val);
-	if (ret) {
-		dev_err(&data->client->dev, "i2c transfer error in irq\n");
-		return;
-	}
-
-	/*
-	 * Only iterate over channels with changes on proximity status that have
-	 * events enabled.
-	 */
-	prox_changed = (data->chan_prox_stat ^ val) & data->chan_event;
-
-	for_each_set_bit(chan, &prox_changed, SX9310_NUM_CHANNELS) {
-		int dir;
-		u64 ev;
-
-		dir = (val & BIT(chan)) ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
-		ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan,
-					  IIO_EV_TYPE_THRESH, dir);
-
-		iio_push_event(indio_dev, ev, timestamp);
-	}
-	data->chan_prox_stat = val;
-}
-
-static irqreturn_t sx9310_irq_thread_handler(int irq, void *private)
-{
-	struct iio_dev *indio_dev = private;
-	struct sx9310_data *data = iio_priv(indio_dev);
-	int ret;
-	unsigned int val;
-
-	mutex_lock(&data->mutex);
-
-	ret = regmap_read(data->regmap, SX9310_REG_IRQ_SRC, &val);
-	if (ret) {
-		dev_err(&data->client->dev, "i2c transfer error in irq\n");
-		goto out;
-	}
-
-	if (val & (SX9310_FAR_IRQ | SX9310_CLOSE_IRQ))
-		sx9310_push_events(indio_dev);
-
-	if (val & SX9310_CONVDONE_IRQ)
-		complete(&data->completion);
-
-out:
-	mutex_unlock(&data->mutex);
-
-	return IRQ_HANDLED;
-}
-
-static int sx9310_read_event_config(struct iio_dev *indio_dev,
-				    const struct iio_chan_spec *chan,
-				    enum iio_event_type type,
-				    enum iio_event_direction dir)
-{
-	struct sx9310_data *data = iio_priv(indio_dev);
-
-	return !!(data->chan_event & BIT(chan->channel));
-}
-
-static int sx9310_write_event_config(struct iio_dev *indio_dev,
-				     const struct iio_chan_spec *chan,
-				     enum iio_event_type type,
-				     enum iio_event_direction dir, int state)
-{
-	struct sx9310_data *data = iio_priv(indio_dev);
-	unsigned int eventirq = SX9310_FAR_IRQ | SX9310_CLOSE_IRQ;
-	int ret;
-
-	/* If the state hasn't changed, there's nothing to do. */
-	if (!!(data->chan_event & BIT(chan->channel)) == state)
-		return 0;
-
-	mutex_lock(&data->mutex);
-	if (state) {
-		ret = sx9310_get_event_channel(data, chan->channel);
-		if (ret)
-			goto out_unlock;
-		if (!(data->chan_event & ~BIT(chan->channel))) {
-			ret = sx9310_enable_irq(data, eventirq);
-			if (ret)
-				sx9310_put_event_channel(data, chan->channel);
-		}
-	} else {
-		ret = sx9310_put_event_channel(data, chan->channel);
-		if (ret)
-			goto out_unlock;
-		if (!data->chan_event) {
-			ret = sx9310_disable_irq(data, eventirq);
-			if (ret)
-				sx9310_get_event_channel(data, chan->channel);
-		}
-	}
-
-out_unlock:
-	mutex_unlock(&data->mutex);
-	return ret;
-}
-
-static const struct iio_info sx9310_info = {
-	.read_raw = sx9310_read_raw,
-	.read_avail = sx9310_read_avail,
-	.read_event_value = sx9310_read_event_val,
-	.write_event_value = sx9310_write_event_val,
-	.write_raw = sx9310_write_raw,
-	.read_event_config = sx9310_read_event_config,
-	.write_event_config = sx9310_write_event_config,
-};
-
-static int sx9310_set_trigger_state(struct iio_trigger *trig, bool state)
-{
-	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
-	struct sx9310_data *data = iio_priv(indio_dev);
-	int ret = 0;
-
-	mutex_lock(&data->mutex);
-
-	if (state)
-		ret = sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);
-	else if (!data->chan_read)
-		ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
-	if (ret)
-		goto out;
-
-	data->trigger_enabled = state;
-
-out:
-	mutex_unlock(&data->mutex);
-
-	return ret;
-}
-
-static const struct iio_trigger_ops sx9310_trigger_ops = {
-	.set_trigger_state = sx9310_set_trigger_state,
-};
-
-static irqreturn_t sx9310_trigger_handler(int irq, void *private)
-{
-	struct iio_poll_func *pf = private;
-	struct iio_dev *indio_dev = pf->indio_dev;
-	struct sx9310_data *data = iio_priv(indio_dev);
-	__be16 val;
-	int bit, ret, i = 0;
-
-	mutex_lock(&data->mutex);
-
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
-		ret = sx9310_read_prox_data(data, &indio_dev->channels[bit],
-					    &val);
-		if (ret)
-			goto out;
-
-		data->buffer.channels[i++] = val;
-	}
-
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
-					   pf->timestamp);
-
-out:
-	mutex_unlock(&data->mutex);
-
-	iio_trigger_notify_done(indio_dev->trig);
-
-	return IRQ_HANDLED;
-}
-
-static int sx9310_buffer_preenable(struct iio_dev *indio_dev)
-{
-	struct sx9310_data *data = iio_priv(indio_dev);
-	unsigned long channels = 0;
-	int bit, ret;
-
-	mutex_lock(&data->mutex);
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength)
-		__set_bit(indio_dev->channels[bit].channel, &channels);
-
-	ret = sx9310_update_chan_en(data, channels, data->chan_event);
-	mutex_unlock(&data->mutex);
-	return ret;
-}
-
-static int sx9310_buffer_postdisable(struct iio_dev *indio_dev)
-{
-	struct sx9310_data *data = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&data->mutex);
-	ret = sx9310_update_chan_en(data, 0, data->chan_event);
-	mutex_unlock(&data->mutex);
-	return ret;
-}
-
-static const struct iio_buffer_setup_ops sx9310_buffer_setup_ops = {
-	.preenable = sx9310_buffer_preenable,
-	.postdisable = sx9310_buffer_postdisable,
-};
-
-struct sx9310_reg_default {
-	u8 reg;
-	u8 def;
-};
-
-static const struct sx9310_reg_default sx9310_default_regs[] = {
+static const struct sx_common_reg_default sx9310_default_regs[] = {
 	{ SX9310_REG_IRQ_MSK, 0x00 },
 	{ SX9310_REG_IRQ_FUNC, 0x00 },
 	/*
@@ -1172,7 +773,7 @@ static const struct sx9310_reg_default sx9310_default_regs[] = {
 /* Activate all channels and perform an initial compensation. */
 static int sx9310_init_compensation(struct iio_dev *indio_dev)
 {
-	struct sx9310_data *data = iio_priv(indio_dev);
+	struct sx_common_data *data = iio_priv(indio_dev);
 	int ret;
 	unsigned int val;
 	unsigned int ctrl0;
@@ -1202,9 +803,9 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static const struct sx9310_reg_default *
+static const struct sx_common_reg_default *
 sx9310_get_default_reg(struct device *dev, int idx,
-		       struct sx9310_reg_default *reg_def)
+		       struct sx_common_reg_default *reg_def)
 {
 	u32 combined[SX9310_NUM_CHANNELS];
 	u32 start = 0, raw = 0, pos = 0;
@@ -1305,42 +906,20 @@ sx9310_get_default_reg(struct device *dev, int idx,
 	return reg_def;
 }
 
-static int sx9310_init_device(struct iio_dev *indio_dev)
+static int sx9310_check_whoami(struct device *dev,
+			       struct iio_dev *indio_dev)
 {
-	struct sx9310_data *data = iio_priv(indio_dev);
-	struct sx9310_reg_default tmp;
-	const struct sx9310_reg_default *initval;
+	struct sx_common_data *data = iio_priv(indio_dev);
+	unsigned int long ddata;
+	unsigned int whoami;
 	int ret;
-	unsigned int i, val;
 
-	ret = regmap_write(data->regmap, SX9310_REG_RESET, SX9310_SOFT_RESET);
-	if (ret)
-		return ret;
-
-	usleep_range(1000, 2000); /* power-up time is ~1ms. */
-
-	/* Clear reset interrupt state by reading SX9310_REG_IRQ_SRC. */
-	ret = regmap_read(data->regmap, SX9310_REG_IRQ_SRC, &val);
-	if (ret)
+	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &whoami);
+	if (ret) {
+		dev_err(dev, "error in reading WHOAMI register: %d", ret);
 		return ret;
-
-	/* Program some sane defaults. */
-	for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
-		initval = sx9310_get_default_reg(&indio_dev->dev, i, &tmp);
-		ret = regmap_write(data->regmap, initval->reg, initval->def);
-		if (ret)
-			return ret;
 	}
 
-	return sx9310_init_compensation(indio_dev);
-}
-
-static int sx9310_set_indio_dev_name(struct device *dev,
-				     struct iio_dev *indio_dev,
-				     unsigned int whoami)
-{
-	unsigned int long ddata;
-
 	ddata = (uintptr_t)device_get_match_data(dev);
 	if (ddata != whoami) {
 		dev_err(dev, "WHOAMI does not match device data: %u\n", whoami);
@@ -1362,108 +941,47 @@ static int sx9310_set_indio_dev_name(struct device *dev,
 	return 0;
 }
 
-static void sx9310_regulator_disable(void *_data)
-{
-	struct sx9310_data *data = _data;
+static const struct sx_common_chip_info sx9310_chip_info = {
+	.reg_stat = SX9310_REG_STAT0,
+	.reg_irq_msk = SX9310_REG_IRQ_MSK,
+	.reg_enable_chan = SX9310_REG_PROX_CTRL0,
+	.reg_reset = SX9310_REG_RESET,
+
+	.mask_enable_chan = SX9310_REG_STAT1_COMPSTAT_MASK,
+	.irq_msk_offset = 3,
+	.num_channels = SX9310_NUM_CHANNELS,
+	.num_default_regs = ARRAY_SIZE(sx9310_default_regs),
+
+	.ops = {
+		.read_prox_data = sx9310_read_prox_data,
+		.check_whoami = sx9310_check_whoami,
+		.init_compensation = sx9310_init_compensation,
+		.wait_for_sample = sx9310_wait_for_sample,
+		.get_default_reg = sx9310_get_default_reg,
+	},
 
-	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
-}
+	.iio_channels = sx9310_channels,
+	.num_iio_channels = ARRAY_SIZE(sx9310_channels),
+	.iio_info =  {
+		.read_raw = sx9310_read_raw,
+		.read_avail = sx9310_read_avail,
+		.read_event_value = sx9310_read_event_val,
+		.write_event_value = sx9310_write_event_val,
+		.write_raw = sx9310_write_raw,
+		.read_event_config = sx_common_read_event_config,
+		.write_event_config = sx_common_write_event_config,
+	},
+};
 
 static int sx9310_probe(struct i2c_client *client)
 {
-	int ret;
-	struct device *dev = &client->dev;
-	struct iio_dev *indio_dev;
-	struct sx9310_data *data;
-
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	data = iio_priv(indio_dev);
-	data->client = client;
-	data->supplies[0].supply = "vdd";
-	data->supplies[1].supply = "svdd";
-	mutex_init(&data->mutex);
-	init_completion(&data->completion);
-
-	data->regmap = devm_regmap_init_i2c(client, &sx9310_regmap_config);
-	if (IS_ERR(data->regmap))
-		return PTR_ERR(data->regmap);
-
-	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
-				      data->supplies);
-	if (ret)
-		return ret;
-
-	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
-	if (ret)
-		return ret;
-	/* Must wait for Tpor time after initial power up */
-	usleep_range(1000, 1100);
-
-	ret = devm_add_action_or_reset(dev, sx9310_regulator_disable, data);
-	if (ret)
-		return ret;
-
-	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
-	if (ret) {
-		dev_err(dev, "error in reading WHOAMI register: %d", ret);
-		return ret;
-	}
-
-	ret = sx9310_set_indio_dev_name(dev, indio_dev, data->whoami);
-	if (ret)
-		return ret;
-
-	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
-	indio_dev->channels = sx9310_channels;
-	indio_dev->num_channels = ARRAY_SIZE(sx9310_channels);
-	indio_dev->info = &sx9310_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	i2c_set_clientdata(client, indio_dev);
-
-	ret = sx9310_init_device(indio_dev);
-	if (ret)
-		return ret;
-
-	if (client->irq) {
-		ret = devm_request_threaded_irq(dev, client->irq,
-						sx9310_irq_handler,
-						sx9310_irq_thread_handler,
-						IRQF_ONESHOT,
-						"sx9310_event", indio_dev);
-		if (ret)
-			return ret;
-
-		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
-						    indio_dev->name,
-						    iio_device_id(indio_dev));
-		if (!data->trig)
-			return -ENOMEM;
-
-		data->trig->ops = &sx9310_trigger_ops;
-		iio_trigger_set_drvdata(data->trig, indio_dev);
-
-		ret = devm_iio_trigger_register(dev, data->trig);
-		if (ret)
-			return ret;
-	}
-
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      sx9310_trigger_handler,
-					      &sx9310_buffer_setup_ops);
-	if (ret)
-		return ret;
-
-	return devm_iio_device_register(dev, indio_dev);
+	return sx_common_probe(client, &sx9310_chip_info, &sx9310_regmap_config);
 }
 
 static int __maybe_unused sx9310_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-	struct sx9310_data *data = iio_priv(indio_dev);
+	struct sx_common_data *data = iio_priv(indio_dev);
 	u8 ctrl0;
 	int ret;
 
@@ -1471,11 +989,11 @@ static int __maybe_unused sx9310_suspend(struct device *dev)
 
 	mutex_lock(&data->mutex);
 	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0,
-			  &data->suspend_ctrl0);
+			  &data->suspend_ctrl);
 	if (ret)
 		goto out;
 
-	ctrl0 = data->suspend_ctrl0 & ~SX9310_REG_PROX_CTRL0_SENSOREN_MASK;
+	ctrl0 = data->suspend_ctrl & ~SX9310_REG_PROX_CTRL0_SENSOREN_MASK;
 	ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0, ctrl0);
 	if (ret)
 		goto out;
@@ -1490,7 +1008,7 @@ static int __maybe_unused sx9310_suspend(struct device *dev)
 static int __maybe_unused sx9310_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-	struct sx9310_data *data = iio_priv(indio_dev);
+	struct sx_common_data *data = iio_priv(indio_dev);
 	int ret;
 
 	mutex_lock(&data->mutex);
@@ -1499,7 +1017,7 @@ static int __maybe_unused sx9310_resume(struct device *dev)
 		goto out;
 
 	ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
-			   data->suspend_ctrl0);
+			   data->suspend_ctrl);
 
 out:
 	mutex_unlock(&data->mutex);
diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
new file mode 100644
index 0000000000000..8a1164c6a8715
--- /dev/null
+++ b/drivers/iio/proximity/sx_common.c
@@ -0,0 +1,575 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 Google LLC.
+ *
+ * Driver for Semtech's SX9310/SX9311 capacitive proximity/button solution.
+ * Based on SX9500 driver and Semtech driver using the input framework
+ * <https://my.syncplicity.com/share/teouwsim8niiaud/
+ *          linux-driver-sx_common_NoSmartHSensing>.
+ * Reworked in April 2019 by Evan Green <evgreen@chromium.org>
+ * and in January 2020 by Daniel Campello <campello@chromium.org>.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+#include "sx_common.h"
+
+/* All Semtech SAR sensor have IRQ bit in same order. */
+#define   SX_COMMON_CONVDONE_IRQ			BIT(0)
+#define   SX_COMMON_FAR_IRQ				BIT(2)
+#define   SX_COMMON_CLOSE_IRQ				BIT(3)
+
+const struct iio_event_spec sx_common_events[3] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_HYSTERESIS) |
+				 BIT(IIO_EV_INFO_VALUE),
+	},
+};
+EXPORT_SYMBOL_GPL(sx_common_events);
+
+static irqreturn_t sx_common_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct sx_common_data *data = iio_priv(indio_dev);
+
+	if (data->trigger_enabled)
+		iio_trigger_poll(data->trig);
+
+	/*
+	 * Even if no event is enabled, we need to wake the thread to clear the
+	 * interrupt state by reading SX_COMMON_REG_IRQ_SRC.
+	 * It is not possible to do that here because regmap_read takes a mutex.
+	 */
+	return IRQ_WAKE_THREAD;
+}
+
+static void sx_common_push_events(struct iio_dev *indio_dev)
+{
+	int ret;
+	unsigned int val, chan;
+	struct sx_common_data *data = iio_priv(indio_dev);
+	s64 timestamp = iio_get_time_ns(indio_dev);
+	unsigned long prox_changed;
+
+	/* Read proximity state on all channels */
+	ret = regmap_read(data->regmap, data->info->reg_stat, &val);
+	if (ret) {
+		dev_err(&data->client->dev, "i2c transfer error in irq\n");
+		return;
+	}
+
+	/*
+	 * Only iterate over channels with changes on proximity status that have
+	 * events enabled.
+	 */
+	prox_changed = (data->chan_prox_stat ^ val) & data->chan_event;
+
+	for_each_set_bit(chan, &prox_changed, data->info->num_channels) {
+		int dir;
+		u64 ev;
+
+		dir = (val & BIT(chan)) ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
+		ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan,
+					  IIO_EV_TYPE_THRESH, dir);
+
+		iio_push_event(indio_dev, ev, timestamp);
+	}
+	data->chan_prox_stat = val;
+}
+
+static int sx_common_enable_irq(struct sx_common_data *data, unsigned int irq)
+{
+	if (!data->client->irq)
+		return 0;
+	return regmap_update_bits(data->regmap, data->info->reg_irq_msk,
+				  irq << data->info->irq_msk_offset,
+				  irq << data->info->irq_msk_offset);
+}
+
+static int sx_common_disable_irq(struct sx_common_data *data, unsigned int irq)
+{
+	if (!data->client->irq)
+		return 0;
+	return regmap_update_bits(data->regmap, data->info->reg_irq_msk,
+				  irq << data->info->irq_msk_offset, 0);
+}
+
+static int sx_common_update_chan_en(struct sx_common_data *data,
+				    unsigned long chan_read,
+				    unsigned long chan_event)
+{
+	int ret;
+	unsigned long channels = chan_read | chan_event;
+
+	if ((data->chan_read | data->chan_event) != channels) {
+		ret = regmap_update_bits(data->regmap,
+					 data->info->reg_enable_chan,
+					 data->info->mask_enable_chan,
+					 channels);
+		if (ret)
+			return ret;
+	}
+	data->chan_read = chan_read;
+	data->chan_event = chan_event;
+	return 0;
+}
+
+static int sx_common_get_read_channel(struct sx_common_data *data, int channel)
+{
+	return sx_common_update_chan_en(data, data->chan_read | BIT(channel),
+				     data->chan_event);
+}
+
+static int sx_common_put_read_channel(struct sx_common_data *data, int channel)
+{
+	return sx_common_update_chan_en(data, data->chan_read & ~BIT(channel),
+				     data->chan_event);
+}
+
+static int sx_common_get_event_channel(struct sx_common_data *data, int channel)
+{
+	return sx_common_update_chan_en(data, data->chan_read,
+				     data->chan_event | BIT(channel));
+}
+
+static int sx_common_put_event_channel(struct sx_common_data *data, int channel)
+{
+	return sx_common_update_chan_en(data, data->chan_read,
+				     data->chan_event & ~BIT(channel));
+}
+
+/**
+ * sx_common_read_proximity() - Read raw proximity value.
+ *
+ * @data:	Internal data
+ * @chan:	Channel to read
+ * @val:	pointer to return read value.
+ *
+ * Request a conversion, wait for the sensor to be ready and
+ * return the raw proximity value.
+ */
+int sx_common_read_proximity(struct sx_common_data *data,
+			     const struct iio_chan_spec *chan, int *val)
+{
+	int ret;
+	__be16 rawval;
+
+	mutex_lock(&data->mutex);
+
+	ret = sx_common_get_read_channel(data, chan->channel);
+	if (ret)
+		goto out;
+
+	ret = sx_common_enable_irq(data, SX_COMMON_CONVDONE_IRQ);
+	if (ret)
+		goto out_put_channel;
+
+	mutex_unlock(&data->mutex);
+
+	if (data->client->irq) {
+		ret = wait_for_completion_interruptible(&data->completion);
+		reinit_completion(&data->completion);
+	} else {
+		ret = data->info->ops.wait_for_sample(data);
+	}
+
+	mutex_lock(&data->mutex);
+
+	if (ret)
+		goto out_disable_irq;
+
+	ret = data->info->ops.read_prox_data(data, chan, &rawval);
+	if (ret)
+		goto out_disable_irq;
+
+	*val = sign_extend32(be16_to_cpu(rawval), chan->scan_type.realbits - 1);
+
+	ret = sx_common_disable_irq(data, SX_COMMON_CONVDONE_IRQ);
+	if (ret)
+		goto out_put_channel;
+
+	ret = sx_common_put_read_channel(data, chan->channel);
+	if (ret)
+		goto out;
+
+	mutex_unlock(&data->mutex);
+
+	return IIO_VAL_INT;
+
+out_disable_irq:
+	sx_common_disable_irq(data, SX_COMMON_CONVDONE_IRQ);
+out_put_channel:
+	sx_common_put_read_channel(data, chan->channel);
+out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sx_common_read_proximity);
+
+/**
+ * sx_common_read_event_config() - Configure event setting.
+ *
+ * @indio_dev:	iio device object
+ * @chan:	Channel to read
+ * @type:	Type of event (unused)
+ * @dir:	Direction of event (unused)
+ *
+ * return if the given channel is used for event gathering.
+ */
+int sx_common_read_event_config(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir)
+{
+	struct sx_common_data *data = iio_priv(indio_dev);
+
+	return !!(data->chan_event & BIT(chan->channel));
+}
+EXPORT_SYMBOL_GPL(sx_common_read_event_config);
+
+/**
+ * sx_common_write_event_config() - Configure event setting.
+ *
+ * @indio_dev:	iio device object
+ * @chan:	Channel to enable
+ * @type:	Type of event (unused)
+ * @dir:	Direction of event (unused)
+ * @state:	State of the event.
+ *
+ * Enable/Disable event on a given channel.
+ */
+int sx_common_write_event_config(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir, int state)
+{
+	struct sx_common_data *data = iio_priv(indio_dev);
+	unsigned int eventirq = SX_COMMON_FAR_IRQ | SX_COMMON_CLOSE_IRQ;
+	int ret;
+
+	/* If the state hasn't changed, there's nothing to do. */
+	if (!!(data->chan_event & BIT(chan->channel)) == state)
+		return 0;
+
+	mutex_lock(&data->mutex);
+	if (state) {
+		ret = sx_common_get_event_channel(data, chan->channel);
+		if (ret)
+			goto out_unlock;
+		if (!(data->chan_event & ~BIT(chan->channel))) {
+			ret = sx_common_enable_irq(data, eventirq);
+			if (ret)
+				sx_common_put_event_channel(data, chan->channel);
+		}
+	} else {
+		ret = sx_common_put_event_channel(data, chan->channel);
+		if (ret)
+			goto out_unlock;
+		if (!data->chan_event) {
+			ret = sx_common_disable_irq(data, eventirq);
+			if (ret)
+				sx_common_get_event_channel(data, chan->channel);
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sx_common_write_event_config);
+
+static int sx_common_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct sx_common_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	mutex_lock(&data->mutex);
+
+	if (state)
+		ret = sx_common_enable_irq(data, SX_COMMON_CONVDONE_IRQ);
+	else if (!data->chan_read)
+		ret = sx_common_disable_irq(data, SX_COMMON_CONVDONE_IRQ);
+	if (ret)
+		goto out;
+
+	data->trigger_enabled = state;
+
+out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static const struct iio_trigger_ops sx_common_trigger_ops = {
+	.set_trigger_state = sx_common_set_trigger_state,
+};
+
+static irqreturn_t sx_common_irq_thread_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct sx_common_data *data = iio_priv(indio_dev);
+	int ret;
+	unsigned int val;
+
+	mutex_lock(&data->mutex);
+
+	ret = regmap_read(data->regmap, SX_COMMON_REG_IRQ_SRC, &val);
+	if (ret) {
+		dev_err(&data->client->dev, "i2c transfer error in irq\n");
+		goto out;
+	}
+
+	if (val & ((SX_COMMON_FAR_IRQ | SX_COMMON_CLOSE_IRQ) << data->info->irq_msk_offset))
+		sx_common_push_events(indio_dev);
+
+	if (val & (SX_COMMON_CONVDONE_IRQ << data->info->irq_msk_offset))
+		complete(&data->completion);
+
+out:
+	mutex_unlock(&data->mutex);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t sx_common_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct sx_common_data *data = iio_priv(indio_dev);
+	__be16 val;
+	int bit, ret, i = 0;
+
+	mutex_lock(&data->mutex);
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		ret = data->info->ops.read_prox_data(data,
+						     &indio_dev->channels[bit],
+						     &val);
+		if (ret)
+			goto out;
+
+		data->buffer.channels[i++] = val;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
+					   pf->timestamp);
+
+out:
+	mutex_unlock(&data->mutex);
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int sx_common_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct sx_common_data *data = iio_priv(indio_dev);
+	unsigned long channels = 0;
+	int bit, ret;
+
+	mutex_lock(&data->mutex);
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->masklength)
+		__set_bit(indio_dev->channels[bit].channel, &channels);
+
+	ret = sx_common_update_chan_en(data, channels, data->chan_event);
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static int sx_common_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct sx_common_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret = sx_common_update_chan_en(data, 0, data->chan_event);
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops sx_common_buffer_setup_ops = {
+	.preenable = sx_common_buffer_preenable,
+	.postdisable = sx_common_buffer_postdisable,
+};
+
+static void sx_common_regulator_disable(void *_data)
+{
+	struct sx_common_data *data = _data;
+
+	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
+}
+
+#define SX_COMMON_SOFT_RESET				0xde
+
+static int sx_common_init_device(struct iio_dev *indio_dev)
+{
+	struct sx_common_data *data = iio_priv(indio_dev);
+	struct sx_common_reg_default tmp;
+	const struct sx_common_reg_default *initval;
+	int ret;
+	unsigned int i, val;
+
+	ret = regmap_write(data->regmap, data->info->reg_reset, SX_COMMON_SOFT_RESET);
+	if (ret)
+		return ret;
+
+	usleep_range(1000, 2000); /* power-up time is ~1ms. */
+
+	/* Clear reset interrupt state by reading SX_COMMON_REG_IRQ_SRC. */
+	ret = regmap_read(data->regmap, SX_COMMON_REG_IRQ_SRC, &val);
+	if (ret)
+		return ret;
+
+	/* Program some sane defaults. */
+	for (i = 0; i < data->info->num_default_regs; i++) {
+		initval = data->info->ops.get_default_reg(&indio_dev->dev,
+							  i, &tmp);
+		ret = regmap_write(data->regmap, initval->reg, initval->def);
+		if (ret)
+			return ret;
+	}
+
+	return data->info->ops.init_compensation(indio_dev);
+}
+
+/**
+ * sx_common_probe() - Common setup for Semtech SAR sensor
+ *
+ * @client:		I2C client object
+ * @info:		Semtech sensor chip information.
+ * @regmap_config:	Sensor registers map configuration.
+ */
+int sx_common_probe(struct i2c_client *client,
+		    const struct sx_common_chip_info *info,
+		    const struct regmap_config *regmap_config)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct sx_common_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	data->info = info;
+	data->client = client;
+	data->supplies[0].supply = "vdd";
+	data->supplies[1].supply = "svdd";
+	mutex_init(&data->mutex);
+	init_completion(&data->completion);
+
+	data->regmap = devm_regmap_init_i2c(client, regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
+				      data->supplies);
+	if (ret)
+		return ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
+	if (ret)
+		return ret;
+	/* Must wait for Tpor time after initial power up */
+	usleep_range(1000, 1100);
+
+	ret = devm_add_action_or_reset(dev, sx_common_regulator_disable, data);
+	if (ret)
+		return ret;
+
+	ret = data->info->ops.check_whoami(dev, indio_dev);
+	if (ret) {
+		dev_err(dev, "error in reading WHOAMI register: %d", ret);
+		return ret;
+	}
+
+	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	indio_dev->channels =  data->info->iio_channels;
+	indio_dev->num_channels = data->info->num_iio_channels;
+	indio_dev->info = &data->info->iio_info;
+
+	i2c_set_clientdata(client, indio_dev);
+
+	ret = sx_common_init_device(indio_dev);
+	if (ret)
+		return ret;
+
+	if (client->irq) {
+		ret = devm_request_threaded_irq(dev, client->irq,
+						sx_common_irq_handler,
+						sx_common_irq_thread_handler,
+						IRQF_ONESHOT,
+						"sx_event", indio_dev);
+		if (ret)
+			return ret;
+
+		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						    indio_dev->name,
+						    iio_device_id(indio_dev));
+		if (!data->trig)
+			return -ENOMEM;
+
+		data->trig->ops = &sx_common_trigger_ops;
+		iio_trigger_set_drvdata(data->trig, indio_dev);
+
+		ret = devm_iio_trigger_register(dev, data->trig);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      sx_common_trigger_handler,
+					      &sx_common_buffer_setup_ops);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_GPL(sx_common_probe);
+
+MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
+MODULE_DESCRIPTION("Common functions and structures for Semtech sensor");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
new file mode 100644
index 0000000000000..7f4d696ca16d3
--- /dev/null
+++ b/drivers/iio/proximity/sx_common.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Code shared between most Semtech SAR sensor driver.
+ */
+
+#ifndef IIO_SX_COMMON_H
+#define IIO_SX_COMMON_H
+
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#define SX_COMMON_REG_IRQ_SRC				0x00
+
+#define   SX9310_WHOAMI_VALUE				0x01
+#define   SX9311_WHOAMI_VALUE				0x02
+#define   SX9324_WHOAMI_VALUE				0x23
+#define   SX9360_WHOAMI_VALUE				0x60
+
+#define SX_COMMON_MAX_NUM_CHANNELS	4
+static_assert(SX_COMMON_MAX_NUM_CHANNELS < BITS_PER_LONG);
+
+struct sx_common_data;
+
+struct sx_common_reg_default {
+	u8 reg;
+	u8 def;
+};
+
+/** sx_common_ops: function pointers needed by common code
+ *
+ * List functions needed by common code to gather information or configure
+ * the sensor.
+ *
+ * @read_prox_data:	Function to read raw proximity data.
+ * @check_whoami:	Set device name based on whoami register.
+ * @init_compensation:	Function to set initial compensation.
+ * @wait_for_sample:	When there are no physical IRQ, function to wait for a
+ *			sample to be ready.
+ */
+struct sx_common_ops {
+	int (*read_prox_data)(struct sx_common_data *data,
+			      const struct iio_chan_spec *chan, __be16 *val);
+	int (*check_whoami)(struct device *dev, struct iio_dev *indio_dev);
+	int (*init_compensation)(struct iio_dev *indio_dev);
+	int (*wait_for_sample)(struct sx_common_data *data);
+	const struct sx_common_reg_default  *
+		(*get_default_reg)(struct device *dev, int idx,
+				   struct sx_common_reg_default *reg_def);
+};
+
+/**
+ * struct sx_common_chip_info: Semtech Sensor private chip information
+ *
+ * @reg_stat:		Main status register address.
+ * @reg_irq_msk:	IRQ mask register address.
+ * @reg_enable_chan:	Address to enable/disable channels/phases.
+ * @reg_reset:		Reset register address.
+ *
+ * @mask_enable_chan:	Mask over the channels bits in the enable channel
+ *			register.
+ * @irq_msk_offset:	Offset to enable interrupt in the IRQ mask
+ *			register.
+ *
+ * @num_channels:	Number of channel/phase.
+ * @num_default_regs:	Number of internal registers that can be configured.
+ *
+ * @ops:		Private functions pointers.
+ *
+ * @iio_channels:	Description of exposed iio channels.
+ * @num_iio_channels:	Number of iio_channels.
+ * @iio_info:		iio_info structure for this driver.
+ *
+ */
+struct sx_common_chip_info {
+	unsigned int reg_stat;
+	unsigned int reg_irq_msk;
+	unsigned int reg_enable_chan;
+	unsigned int reg_reset;
+
+	unsigned int mask_enable_chan;
+	unsigned int irq_msk_offset;
+	unsigned int num_channels;
+	int num_default_regs;
+
+	struct sx_common_ops ops;
+
+	const struct iio_chan_spec *iio_channels;
+	int num_iio_channels;
+	struct iio_info iio_info;
+};
+
+/**
+ * struct sx_common_data: Semtech Sensor private data structure.
+ *
+ * @info:		Structure defining sensor internals.
+ * @mutex:		Serialize access to registers and channel configuration.
+ * @num_channels:	Number of channel/phase.
+ * @completion:		completion object to wait for data acquisition.
+ * @client:		I2C client structure.
+ * @trig:		IIO trigger object.
+ * @regmap:		Register map.
+ *
+ * @num_default_regs:	Number of default registers to set at init.
+ * @supplies:		Power supplies object.
+ * @chan_prox_stat:	Last reading of the proximity status for each channel.
+ *			We only send an event to user space when this changes.
+ * @trigger_enabled:	True when the device trigger is enabled.
+ *
+ * @buffer:		Bufffer to store raw samples.
+ * @suspend_ctrl:	Remember enabled channels and sample rate during suspend.
+ * @chan_read:		Bit field for each raw channel enabled.
+ * @chan_event:		Bit field for each event enabled.
+ *
+ */
+struct sx_common_data {
+	const struct sx_common_chip_info *info;
+
+	struct mutex mutex;
+	struct completion completion;
+	struct i2c_client *client;
+	struct iio_trigger *trig;
+	struct regmap *regmap;
+
+	struct regulator_bulk_data supplies[2];
+	unsigned long chan_prox_stat;
+	bool trigger_enabled;
+
+	/* Ensure correct alignment of timestamp when present. */
+	struct {
+		__be16 channels[SX_COMMON_MAX_NUM_CHANNELS];
+		s64 ts __aligned(8);
+	} buffer;
+
+	unsigned int suspend_ctrl;
+	unsigned long chan_read;
+	unsigned long chan_event;
+};
+
+int sx_common_read_proximity(struct sx_common_data *data,
+			     const struct iio_chan_spec *chan, int *val);
+
+int sx_common_read_event_config(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir);
+int sx_common_write_event_config(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir, int state);
+
+int sx_common_probe(struct i2c_client *client,
+		    const struct sx_common_chip_info *info,
+		    const struct regmap_config *regmap_config);
+
+/* 3 is the number of events defined by a single phase. */
+extern const struct iio_event_spec sx_common_events[3];
+
+#endif  /* IIO_SX_COMMON_H */
-- 
2.33.1.1089.g2158813163f-goog

