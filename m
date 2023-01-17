Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957CC66E789
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 21:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjAQUK5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 15:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjAQUHO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 15:07:14 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A765A34B
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 11:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673982028;
  x=1705518028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YlTUjdTUJZQCCc0ZOp+dsknWUFivXvJZeLHw5SFxuA4=;
  b=ndylIYma+4XpLTi2kGARBvmxcnvn5A8JErqFxsISP4MqYEp6N6C+ZP9A
   ezsBQIXS3S1CXzv7dOgIP1gAPf7dnpriho2xgIPe9sh1u8bejVvMWsmYM
   rxMm+AnEXVqlH7Hu4FJTEsWjzf86zVs0fPwtF410kuvoGnz9rgMuWRMlf
   /T+wnTqoPfekXsEMicjWmU/CwQkoeEg3enPMR9E7c1zMNTTwqeNzNu5o1
   CWchKJ7o23VCTghYMjDktDm/HY14aqRMcJEAGKMr/TvMHP1cpKvprnWJg
   2UUIHH4iAKTbiXY/Yc8spT+j3PXKhVhcyw0n9f3MfFMVN+jAlcWtOL6QR
   w==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v5 3/3] iio: light: vcnl4000: Add interrupt support for vcnl4040
Date:   Tue, 17 Jan 2023 20:00:17 +0100
Message-ID: <20230117190017.3789181-4-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230117190017.3789181-1-marten.lindahl@axis.com>
References: <20230117190017.3789181-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to configure proximity sensor interrupts and threshold
limits for vcnl4040. If an interrupt is detected an event will be
pushed to the event interface.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/light/vcnl4000.c | 169 +++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index b2f60f3f8d44..6bdfce9747f9 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -60,8 +60,11 @@
 
 #define VCNL4200_AL_CONF	0x00 /* Ambient light configuration */
 #define VCNL4200_PS_CONF1	0x03 /* Proximity configuration */
+#define VCNL4040_PS_THDL_LM	0x06 /* Proximity threshold low */
+#define VCNL4040_PS_THDH_LM	0x07 /* Proximity threshold high */
 #define VCNL4200_PS_DATA	0x08 /* Proximity data */
 #define VCNL4200_AL_DATA	0x09 /* Ambient light data */
+#define VCNL4040_INT_FLAGS	0x0b /* Interrupt register */
 #define VCNL4200_DEV_ID		0x0e /* Device ID, slave address and version */
 
 #define VCNL4040_DEV_ID		0x0c /* Device ID and version */
@@ -78,6 +81,9 @@
 #define VCNL4040_ALS_CONF_ALS_SHUTDOWN	BIT(0)
 #define VCNL4040_PS_CONF1_PS_SHUTDOWN	BIT(0)
 #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration time */
+#define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mode */
+#define VCNL4040_PS_IF_AWAY		BIT(8) /* Proximity event cross low threshold */
+#define VCNL4040_PS_IF_CLOSE		BIT(9) /* Proximity event cross high threshold */
 
 /* Bit masks for interrupt registers. */
 #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt source */
@@ -138,6 +144,7 @@ struct vcnl4000_data {
 	enum vcnl4000_device_ids id;
 	int rev;
 	int al_scale;
+	u8 ps_int;		/* proximity interrupt mode */
 	const struct vcnl4000_chip_spec *chip_spec;
 	struct mutex vcnl4000_lock;
 	struct vcnl4200_channel vcnl4200_al;
@@ -256,6 +263,10 @@ static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
 {
 	int ret;
 
+	/* Do not power down if interrupts are enabled */
+	if (!on && data->ps_int)
+		return 0;
+
 	ret = vcnl4000_write_als_enable(data, on);
 	if (ret < 0)
 		return ret;
@@ -297,6 +308,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	dev_dbg(&data->client->dev, "device id 0x%x", id);
 
 	data->rev = (ret >> 8) & 0xf;
+	data->ps_int = 0;
 
 	data->vcnl4200_al.reg = VCNL4200_AL_DATA;
 	data->vcnl4200_ps.reg = VCNL4200_PS_DATA;
@@ -797,6 +809,64 @@ static int vcnl4010_write_event(struct iio_dev *indio_dev,
 	}
 }
 
+static int vcnl4040_read_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int *val, int *val2)
+{
+	int ret;
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = i2c_smbus_read_word_data(data->client,
+					       VCNL4040_PS_THDH_LM);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	case IIO_EV_DIR_FALLING:
+		ret = i2c_smbus_read_word_data(data->client,
+					       VCNL4040_PS_THDL_LM);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl4040_write_event(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	int ret;
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = i2c_smbus_write_word_data(data->client,
+						VCNL4040_PS_THDH_LM, val);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_EV_DIR_FALLING:
+		ret = i2c_smbus_write_word_data(data->client,
+						VCNL4040_PS_THDL_LM, val);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
 static bool vcnl4010_is_thr_enabled(struct vcnl4000_data *data)
 {
 	int ret;
@@ -879,6 +949,86 @@ static int vcnl4010_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
+static int vcnl4040_read_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir)
+{
+	int ret;
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		return ret;
+
+	data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, ret);
+
+	return (dir == IIO_EV_DIR_RISING) ?
+		FIELD_GET(VCNL4040_PS_IF_AWAY, ret) :
+		FIELD_GET(VCNL4040_PS_IF_CLOSE, ret);
+}
+
+static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir, int state)
+{
+	int ret;
+	u16 val, mask;
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		goto out;
+
+	if (dir == IIO_EV_DIR_RISING)
+		mask = VCNL4040_PS_IF_AWAY;
+	else
+		mask = VCNL4040_PS_IF_CLOSE;
+
+	val = state ? (ret | mask) : (ret & ~mask);
+
+	data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, val);
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
+
+out:
+	mutex_unlock(&data->vcnl4000_lock);
+	data->chip_spec->set_power_state(data, data->ps_int != 0);
+
+	return ret;
+}
+
+static irqreturn_t vcnl4040_irq_thread(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4040_INT_FLAGS);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	if (ret & VCNL4040_PS_IF_CLOSE) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       iio_get_time_ns(indio_dev));
+	}
+
+	if (ret & VCNL4040_PS_IF_AWAY) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       iio_get_time_ns(indio_dev));
+	}
+
+	return IRQ_HANDLED;
+}
+
 static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
 					uintptr_t priv,
 					const struct iio_chan_spec *chan,
@@ -1042,6 +1192,18 @@ static const struct iio_event_spec vcnl4000_event_spec[] = {
 	}
 };
 
+static const struct iio_event_spec vcnl4040_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_chan_spec vcnl4000_channels[] = {
 	{
 		.type = IIO_LIGHT,
@@ -1090,6 +1252,8 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
 			BIT(IIO_CHAN_INFO_INT_TIME),
 		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
 		.ext_info = vcnl4000_ext_info,
+		.event_spec = vcnl4040_event_spec,
+		.num_event_specs = ARRAY_SIZE(vcnl4040_event_spec),
 	}
 };
 
@@ -1110,6 +1274,10 @@ static const struct iio_info vcnl4010_info = {
 static const struct iio_info vcnl4040_info = {
 	.read_raw = vcnl4000_read_raw,
 	.write_raw = vcnl4040_write_raw,
+	.read_event_value = vcnl4040_read_event,
+	.write_event_value = vcnl4040_write_event,
+	.read_event_config = vcnl4040_read_event_config,
+	.write_event_config = vcnl4040_write_event_config,
 	.read_avail = vcnl4040_read_avail,
 };
 
@@ -1146,6 +1314,7 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.channels = vcnl4040_channels,
 		.num_channels = ARRAY_SIZE(vcnl4040_channels),
 		.info = &vcnl4040_info,
+		.irq_thread = vcnl4040_irq_thread,
 	},
 	[VCNL4200] = {
 		.prod = "VCNL4200",
-- 
2.30.2

